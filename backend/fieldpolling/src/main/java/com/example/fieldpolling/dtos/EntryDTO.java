package com.example.fieldpolling.dtos;

import java.util.List;

import com.example.fieldpolling.domain.Option;

public record EntryDTO(String pollId, List<Option> options) {
    
}