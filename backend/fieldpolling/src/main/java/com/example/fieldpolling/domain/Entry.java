package com.example.fieldpolling.domain;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Document("entries")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Entry {
    @Id
    String entry_id;
    String pollId;
    List<Option> options;
}