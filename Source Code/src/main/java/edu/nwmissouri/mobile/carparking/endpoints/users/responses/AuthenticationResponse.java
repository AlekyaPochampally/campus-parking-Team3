package edu.nwmissouri.mobile.carparking.endpoints.users.responses;

import edu.nwmissouri.mobile.carparking.endpoints.base.BaseResponse;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuthenticationResponse extends BaseResponse {

    private String token;

}
