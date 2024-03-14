package com.example.fieldpolling.services;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DynamicTableService {

    private final JdbcTemplate jdbcTemplate;

    public DynamicTableService(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Map<String, Object>> getDynamicTableContents(String tableName) {
        String query = "SELECT * FROM " + tableName;

        return jdbcTemplate.query(query, (rs, rowNum) -> mapResultSetToDynamicStructure(rs));
    }

    private Map<String, Object> mapResultSetToDynamicStructure(ResultSet rs) throws SQLException {
        Map<String, Object> dynamicRow = new HashMap<>();

        int columnCount = rs.getMetaData().getColumnCount();
        for (int i = 1; i <= columnCount; i++) {
            String columnName = rs.getMetaData().getColumnName(i);
            Object columnValue = rs.getObject(i);
            dynamicRow.put(columnName, columnValue);
        }

        return dynamicRow;
    }
}