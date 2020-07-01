package edu.nwmissouri.mobile.carparking.endpoints.users.requests;

import edu.nwmissouri.mobile.carparking.endpoints.base.IVerifiableRequestBody;
import edu.nwmissouri.mobile.carparking.endpoints.base.Verified;
import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CreateUserRequest implements IVerifiableRequestBody {

    private String emailId;

    private String password;

    private String verifiedPassword;

    private String registrationPlate;

    private String name;

    @Override

    public Verified verify() {
        if (emailId == null || emailId.trim().isEmpty()) {
            return Verified.failedValidation("Email id cannot be empty");
        }
        if (password == null || password.trim().isEmpty()) {
            return Verified.failedValidation("Password cannot be empty");
        }
        if (verifiedPassword == null || verifiedPassword.trim().isEmpty()) {
            return Verified.failedValidation("Verification password cannot be empty");
        }
        if (password.length() <= 5) {
            return Verified.failedValidation("Password must have 6 or more characters");
        }
        if (!password.equals(verifiedPassword)) {
            return Verified.failedValidation("Password and verification passwords do not match");
        }
        if (registrationPlate == null || registrationPlate.trim().isEmpty()) {
            return Verified.failedValidation("Registration plate cannot be empty");
        }
        if (name == null || name.trim().isEmpty()) {
            return Verified.failedValidation("Name cannot be empty");
        }
        return Verified.passedValidation();
    }

}
