package com.example.fieldpolling.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.Date;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Calendar;

@Document(collection = "verification")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class VerificationToken {
    private static final int EXPIRATION = 60 * 24;

    @Id
    private String id;
    private String token;
    private String user_id;
    private Date expiryDate;

    private Date calculateExpiryDate(int expiryTimeInMinutes) {
        Calendar cal =  Calendar.getInstance();
        cal.setTime(new Date(cal.getTime().getTime()));
        cal.add(cal.MINUTE, expiryTimeInMinutes);
        return new Date(cal.getTime().getTime());
    }

    public VerificationToken(String user_id, String token) {
        this.user_id = user_id;
        this.token = token;
        this.expiryDate = calculateExpiryDate(EXPIRATION);
    }
}