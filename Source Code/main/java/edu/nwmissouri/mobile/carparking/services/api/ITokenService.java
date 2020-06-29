package edu.nwmissouri.mobile.carparking.services.api;

import edu.nwmissouri.mobile.carparking.beans.constants.TokenType;
import edu.nwmissouri.mobile.carparking.beans.others.Token;

public interface ITokenService {

    String generateToken();

    Token generateAndStoreToken(long expiry, TokenType tokenType);

    boolean hasTokenExpired(String token);
}
