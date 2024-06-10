package com.example.fieldpolling.repositories;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.domain.VerificationToken;

@Repository
public interface TokenRepository extends MongoRepository<VerificationToken, String>{
    VerificationToken findByToken(String token);
}
