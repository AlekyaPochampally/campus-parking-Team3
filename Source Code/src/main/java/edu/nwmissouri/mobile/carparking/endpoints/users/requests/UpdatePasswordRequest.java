package edu.nwmissouri.mobile.carparking.endpoints.users.requests;

import edu.nwmissouri.mobile.carparking.endpoints.base.IVerifiableRequestBody;
import edu.nwmissouri.mobile.carparking.endpoints.base.Verified;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UpdatePasswordRequest implements IVerifiableRequestBody {

    private String emailId;

    private String newPassword;

    private String verifyNewPassword;

    @Override
    public Verified verify() {
        if (newPassword == null || newPassword.trim().isEmpty()) {
            return Verified.failedValidation("Password cannot be empty");
        }
        if (verifyNewPassword == null || verifyNewPassword.trim().isEmpty()) {
            return Verified.failedValidation("Verification password cannot be empty");
        }
        if (newPassword.length() <= 5) {
            return Verified.failedValidation("Password must have 6 or more characters");
        }
        if (!newPassword.equals(verifyNewPassword)) {
            return Verified.failedValidation("Password and verification passwords do not match");
        }
        return Verified.passedValidation();
    }
}
