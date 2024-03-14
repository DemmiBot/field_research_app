package com.example.fieldpolling.repositories;

import java.sql.SQLException;
import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.models.Poll;


@Repository
public interface PollRepository extends JpaRepository<Poll, UUID> {
    @Procedure("createtable")
    public void createTable(String t_name) throws SQLException;

    @Procedure("addcolumn")
    public void addColumn(String t_name, String c_name, String c_type) throws SQLException;

}