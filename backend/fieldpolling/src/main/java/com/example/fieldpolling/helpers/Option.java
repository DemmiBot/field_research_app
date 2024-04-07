package com.example.fieldpolling.helpers;

import java.util.List;

public class Option {
    private String optionName;
    private String optionType;

    public String getOptionName() {
        return this.optionName;
    }

    public String getOptionType() {
        return this.optionType;
    }

    public Option(String optionName, String optionType) {
        this.optionName = optionName;
        this.optionType = optionType;
    }
}
