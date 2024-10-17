package com.example.fieldpolling.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.models.Entry;

@Repository
public interface EntryRepository extends JpaRepository<Entry, Long> {
    List<Entry> findByPoll_PollId(Long pollId);
}