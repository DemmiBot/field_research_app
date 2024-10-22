package com.example.fieldpolling.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldpolling.models.Poll;

@Repository
public interface PollRepository extends JpaRepository<Poll, Long> {

}