package com.example.fieldresearch.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

// Data Transfer Object boy
public record UserRecordDto(@NotBlank String name, @NotBlank String email, @NotNull Boolean is_admin) {
    
}