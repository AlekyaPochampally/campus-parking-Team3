package edu.nwmissouri.mobile.carparking.services.impl;

import edu.nwmissouri.mobile.carparking.beans.constants.TokenType;
import edu.nwmissouri.mobile.carparking.beans.others.Token;
import edu.nwmissouri.mobile.carparking.repositories.TokenRepository;
import edu.nwmissouri.mobile.carparking.services.api.ITokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class TokenService implements ITokenService {

    private static final Long TOKEN_DOES_NOT_EXPIRE = Long.MIN_VALUE;

    private final TokenRepository tokenRepository;

    @Override
    public String generateToken() {
        return Integer.toString(new Random().nextInt(9000) + 1000);
    }

    @Override
    public Token generateAndStoreToken(long expiry, TokenType tokenType) {
        return Token.builder()
                .token(generateToken())
                .expirationTime(
                        expiry <= 0 && expiry != TOKEN_DOES_NOT_EXPIRE ? tokenType.getDefaultExpiryTime() : expiry
                )
                .generatedOn(LocalDateTime.now())
                .tokenType(tokenType)
                .build()
                .andThenWith(token -> tokenRepository.save(token));
    }

    @Override
    public boolean hasTokenExpired(String token) {
        return tokenRepository.findByToken(token)
                .exists(
                        tokenStore -> tokenStore.getGeneratedOn()
                                .plus(TOKEN_DOES_NOT_EXPIRE, ChronoUnit.MILLIS)
                                .isBefore(LocalDateTime.now())
                );
    }

}
