package edu.nwmissouri.mobile.carparking.security;

import edu.nwmissouri.mobile.carparking.beans.users.User;
import edu.nwmissouri.mobile.carparking.services.api.IUserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ApplicationUserDetailsService implements UserDetailsService {

    private final IUserService userService;

    @Override
    public UserDetails loadUserByUsername(String emailId) throws UsernameNotFoundException {
        User userByEmail = userService.findUserByEmailId(emailId);

        log.info("Found user: {}", userByEmail);

        if (userByEmail == null) {
            throw new UsernameNotFoundException(String.format("Username %s could not be found", emailId));
        }
        return org.springframework.security.core.userdetails.User.builder()
                .username(userByEmail.getEmailId())
                .password(userByEmail.getPassword())
                .authorities(userByEmail.getRoles().stream().map(role -> new SimpleGrantedAuthority(role.name())).collect(Collectors.toList()))
                .disabled(!userByEmail.isAccountActivated())
                .build();

    }

}
