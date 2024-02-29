package com.example.fieldpolling.repositories;

import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.models.Poll;


@Repository
public interface PollRepository extends JpaRepository<Poll, UUID> {
    @Procedure("create_table_type1")
    public void createTableType1(String t_name, String t_options);

}

/*CREATE OR REPLACE PROCEDURE create_table_type1(t_name varchar(30), t_options text)
  LANGUAGE plpgsql AS
$func$
BEGIN
   EXECUTE format('
      CREATE TABLE IF NOT EXISTS %I (
       id serial PRIMARY KEY,
       %I
      )', t_name, t_options);
END
$func$;*/