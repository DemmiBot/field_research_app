package com.example.fieldpolling.models;

import java.io.Serializable;
import java.util.UUID;

import com.example.fieldpolling.helpers.Status;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedStoredProcedureQuery;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.StoredProcedureParameter;
import jakarta.persistence.Table;


@Entity
@NamedStoredProcedureQuery(name = "create_table_type1", procedureName = "create_table", parameters = {
  @StoredProcedureParameter(mode = ParameterMode.IN, name = "t_name", type = String.class)})
@Table(name = "polls")
public class Poll implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private UUID poll_id;
    @Column(unique=true)
    private String name;   
    private String description;
    @Enumerated(EnumType.STRING)
    private Status status;

    public UUID getpoll_id() {
        return poll_id;
    }
    public void setpoll_id(UUID poll_id) {
        this.poll_id = poll_id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public Status getStatus() {
        return status;
    }
    public void setStatus(Status status) {
        this.status = status;
    }
}
