package com.example.fieldpolling.dtos;

import java.util.List;

import com.example.fieldpolling.helpers.Option;
import com.example.fieldpolling.helpers.Status;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.NotEmpty;

// Data Transfer Object boy
public record PollRecordDTO(@NotBlank String name, @NotBlank String description, @NotNull Status status, @NotEmpty List<Option> options) {
     
}