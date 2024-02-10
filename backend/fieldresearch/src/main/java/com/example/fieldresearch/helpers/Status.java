package com.example.fieldresearch.helpers;

public enum Status {
    OPEN("open"), CLOSED("closed");
    private String status;

    Status(String status) {
        this.status = status;
    }

    public String getStatus() {
        return status;
    }
}
