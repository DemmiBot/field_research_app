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
import org.springframework.transaction.annotation.Transactional;
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

    @GetMapping("/polls")
    public ResponseEntity<List<Poll>> getAllPolls() {
        return ResponseEntity.status(HttpStatus.OK).body(pollRepository.findAll());
    }
    @GetMapping("/polls/{id}")
    public ResponseEntity<Object> getOnePoll(@PathVariable(value="id") UUID id ) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if(pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("poll not found.");
        }
        return ResponseEntity.status(HttpStatus.OK).body(pollO.get());
    }

    @PostMapping("/polls")
    public ResponseEntity<Object> savePoll(@RequestBody @Valid PollRecordDTO pollRecordDTO) {
        Poll pollModel;
        try {
            pollModel = createPoll(pollRecordDTO);
        } catch(Exception e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("SQL Exception: " + e);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(pollModel);
    }

    @Transactional
    private Poll createPoll(@Valid PollRecordDTO pollRecordDTO) throws Exception{
        var pollModel = new Poll();
        BeanUtils.copyProperties(pollRecordDTO, pollModel);
        String tName = pollRecordDTO.name().replace(" ", "_").toLowerCase();
        
        dynamicTableService.createTable(tName, pollRecordDTO.options());
        String tOptions = dynamicTableService.optionsToString(pollRecordDTO.options());
        pollModel.setOptions(tOptions);
                
        pollModel = pollRepository.save(pollModel);
        return pollModel;
    }

    @PutMapping("polls/{id}")
    public ResponseEntity<Object> updatePoll(@PathVariable(value="id") UUID id,
        @RequestBody @Valid PollRecordDTO pollRecordDTO) {
        Optional<Poll> pollO = pollRepository.findById(id);
        if(pollO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Poll not found.");
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
        String tableName = pollO.get().getName().replace(" ", "_").toLowerCase();
        try {
            dynamicTableService.dropTable(tableName);
        } catch(SQLException exception) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("SQL Exception: " + exception);
        }
        pollRepository.delete(pollO.get());
        return ResponseEntity.status(HttpStatus.OK).body("Poll deleted successfully.");
    }
    
    @GetMapping("/polls/meta/{name}")
    public ResponseEntity<Map<String, String>> getPollMetadata(@PathVariable(value="name") String tableName) {
        Map<String, String> tableMetadata = dynamicTableService.getColumnNamesAndTypes(tableName);

        if(tableMetadata.isEmpty())
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(tableMetadata);
    
        return ResponseEntity.status(HttpStatus.OK).body(tableMetadata);
    }

    @GetMapping("/polls/poll")
    public ResponseEntity<List<Map<String, Object>>> getAllFromPoll(@RequestParam(value="name") String tableName) {
        List<Map<String, Object>> tableContents = dynamicTableService.getDynamicTableContents(tableName);
      
        if(tableContents.isEmpty())
        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(tableContents);

        return ResponseEntity.status(HttpStatus.OK).body(tableContents);
    }

    @PostMapping("polls/poll/{name}")
    public ResponseEntity<Map<String, Object>> newFormEntry(@PathVariable String name, @RequestBody Map<String, Object> rowData) {
        try {
            dynamicTableService.insertRow(name, rowData);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
        return ResponseEntity.status(HttpStatus.OK).body(rowData);
    }
    

    @DeleteMapping("/polls/{name}/{id}")
    public ResponseEntity<Object> deleteEntryFromPoll(@PathVariable(value="id") Integer id, @PathVariable(value="name") String tableName) {
        try {
            dynamicTableService.deleteRowById(tableName, id);
        } catch(Exception e) {

        }
    
        return ResponseEntity.status(HttpStatus.OK).body("Entry deleted successfully!");
    }
}