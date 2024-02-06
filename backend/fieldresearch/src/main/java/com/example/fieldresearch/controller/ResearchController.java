package com.example.fieldresearch.controller;
import java.util.List;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;

import com.example.fieldresearch.dtos.ResearchRecordDto;
import com.example.fieldresearch.models.ResearchModel;
import com.example.fieldresearch.repositories.ResearchRepository;

@RestController
public class ResearchController {

    @Autowired
    ResearchRepository researchRepository;

    @PostMapping("/researches") // Modelo Maturidade Richardson
    public ResponseEntity<ResearchModel> saveResearch(@RequestBody @Valid ResearchRecordDto researchRecordDto) {
        var researchModel = new ResearchModel();
        BeanUtils.copyProperties(researchRecordDto, researchModel);
        
        return ResponseEntity.status(HttpStatus.CREATED).body(researchRepository.save(researchModel));
    }

    @GetMapping("/researches")
    public ResponseEntity<List<ResearchModel>> getAllResearches() {
        return ResponseEntity.status(HttpStatus.OK).body(researchRepository.findAll());
    }
    
    @GetMapping("/researches/{id}")
    public ResponseEntity<Object> getOneResearch(@PathVariable(value="id") UUID id ) {
        Optional<ResearchModel> researchO = researchRepository.findById(id);
        if(researchO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Research not found.");
        }
        return ResponseEntity.status(HttpStatus.OK).body(researchO.get());
    }

    @PutMapping("researches/{id}")
    public ResponseEntity<Object> updateResearch(@PathVariable(value="id") UUID id,
        @RequestBody @Valid ResearchRecordDto researchRecordDto) {
        Optional<ResearchModel> researchO = researchRepository.findById(id);
        if(researchO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Research not found.");
        }
        var researchModel = researchO.get();
        BeanUtils.copyProperties(researchRecordDto, researchModel);
        return ResponseEntity.status(HttpStatus.OK).body(researchRepository.save(researchModel));
    }

    @DeleteMapping("researches/{id}")
    public ResponseEntity<Object> deleteResearch(@PathVariable(value="id") UUID id) {
        Optional<ResearchModel> researchO = researchRepository.findById(id);
        if(researchO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Research not found.");
        }
        researchRepository.delete(researchO.get());
        return ResponseEntity.status(HttpStatus.OK).body("Research deleted successfully.");
    }
}