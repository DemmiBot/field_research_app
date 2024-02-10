package com.example.fieldresearch.helpers;

public enum UserRole {
    USER("open"), ADMIN("closed");
    private String role;

    UserRole(String role) {
        this.role = role;
    }

    public String getRole() {
        return role;
    }
}
