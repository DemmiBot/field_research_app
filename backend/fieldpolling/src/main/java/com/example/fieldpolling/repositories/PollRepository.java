package com.example.fieldpolling.repositories;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.domain.Poll;


@Repository
public interface PollRepository extends MongoRepository<Poll, String> {
}