package com.example.fieldpolling.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;

@AllArgsConstructor
@Getter
public class Option {
    private String question_name;
    private String question_text;
    private String placeholder_text;
    private Boolean placeholder;
    private Object answer;
}
