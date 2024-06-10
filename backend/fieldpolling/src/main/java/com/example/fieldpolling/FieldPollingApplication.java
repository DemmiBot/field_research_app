package com.example.fieldpolling;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.mongodb.repository.config.EnableMongoRepositories;

@SpringBootApplication
@EnableMongoRepositories
public class FieldPollingApplication {

	public static void main(String[] args) {
		SpringApplication.run(FieldPollingApplication.class, args);
	}

}