package com.example.fieldpolling.controller;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.example.fieldpolling.dtos.PollRecordDTO;
import com.example.fieldpolling.models.Poll;
import com.example.fieldpolling.repositories.EntryRepository;
import com.example.fieldpolling.repositories.PollRepository;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
// @SuppressWarnings("null")
@RequestMapping("/polls")
public class PollController {

    @Autowired
    PollRepository pollRepository;

    @Autowired
    ObjectMapper objectMapper;

    @GetMapping
    public ResponseEntity<List<Poll>> getAllPolls() {
        return ResponseEntity.status(HttpStatus.OK).body(pollRepository.findAll());
    }

    @Autowired
    EntryRepository entryRepository;


    @GetMapping("/{id}")
    public ResponseEntity<Object> getOnePoll(@PathVariable Long id ) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if(pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("poll not found.");
        }
        return ResponseEntity.status(HttpStatus.OK).body(pollO.get());
    }

    @PostMapping
    public ResponseEntity<?> createPoll(@Valid @RequestBody PollRecordDTO pollDTO) throws JsonProcessingException {
        Poll poll = new Poll();
        // Copy properties from DTO to entity (except questions)
        BeanUtils.copyProperties(pollDTO, poll);

        // Use ObjectMapper to serialize questions to JSON
        poll.setQuestions(objectMapper.writeValueAsString(pollDTO.questions()));

        pollRepository.save(poll);
        return ResponseEntity.ok("Poll created successfully");
    }
    
    @Transactional
    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deletePoll(@PathVariable Long id) {
        Poll poll = pollRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Poll not found"));

        if(poll.getEntryCount()>0) {
            entryRepository.deleteByPoll_PollId(id);
        }
        
        pollRepository.delete(poll);
        return ResponseEntity.status(HttpStatus.OK).body("Poll deleted successfully.");
    }

}