package com.example.fieldpolling.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;

import com.example.fieldpolling.domain.Entry;
import com.example.fieldpolling.domain.Poll;
import com.example.fieldpolling.dtos.EntryDTO;
import com.example.fieldpolling.dtos.PollRecordDTO;
import com.example.fieldpolling.repositories.EntryRepository;
import com.example.fieldpolling.repositories.PollRepository;

@RestController
public class PollController {

    @Autowired
    PollRepository pollRepository;

    @Autowired
    EntryRepository entryRepository;

    @GetMapping("/polls")
    public ResponseEntity<List<Poll>> getAllPolls() {
        return ResponseEntity.status(HttpStatus.OK).body(pollRepository.findAll());
    }

    @GetMapping("/polls/{id}")
    public ResponseEntity<Object> getOnePoll(@PathVariable(value = "id") String id) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if (pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("poll not found.");
        }
        return ResponseEntity.status(HttpStatus.OK).body(pollO.get());
    }

    @PostMapping("/polls")
    public ResponseEntity<Object> savePoll(@RequestBody @Valid PollRecordDTO pollRecordDTO) {
        Poll pollModel = new Poll();
        try {
            BeanUtils.copyProperties(pollRecordDTO, pollModel);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("SQL Exception: " + e);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(pollRepository.save(pollModel));
    }

    @PutMapping("polls/{id}")
    public ResponseEntity<Object> updatePoll(@PathVariable(value = "id") String id,
            @RequestBody @Valid PollRecordDTO pollRecordDTO) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if (pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Poll not found.");
        }
        var pollModel = pollO.get();
        BeanUtils.copyProperties(pollRecordDTO, pollModel);
        return ResponseEntity.status(HttpStatus.OK).body(pollRepository.save(pollModel));
    }

    @DeleteMapping("polls/{id}")
    public ResponseEntity<Object> deletePoll(@PathVariable(value = "id") String id) {
        Optional<Poll> pollO = pollRepository.findById(id);
        try {
            pollRepository.delete(pollO.get());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e);
        }

        return ResponseEntity.status(HttpStatus.OK).body("Poll deleted successfully.");
    }
    
    @GetMapping("/polls/{poll_id}/entries")
    public ResponseEntity<Object> getFromPoll(@PathVariable String poll_id) {

        return ResponseEntity.status(HttpStatus.OK).body(entryRepository.findByPollId(poll_id));
    }
    
    @PostMapping("/polls/entries")
    public ResponseEntity<Object> saveEntry(@RequestBody @Valid EntryDTO entryDTO) {
        if(pollRepository.findById(entryDTO.pollId()).isEmpty()) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("No poll with that id");
        }
    
        Entry entry = new Entry();
        
        BeanUtils.copyProperties(entryDTO, entry);
        
        return ResponseEntity.status(HttpStatus.CREATED).body(entryRepository.save(entry));
    }
       
}