package com.example.fieldpolling.dtos;

import java.util.List;

import com.example.fieldpolling.helpers.Status;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.NotEmpty;

public record PollRecordDTO(@NotBlank String title, @NotBlank String description, @NotNull Status status, @NotEmpty List<Question> questions) {
    /* Type é o tipo de resposta esperado (textual, numérica etc... Open ended por enquanto, estudar colocar um enum para tipos suportados) */
    public static record Question(@NotBlank String text, @NotBlank String type) {
    }
}

/*
{
  "title": "Customer Satisfaction Survey",
  "description": "A survey to gauge customer satisfaction levels.",
  "status": "OPEN",  // Status is an enum, it's values are OPEN, CLOSED
  "questions": [
    {
      "text": "How satisfied are you with our service?",
      "type": "open_ended"  // Could be "open_ended", "numerical", etc.
    },
    {
      "text": "What can we improve?",
      "type": "open_ended"
    }
  ]
}
*/