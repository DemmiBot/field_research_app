package com.example.fieldresearch.dtos;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

// Data Transfer Object boy
public record UserRecordDto(@NotBlank String name, @NotBlank String email, @NotNull Boolean is_admin) {
    
}

/*    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private UUID user_id;
    private String name;
    @Column(unique=true)
    private String email;
    private boolean is_admin; */