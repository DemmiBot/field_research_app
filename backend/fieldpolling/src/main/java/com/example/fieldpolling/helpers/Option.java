package com.example.fieldpolling.helpers;

public class Option {
    private String optionName;
    private String optionType;

    public String optionName() {
        return this.optionName;
    }

    public String optionType() {
        return this.optionType;
    }

    public Option(String optionName, String optionType) {
        this.optionName = optionName;
        this.optionType = optionType;
    }
}
