package com.example.fieldpolling.repositories;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.models.VerificationToken;

@Repository
public interface TokenRepository extends JpaRepository<VerificationToken, Integer>{
    VerificationToken findByToken(String token);
}
