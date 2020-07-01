package edu.nwmissouri.mobile.carparking.endpoints.users.requests;


import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class VerifyPasswordResetOtp {

    private String emailId;

    private String otp;
}
