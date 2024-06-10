package com.example.fieldpolling.dtos;

import com.example.fieldpolling.domain.User;

public record LoginResponseDTO(String token, User user) {
    
}
