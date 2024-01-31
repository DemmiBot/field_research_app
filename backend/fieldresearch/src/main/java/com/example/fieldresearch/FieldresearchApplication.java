package com.example.fieldresearch;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import com.example.fieldresearch.controller.UserController;

@SpringBootApplication
@ComponentScan(basePackageClasses = UserController.class)
public class FieldresearchApplication {

	public static void main(String[] args) {
		SpringApplication.run(FieldresearchApplication.class, args);
	}

}
