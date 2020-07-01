package edu.nwmissouri.mobile.carparking.endpoints.users;

import edu.nwmissouri.mobile.carparking.annotations.VerifyRequestBody;
import edu.nwmissouri.mobile.carparking.beans.constants.TokenType;
import edu.nwmissouri.mobile.carparking.beans.users.Profile;
import edu.nwmissouri.mobile.carparking.beans.users.Role;
import edu.nwmissouri.mobile.carparking.beans.users.User;
import edu.nwmissouri.mobile.carparking.endpoints.users.requests.*;
import edu.nwmissouri.mobile.carparking.endpoints.users.responses.AuthenticationResponse;
import edu.nwmissouri.mobile.carparking.endpoints.users.responses.CreateUserResponse;
import edu.nwmissouri.mobile.carparking.security.IJwtTokenProvider;
import edu.nwmissouri.mobile.carparking.services.api.IEmailService;
import edu.nwmissouri.mobile.carparking.services.api.ITokenService;
import edu.nwmissouri.mobile.carparking.services.api.IUserService;
import io.vavr.collection.List;
import io.vavr.control.Option;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserEndpoints {

    public static final String PASSWORD_RESET = "Password Reset";
    public static final String PASSWORD_RESET_MESSAGE = "Use following code: %s to reset your password";

    private final IUserService userService;

    private final PasswordEncoder passwordEncoder;

    private final AuthenticationManager authenticationManager;

    private final IJwtTokenProvider tokenProvider;

    private final ITokenService tokenService;

    private final IEmailService emailService;

    @VerifyRequestBody
    @PostMapping("/create")
    public CreateUserResponse createUser(@RequestBody final CreateUserRequest userCreationRequest) {
        return User.builder()
                .emailId(userCreationRequest.getEmailId())
                .password(passwordEncoder.encode(userCreationRequest.getPassword()))
                .emailId(userCreationRequest.getEmailId())
                .roles(List.of(Role.USER).toJavaSet())
                .isAccountActivated(Boolean.TRUE)
                .profile(
                        Profile.builder()
                                .emailId(userCreationRequest.getEmailId())
                                .name(userCreationRequest.getName())
                                .registrationPlate(userCreationRequest.getRegistrationPlate())
                                .build()
                )
                .build()
                .andThenWith(userService::createNewUser)
                .andThenTransform(
                        user -> CreateUserResponse.builder()
                                .emailId(user.getEmailId())
                                .name(user.getProfile().getName())
                                .registrationPlate(user.getProfile().getRegistrationPlate())
                                .build()
                );

    }

    @VerifyRequestBody
    @PostMapping("/authenticate")
    public AuthenticationResponse authenticate(@RequestBody final AuthenticationRequest authenticationRequest) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        authenticationRequest.getEmailId(),
                        authenticationRequest.getPassword()
                )
        );
        String token = tokenProvider.createToken(
                authenticationRequest.getEmailId(),
                new ArrayList<>(userService.findByEmailId(authenticationRequest.getEmailId()).getRoles()));
        return AuthenticationResponse.builder().token(token).build();
    }

    @PostMapping("/reset-password/generate-otp")
    public boolean resetPasswordRequest(@RequestBody ResetPasswordOtpGenerationRequest resetPasswordOtpGenerationRequest) {
        userService.findByEmailId(resetPasswordOtpGenerationRequest.getEmailId())
                .andThenWith(user -> user.setPasswordResetToken(tokenService.generateAndStoreToken(-1, TokenType.RESET_PASSWORD)))
                .andThenWith(user -> userService.updateUser(user))
                .andThenWith(user -> emailService.sendSimpleMail(
                        user.getEmailId(),
                        PASSWORD_RESET,
                        String.format(PASSWORD_RESET_MESSAGE, user.getPasswordResetToken())));
        return Boolean.TRUE;
    }

    @PostMapping("/reset-password/verify-otp")
    public boolean verifyOtp(final VerifyPasswordResetOtp verifyPasswordResetOtp) {
        return Option.of(userService.findByEmailId(verifyPasswordResetOtp.getEmailId()))
                .filter(user -> user.getPasswordResetToken().equals(verifyPasswordResetOtp.getOtp()))
                .isDefined();
    }

    @VerifyRequestBody
    @PostMapping("/reset-password/update-password")
    public boolean updatePassword(final UpdatePasswordRequest updatePasswordRequest) {
        userService.findByEmailId(updatePasswordRequest.getEmailId())
                .andThenWith(user -> user.setPassword(passwordEncoder.encode(updatePasswordRequest.getNewPassword())))
                .andThenWith(user -> userService.updateUser(user));
        return Boolean.TRUE;
    }
}
