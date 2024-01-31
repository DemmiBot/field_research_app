package com.example.controller;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import com.example.dtos.UserRecordDto;
import com.example.fieldresearch.models.UserModel;
import com.example.fieldresearch.repositories.UserRepository;

import jakarta.persistence.PostUpdate;
import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RestController
public class UserController {

    @Autowired
    UserRepository userRepository;

    @PostMapping("/users") // Modelo Maturidade Richardson
    public ResponseEntity<UserModel> saveUser(@RequestBody @Valid UserRecordDto userRecordDto) {
        var userModel = new UserModel();
        BeanUtils.copyProperties(userRecordDto, userModel);
        
        return ResponseEntity.status(HttpStatus.CREATED).body(userRepository.save(userModel));
    }
}