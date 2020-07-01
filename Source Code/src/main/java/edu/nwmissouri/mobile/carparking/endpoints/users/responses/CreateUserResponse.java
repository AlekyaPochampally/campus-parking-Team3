package edu.nwmissouri.mobile.carparking.endpoints.users.responses;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateUserResponse {

    private String emailId;

    private String name;

    private String registrationPlate;
}
