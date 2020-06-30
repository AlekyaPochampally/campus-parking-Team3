package edu.nwmissouri.mobile.carparking.endpoints.users.responses;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserEmailVerificationResponse {

    private String message;

    private String username;

    private boolean verificationSuccessful;
}
