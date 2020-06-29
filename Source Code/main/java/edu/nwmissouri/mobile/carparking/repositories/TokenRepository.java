package edu.nwmissouri.mobile.carparking.repositories;

import edu.nwmissouri.mobile.carparking.beans.others.Token;
import io.vavr.control.Option;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TokenRepository extends JpaRepository<Token, String> {

    Option<Token> findByToken(String token);
}
