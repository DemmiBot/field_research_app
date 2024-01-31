package com.example.dtos;

import jakarta.validation.constraints.NotBlank;

// Data Transfer Object boy
public record UserRecordDto(@NotBlank String name, @NotBlank String email, Boolean is_admin) {
    
}

/*    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private UUID user_id;
    private String name;
    @Column(unique=true)
    private String email;
    private boolean is_admin; */