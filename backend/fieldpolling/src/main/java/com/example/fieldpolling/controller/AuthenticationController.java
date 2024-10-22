package com.example.fieldpolling.controller;

import org.springframework.web.bind.annotation.RestController;

import com.example.fieldpolling.dtos.AuthenticationDTO;
import com.example.fieldpolling.dtos.LoginResponseDTO;
import com.example.fieldpolling.dtos.RegisterDTO;
import com.example.fieldpolling.infra.security.TokenService;
import com.example.fieldpolling.models.User;
import com.example.fieldpolling.models.VerificationToken;
import com.example.fieldpolling.repositories.TokenRepository;
import com.example.fieldpolling.repositories.UserRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.Calendar;

@RestController
@RequestMapping("auth")
public class AuthenticationController {
    @Autowired
    private AuthenticationManager authenticationManager;
    @Autowired
    private UserRepository repository;
    @Autowired
    private TokenService tokenService;

    @Autowired
    ApplicationEventPublisher eventPublisher;
    @Autowired
    private TokenRepository tokenRepository;

    @SuppressWarnings("rawtypes")
    @PostMapping("/login")
    public ResponseEntity login(@RequestBody @Valid AuthenticationDTO data) {
        String login = data.email() != null ? data.email() : data.username();
        var usernamePassword = new UsernamePasswordAuthenticationToken(login, data.password());
        try {
            // Lança as exceptions abaixo
            var auth = this.authenticationManager.authenticate(usernamePassword);
            var token = tokenService.generateToken((User) auth.getPrincipal());
            
            // Isso tá certo??? ALO ALO ALO
            User user = repository.findByEmail(login) != null ? (User) repository.findByEmail(login) : (User) repository.findByUsername(login);
            return ResponseEntity.ok(new LoginResponseDTO(token, user));
        } catch (DisabledException e) {
            return ResponseEntity.badRequest().body("User is not confirmed");
        } catch (LockedException e) {
            return ResponseEntity.badRequest().body("User is locked/banned");
        } catch (BadCredentialsException e) {
            return ResponseEntity.badRequest().body("Bad Credentials");
        } catch (AuthenticationException e) {
            return ResponseEntity.badRequest().body("Auth exception: " + e);

        }
        // return ResponseEntity.ok(new LoginResponseDTO(token));
    }

    @SuppressWarnings("rawtypes")
    @PostMapping("/register")
    public ResponseEntity register(@RequestBody @Valid RegisterDTO data, HttpServletRequest request) {
        if (this.repository.findByUsername(data.username()) != null)
            return ResponseEntity.badRequest().body("An account for that username already exists.");
        if (this.repository.findByEmail(data.email()) != null)
            return ResponseEntity.badRequest().body("An account for that email already exists.");

        String encryptedPassword = new BCryptPasswordEncoder().encode(data.password());
        User newUser = new User(data.email(), data.username(), encryptedPassword, data.role());

        try {
            this.repository.save(newUser);
        // uncomment to send email on user saving
        // needs enviroment variables SPRING_EMAIL and SPRING_PASSWORD to work
        //    eventPublisher.publishEvent(
        //            new OnRegistrationCompleteEvent(newUser, request.getLocale(), request.getContextPath()));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error on saving/sending email" + e);
        }
        return ResponseEntity.ok("User created!");
    }

    @GetMapping("/registrationConfirm")
    public ResponseEntity<Object> confirmRegistration
    (@RequestParam String token) {
        
        VerificationToken verificationToken = tokenRepository.findByToken(token);

        if (verificationToken == null) {
            return ResponseEntity.badRequest().body("nullToken");
        }
        
        User user = verificationToken.getUser();
        Calendar cal = Calendar.getInstance();
        if ((verificationToken.getExpiryDate().getTime() - cal.getTime().getTime()) <= 0) {
            return ResponseEntity.badRequest().body("Token Expired");        
        } 
        
        user.setEnabled(true);
        try {
            repository.save(user);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e); 
        }
        return ResponseEntity.ok().build(); 
    }
}