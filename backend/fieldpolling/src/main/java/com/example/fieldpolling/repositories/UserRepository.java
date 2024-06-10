package com.example.fieldpolling.repositories;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.domain.User;

@Repository
public interface UserRepository extends MongoRepository<User, String> {
    UserDetails findByUsername(String username);
    UserDetails findByEmail(String email);
}