package edu.nwmissouri.mobile.carparking.services.api;

public interface IEmailService {

    void sendSimpleMail(String recipient, String subject, String message);
}
