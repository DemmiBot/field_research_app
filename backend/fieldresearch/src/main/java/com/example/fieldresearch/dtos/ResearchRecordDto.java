package com.example.fieldresearch.dtos;

import com.example.fieldresearch.helpers.Status;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

// Data Transfer Object boy
public record ResearchRecordDto(@NotBlank String name, @NotBlank String description, @NotNull Status status) {
    
}

/*    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private UUID research_id;
    @Column(unique=true)
    private String name;   
    private String description;
    @Enumerated(EnumType.STRING)
    private Status status; */