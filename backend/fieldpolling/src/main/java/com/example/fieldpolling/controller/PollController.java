package com.example.fieldpolling.controller;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;

import com.example.fieldpolling.dtos.PollRecordDTO;
import com.example.fieldpolling.models.Poll;
import com.example.fieldpolling.repositories.PollRepository;
import com.example.fieldpolling.services.DynamicTableService;

@RestController
// @SuppressWarnings("null")
public class PollController {

    @Autowired
    PollRepository pollRepository;

    @Autowired
    DynamicTableService dynamicTableService;

    @PostMapping("/polls") // Modelo Maturidade Richardson
    public ResponseEntity<Poll> savePoll(@RequestBody @Valid PollRecordDTO pollRecordDTO) {
        var pollModel = new Poll();
        BeanUtils.copyProperties(pollRecordDTO, pollModel);
        // implement try method
        try {
            String tName = pollRecordDTO.name().replace(" ", "_").toLowerCase();
            dynamicTableService.createTable(tName, pollRecordDTO.options());
        } catch (SQLException exception) {
            throw new RuntimeException("Error while creating new poll, ", exception);
        }
        // implement catch method for sql exceptions
        return ResponseEntity.status(HttpStatus.CREATED).body(pollRepository.save(pollModel));
    }

    @GetMapping("/polls")
    public ResponseEntity<List<Poll>> getAllPolls() {
        return ResponseEntity.status(HttpStatus.OK).body(pollRepository.findAll());
    }

    @GetMapping("/polls/single")
    public ResponseEntity<List<Map<String, Object>>> getAllFromPoll(@RequestParam(value="name") String tableName) {
        List<Map<String, Object>> tableContents = dynamicTableService.getDynamicTableContents(tableName);
        return ResponseEntity.status(HttpStatus.OK).body(tableContents);
    }
    
    @GetMapping("/polls/{id}")
    public ResponseEntity<Object> getOnePoll(@PathVariable(value="id") UUID id ) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if(pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("poll not found.");
        }
        return ResponseEntity.status(HttpStatus.OK).body(pollO.get());
    }

    @PutMapping("polls/{id}")
    public ResponseEntity<Object> updatePoll(@PathVariable(value="id") UUID id,
        @RequestBody @Valid PollRecordDTO pollRecordDTO) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if(pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("poll not found.");
        }
        var pollModel = pollO.get();
        BeanUtils.copyProperties(pollRecordDTO, pollModel);
        return ResponseEntity.status(HttpStatus.OK).body(pollRepository.save(pollModel));
    }

    @DeleteMapping("polls/{id}")
    public ResponseEntity<Object> deletePoll(@PathVariable(value="id") UUID id) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if(pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Poll not found.");
        }
        pollRepository.delete(pollO.get());
        return ResponseEntity.status(HttpStatus.OK).body("Poll deleted successfully.");
    }
}