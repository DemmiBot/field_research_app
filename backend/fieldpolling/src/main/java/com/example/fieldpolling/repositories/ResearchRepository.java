package com.example.fieldpolling.repositories;

import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.models.Poll;


@Repository
public interface ResearchRepository extends JpaRepository<Poll, UUID> {
    
}
