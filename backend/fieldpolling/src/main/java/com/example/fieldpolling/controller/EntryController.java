package com.example.fieldpolling.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;

import com.example.fieldpolling.dtos.EntryDTO;
import com.example.fieldpolling.dtos.EntryResponseDTO;
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
    // Probably not usable
    // @GetMapping
    // public ResponseEntity<List<EntryResponseDTO>> getAllEntries() {
    //     List<Entry> entries = entryRepository.findAll();
    //     List<EntryResponseDTO> entryResponseDTOs = entries.stream()
    //             .map(entry -> new EntryResponseDTO(entry.getEntryId(), entry.getResponses()))
    //             .collect(Collectors.toList());
    //     return ResponseEntity.status(HttpStatus.OK).body(entryResponseDTOs);
    // }

    @GetMapping
    public ResponseEntity<List<Entry>> getAllEntries() {
        return ResponseEntity.status(HttpStatus.OK).body(entryRepository.findAll());
    }


    @GetMapping("/{id}")
    public ResponseEntity<List<EntryResponseDTO>> getEntries(@PathVariable Long id) {
        List<Entry> entries = entryRepository.findByPoll_PollId(id);
        List<EntryResponseDTO> entryResponseDTOs = entries.stream()
                .map(entry -> new EntryResponseDTO(entry.getEntryId(), entry.getResponses()))
                .collect(Collectors.toList());
        return ResponseEntity.ok(entryResponseDTOs);
    }

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
        poll.increaseCount();
        pollRepository.save(poll);
        return ResponseEntity.ok("Entry created successfully");
    }
}
