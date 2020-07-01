package edu.nwmissouri.mobile.carparking.exceptions;

import edu.nwmissouri.mobile.carparking.beans.users.User;
import lombok.Getter;

public class AuthenticationAuthorizationExceptions {

    @Getter
    public static class TokenExpiredException extends IllegalArgumentException {

        private User user;

        public TokenExpiredException(User user, String message) {
            super(message);
            this.user = user;
        }

    }

}
