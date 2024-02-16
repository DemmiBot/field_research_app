package com.example.fieldpolling.dtos;

import com.example.fieldpolling.helpers.Status;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

// Data Transfer Object boy
public record ResearchRecordDto(@NotBlank String name, @NotBlank String description, @NotNull Status status) {
    
}