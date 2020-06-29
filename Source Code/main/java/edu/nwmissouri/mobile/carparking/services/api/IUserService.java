package edu.nwmissouri.mobile.carparking.services.api;

import edu.nwmissouri.mobile.carparking.beans.users.User;

public interface IUserService {

    User findUserByEmailId(final String emailId) throws IllegalArgumentException;

    User findByEmailId(final String username) throws IllegalArgumentException;

    User createNewUser(final User newUser) throws IllegalArgumentException;

    User updateUser(final User user) throws IllegalArgumentException;

}