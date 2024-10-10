package com.example.fieldpolling.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;

import com.example.fieldpolling.dtos.EntryDTO;
import com.example.fieldpolling.models.Entry;
import com.example.fieldpolling.models.Poll;
import com.example.fieldpolling.repositories.EntryRepository;
import com.example.fieldpolling.repositories.PollRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/entries")
public class EntryController {

    @Autowired
    private EntryRepository entryRepository;

    @Autowired
    private PollRepository pollRepository;

    @Autowired
    private ObjectMapper objectMapper;

    @PostMapping
    public ResponseEntity<?> createEntry(@Valid @RequestBody EntryDTO entryDTO) throws JsonProcessingException {
        Poll poll = pollRepository.findById(entryDTO.pollId())
            .orElseThrow(() -> new RuntimeException("Poll not found"));

        Entry entry = new Entry();
        // Copy properties from DTO to entity (except responses)
        BeanUtils.copyProperties(entryDTO, entry, "responses");

        // Use ObjectMapper to serialize responses to JSON
        entry.setResponses(objectMapper.writeValueAsString(entryDTO.responses()));

        entry.setPoll(poll);
        entryRepository.save(entry);
        return ResponseEntity.ok("Entry created successfully");
    }
}
