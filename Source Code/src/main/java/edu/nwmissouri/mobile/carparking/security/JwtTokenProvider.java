package edu.nwmissouri.mobile.carparking.security;

import edu.nwmissouri.mobile.carparking.beans.users.Role;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.sql.Date;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class JwtTokenProvider implements IJwtTokenProvider {

    private final UserDetailsService userDetailsService;
    private String secretKey;
    private long tokenValidityLength;

    public JwtTokenProvider(
            @Value("${cp.security.jwt.token.secret-key}") String secretKey,
            @Value("${cp.security.jwt.token.expire-length}") long tokenValidityLength,
            UserDetailsService userDetailsService) {

        this.secretKey = Base64.getEncoder().encodeToString(secretKey.getBytes());
        this.tokenValidityLength = tokenValidityLength;
        this.userDetailsService = userDetailsService;
    }

    @Override
    public String createToken(String username, List<Role> roles) {
        Claims claims = Jwts.claims().setSubject(username);
        claims.put(
                ROLES, roles.stream()
                        .map(role -> new SimpleGrantedAuthority(role.name()))
                        .collect(Collectors.toList())
        );
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime tokenExpiresAt = now.plus(tokenValidityLength, ChronoUnit.MILLIS);
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(Date.from(now.atZone(ZoneId.systemDefault()).toInstant()))
                .setExpiration(Date.from(tokenExpiresAt.atZone(ZoneId.systemDefault()).toInstant()))
                .signWith(SignatureAlgorithm.HS256, secretKey)
                .compact();
    }

    @Override
    public Authentication getAuthentication(String token) {
        UserDetails userDetails = userDetailsService.loadUserByUsername(getUsernameFromToken(token));
        return new UsernamePasswordAuthenticationToken(
                userDetails.getUsername(),
                EMPTY,
                userDetails.getAuthorities()
        );
    }

    @Override
    public String resolveToken(HttpServletRequest request) {
        String bearerToken = request.getHeader(AUTHORIZATION);
        if (bearerToken != null && bearerToken.startsWith(BEARER)) {
            return bearerToken.substring(BEGIN_INDEX);
        }
        return null;
    }

    @Override
    public boolean validateToken(String token) {
        try {
            Jwts.parser().setSigningKey(secretKey).parseClaimsJws(token);
        } catch (JwtException | IllegalArgumentException e) {
            throw new ApplicationSecurityException("Invalid token. The token is either invalid or has expired");
        }
        return Boolean.TRUE;
    }

    private String getUsernameFromToken(String token) {
        return Jwts.parser()
                .setSigningKey(secretKey)
                .parseClaimsJws(token)
                .getBody()
                .getSubject();
    }

}
