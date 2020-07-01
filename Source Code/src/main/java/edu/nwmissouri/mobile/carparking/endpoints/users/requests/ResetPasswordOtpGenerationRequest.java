package edu.nwmissouri.mobile.carparking.endpoints.users.requests;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ResetPasswordOtpGenerationRequest {

    private String emailId;

}
