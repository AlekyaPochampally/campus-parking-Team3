package edu.nwmissouri.mobile.carparking.endpoints.users.requests;

import edu.nwmissouri.mobile.carparking.endpoints.base.IVerifiableRequestBody;
import edu.nwmissouri.mobile.carparking.endpoints.base.Verified;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuthenticationRequest implements IVerifiableRequestBody {

    private String emailId;

    private String password;

    @Override
    public Verified verify() {
        return null;
    }

}
