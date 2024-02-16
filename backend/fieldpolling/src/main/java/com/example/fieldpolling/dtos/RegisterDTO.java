package com.example.fieldpolling.dtos;

import com.example.fieldpolling.helpers.UserRole;

public record RegisterDTO(String login, String password, UserRole role) {
    
}
