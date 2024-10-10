package com.example.fieldpolling.dtos;

import java.util.List;

public record EntryDTO(Long pollId, List<String> responses) {
    // public static record Answer(Long questionId, String answer) {
    // }
}