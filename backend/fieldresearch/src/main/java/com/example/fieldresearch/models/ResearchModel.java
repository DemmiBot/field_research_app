package com.example.fieldresearch.models;

import java.io.Serializable;
import java.util.UUID;

import com.example.fieldresearch.helpers.Status;

import jakarta.persistence.*;


@Entity
@Table(name = "researches")
public class ResearchModel implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private UUID research_id;
    @Column(unique=true)
    private String name;   
    private String description;
    @Enumerated(EnumType.STRING)
    private Status status;

    public UUID getResearch_id() {
        return research_id;
    }
    public void setResearch_id(UUID Research_id) {
        this.research_id = research_id;
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
