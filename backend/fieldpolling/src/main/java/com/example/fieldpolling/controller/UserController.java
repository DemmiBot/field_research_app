package com.example.fieldpolling.controller;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;
import com.example.fieldpolling.dtos.UserRecordDto;
import com.example.fieldpolling.models.User;
import com.example.fieldpolling.repositories.UserRepository;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
public class UserController {

    @Autowired
    UserRepository userRepository;

    @PostMapping("/users") // Modelo Maturidade Richardson
    public ResponseEntity<User> saveUser(@RequestBody @Valid UserRecordDto userRecordDto) {
        var userModel = new User();
        BeanUtils.copyProperties(userRecordDto, userModel);
        
        return ResponseEntity.status(HttpStatus.CREATED).body(userRepository.save(userModel));
    }

    @GetMapping("/users")
    public ResponseEntity<List<User>> getAllUsers() {
        return ResponseEntity.status(HttpStatus.OK).body(userRepository.findAll());
    }
    
    @GetMapping("/users/{id}")
    public ResponseEntity<Object> getOneUser(@PathVariable(value="id") UUID id ) {
        Optional<User> userO = userRepository.findById(id);
        if(userO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found.");
        }
        return ResponseEntity.status(HttpStatus.OK).body(userO.get());
    }

    @PutMapping("users/{id}")
    public ResponseEntity<Object> updateUser(@PathVariable(value="id") UUID id,
        @RequestBody @Valid UserRecordDto userRecordDto) {
        Optional<User> userO = userRepository.findById(id);
        if(userO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found.");
        }
        var userModel = userO.get();
        BeanUtils.copyProperties(userRecordDto, userModel);
        return ResponseEntity.status(HttpStatus.OK).body(userRepository.save(userModel));
    }

    @DeleteMapping("users/{id}")
    public ResponseEntity<Object> deleteUser(@PathVariable(value="id") UUID id) {
        Optional<User> userO = userRepository.findById(id);
        if(userO.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("User not found.");
        }
        userRepository.delete(userO.get());
        return ResponseEntity.status(HttpStatus.OK).body("User deleted successfully.");
    }
}