package com.example.fieldpolling.services;

import org.hibernate.Session;

/* ARIGATO GOZAIMASU, GPT-SAN! */
import org.springframework.stereotype.Service;

import com.example.fieldpolling.helpers.Option;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.transaction.Transactional;

import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DynamicTableService {

    @PersistenceContext
    private EntityManager entityManager;

    public Map<String, String> getColumnNamesAndTypes(String tableName) {
        Map<String, String> columnNamesAndTypes = new LinkedHashMap<>();
        try {
            Session session = entityManager.unwrap(Session.class);
            session.doWork(connection -> {
                DatabaseMetaData metaData = connection.getMetaData();
                ResultSet rs = metaData.getColumns(null, null, tableName, null);
                while (rs.next()) {
                    String columnName = rs.getString("COLUMN_NAME");
                    String columnType = rs.getString("TYPE_NAME");
                    columnNamesAndTypes.put(columnName, columnType);
                }
            });
        } catch (Exception e) {
            // Handle exception
            e.printStackTrace();
        }
        return columnNamesAndTypes;
    }

    @Transactional
    public void insertRow(String tableName, Map<String, Object> rowData) {
        StringBuilder insertQuery = new StringBuilder("INSERT INTO ").append(tableName).append(" (");
        StringBuilder valuesQuery = new StringBuilder(" VALUES (");
        
        // Construct the column names and values part of the insert query
        for (String columnName : rowData.keySet()) {
            insertQuery.append(columnName).append(",");
            valuesQuery.append(":").append(columnName).append(",");
        }
        insertQuery.deleteCharAt(insertQuery.length() - 1).append(")");
        valuesQuery.deleteCharAt(valuesQuery.length() - 1).append(")");

        // Construct the final insert query
        String finalInsertQuery = insertQuery.toString() + valuesQuery.toString();

        // Execute the insert query
        Query query = entityManager.createNativeQuery(finalInsertQuery);

        // Set parameter values
        for (Map.Entry<String, Object> entry : rowData.entrySet()) {
            query.setParameter(entry.getKey(), entry.getValue());
        }
        query.executeUpdate();
    }

    public List<Map<String, Object>> getDynamicTableContents(String tableName) {    
        /* Melhor maneira de fazer queries através do spring? Não sei, mas é oq tem agora */
        /* Codigo feito pelo chatgpt ;-; */
        String queryStr = "SELECT * FROM " + tableName;
        Query query = entityManager.createNativeQuery(queryStr);

        List<Object[]> resultList = query.getResultList();

        Map<String, String> columnMetadata = getColumnNamesAndTypes(tableName);

        List<String> columnNames = new ArrayList<>();

        for(String columnName: columnMetadata.keySet()) {
            columnNames.add(columnName);
        }

        return mapResultListToDynamicStructure(resultList, columnNames);
    }

    private List<Map<String, Object>> mapResultListToDynamicStructure(List<Object[]> resultList, List<String> columnNames) {
        return resultList.stream()
                .map(row -> mapRowToMap(row, columnNames))
                .collect(Collectors.toList());
    }

    private Map<String, Object> mapRowToMap(Object[] row, List<String> columnNames) {
        Map<String, Object> dynamicRow = new HashMap<>();
        for (int i = 0; i < row.length && i < columnNames.size(); i++) {
            dynamicRow.put(columnNames.get(i), row[i]);
        }
        return dynamicRow;
    }

    @Transactional
    public void createTable(String tableName, List<Option> options) throws SQLException {
        try {
            String optionsString = optionsToString(options);
            String query = "CREATE TABLE " + tableName + "(id SERIAL PRIMARY KEY" + optionsString +")";
            entityManager.createNativeQuery(query).executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Error creating table: ", e);
        }
    }    
    
    @Transactional
    public void dropTable(String tableName) throws SQLException {
        try {
            String query = "DROP TABLE " + tableName;
            entityManager.createNativeQuery(query).executeUpdate();
        } catch (Exception e) {
            throw new RuntimeException("Error creating table: ", e);
        }
    }
    
    public String optionsToString(List<Option> options) {
        StringBuilder columnStrings = new StringBuilder();
           for(Option opt: options) {
              columnStrings.append(", " + opt.getOptionName());
              columnStrings.append(" " + opt.getOptionType());
            }
        return columnStrings.toString();
    }

}