package com.example.fieldpolling.dtos;

import com.example.fieldpolling.helpers.UserRole;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

// Data Transfer Object boy
public record UserRecordDto(@NotBlank String login, @NotBlank String email, @NotBlank String password, @NotNull UserRole role) {
    
}
