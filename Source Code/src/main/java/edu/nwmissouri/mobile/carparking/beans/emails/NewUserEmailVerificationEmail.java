package edu.nwmissouri.mobile.carparking.beans.emails;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class NewUserEmailVerificationEmail {

    private String email;

    private String firstName;

    private String lastName;

    private String verificationToken;

    private String message;
}
