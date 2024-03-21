package com.example.fieldpolling.services;

/* ARIGATO GOZAIMASU, GPT-SAN! */
import org.springframework.stereotype.Service;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class DynamicTableService {

    @PersistenceContext
    private EntityManager entityManager;

    public List<Map<String, Object>> getDynamicTableContents(String tableName) {
        String queryStr = "SELECT * FROM " + tableName;
        Query query = entityManager.createNativeQuery(queryStr);

        List<Object[]> resultList = query.getResultList();

        return mapResultListToDynamicStructure(resultList);
    }

    private List<Map<String, Object>> mapResultListToDynamicStructure(List<Object[]> resultList) {
        return resultList.stream()
                .map(this::mapRowToMap)
                .collect(Collectors.toList());
    }

    private Map<String, Object> mapRowToMap(Object[] row) {
        // Assuming the columns are returned in the same order as defined in the query
        Map<String, Object> dynamicRow = new HashMap<>();
        for (int i = 0; i < row.length; i++) {
            dynamicRow.put("column" + i, row[i]);
        }
        return dynamicRow;
    }
}