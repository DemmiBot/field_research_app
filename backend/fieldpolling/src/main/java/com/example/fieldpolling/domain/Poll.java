package com.example.fieldpolling.domain;

import java.io.Serializable;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import com.example.fieldpolling.dtos.PollRecordDTO;
import com.example.fieldpolling.helpers.Status;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Document(collection = "polls")
@Getter
@Setter
@NoArgsConstructor
public class Poll implements Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    private String id;
    @Indexed(unique = true)
    private String name;   
    private String description;
    private Status status;
    private List<Option> options;
    
    public Poll(PollRecordDTO pollRecordDTO) {
        this.name = pollRecordDTO.name();
        this.description = pollRecordDTO.description();
        this.status = pollRecordDTO.status();
        this.options = pollRecordDTO.options();
    }
}