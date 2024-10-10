package com.example.fieldpolling;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
public class FieldPollingApplication {

	public static void main(String[] args) {
		SpringApplication.run(FieldPollingApplication.class, args);
	}

}