package com.example.fieldpolling.models;

import com.example.fieldpolling.helpers.Status;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "polls")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Poll {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long pollId;

    private String title;

    private String description;

    private Status status;

    private int entryCount = 0;

    public void increaseCount() {
        entryCount++;
    }

    public void decreaseCount() {
        entryCount--;
    }

    @Column(columnDefinition = "json")
    private String questions; // Store questions in JSON format

}