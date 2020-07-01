package edu.nwmissouri.mobile.carparking.services.impl;

import edu.nwmissouri.mobile.carparking.beans.users.User;
import edu.nwmissouri.mobile.carparking.repositories.UserRepository;
import edu.nwmissouri.mobile.carparking.services.api.IUserService;
import io.vavr.control.Try;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService implements IUserService {

    private static final String USER_NOT_FOUND_MESSAGE_FORMAT = "User with %s: %s was not found";

    private final UserRepository userRepository;

    @Override
    public User findUserByEmailId(final String emailId) throws IllegalArgumentException {
        return userRepository.findByEmailId(emailId)
                .getOrElseThrow(() -> new IllegalArgumentException(
                        String.format(USER_NOT_FOUND_MESSAGE_FORMAT, "email id", emailId)
                ));
    }

    @Override
    public User findByEmailId(final String emailId) throws IllegalArgumentException {
        return userRepository.findByEmailId(emailId)
                .getOrElseThrow(() -> new IllegalArgumentException(
                        String.format(USER_NOT_FOUND_MESSAGE_FORMAT, "emailId", emailId)
                ));
    }

    @Override
    public User createNewUser(final User newUser) throws IllegalArgumentException {
        return Try.of(() -> userRepository.save(newUser))
                .getOrElseThrow(exception -> new IllegalArgumentException(exception.getMessage()));
    }

    @Override
    public User updateUser(final User user) throws IllegalArgumentException {
        return Try.of(() -> findByEmailId(user.getEmailId()))
                .filter(Objects::nonNull)
                .map(updates -> userRepository.save(user))
                .get();
    }
}
