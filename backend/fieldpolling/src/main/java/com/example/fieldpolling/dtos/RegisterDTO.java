package com.example.fieldpolling.dtos;

import com.example.fieldpolling.helpers.UserRole;

public record RegisterDTO(String email, String username, String password, UserRole role) {
    
}