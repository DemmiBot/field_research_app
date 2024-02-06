package com.example.fieldresearch.repositories;

import java.util.UUID;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.fieldresearch.models.ResearchModel;


@Repository
public interface ResearchRepository extends JpaRepository<ResearchModel, UUID> {
    
}
