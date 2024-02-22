package com.example.fieldpolling.dtos;

import com.example.fieldpolling.models.User;

public record LoginResponseDTO(String token, User user) {
    
}
