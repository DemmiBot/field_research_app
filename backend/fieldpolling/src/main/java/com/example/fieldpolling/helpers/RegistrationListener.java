package com.example.fieldpolling.helpers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.context.MessageSource;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Component;
import java.util.UUID;

import com.example.fieldpolling.models.User;
import com.example.fieldpolling.models.VerificationToken;
import com.example.fieldpolling.repositories.TokenRepository;
import com.example.fieldpolling.services.EmailService;

@Component
public class RegistrationListener implements 
  ApplicationListener<OnRegistrationCompleteEvent> {
 
    @Autowired
    private MessageSource messages;
 
    @Autowired
    private EmailService emailService;

    @Autowired
    private TokenRepository tokenRepository;


    @Override
    public void onApplicationEvent(@NonNull OnRegistrationCompleteEvent event) {
        this.confirmRegistration(event);
    }

    private void confirmRegistration(OnRegistrationCompleteEvent event) {
        User user = event.getUser();
        String token = UUID.randomUUID().toString();
        VerificationToken vtoken = new VerificationToken(user, token);
        
        String recipientAddress = user.getEmail();
        String subject = "Registration Confirmation";
        String confirmationUrl 
          = event.getAppUrl() + "/registrationConfirm?token=" + token;
        //String message = messages.getMessage("message.regSucc", null, event.getLocale());
        
        tokenRepository.save(vtoken);
        emailService.sendEmail(recipientAddress, subject, "http://localhost:8080" + confirmationUrl);;
    }
}
