package com.model;

import java.security.Timestamp;

public class UserData {
    private String username;
    private String email;
    private String password;
    private String role;
    private String accCreation;

    // Constructor
    public UserData(String username, String email, String password, String role, String accCreation2) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
        this.accCreation = accCreation2;
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAccCreation() {
        return accCreation;
    }

    public void setAccCreation(String accCreation) {
        this.accCreation = accCreation;
    }
}
