package edu.nwmissouri.mobile.carparking.security;

import edu.nwmissouri.mobile.carparking.beans.users.Role;
import org.springframework.security.core.Authentication;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface IJwtTokenProvider {

    String ROLES = "roles";
    String EMPTY = "";
    String AUTHORIZATION = "Authorization";
    String BEARER = "Bearer ";
    int BEGIN_INDEX = 7;

    String createToken(String username, List<Role> roles);

    Authentication getAuthentication(String token);

    String resolveToken(HttpServletRequest request);

    boolean validateToken(String token);

}
