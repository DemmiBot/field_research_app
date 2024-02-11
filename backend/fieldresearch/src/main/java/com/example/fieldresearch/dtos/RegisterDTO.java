package com.example.fieldresearch.dtos;

import com.example.fieldresearch.helpers.UserRole;

public record RegisterDTO(String login, String password, UserRole role) {
    
}
