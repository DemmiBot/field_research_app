package com.example.fieldpolling.repositories;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.domain.Entry;

@Repository
public interface EntryRepository extends MongoRepository<Entry, String> {
    public List<Entry> findByPollId(String pollId);
}
