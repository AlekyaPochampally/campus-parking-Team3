package edu.nwmissouri.mobile.carparking.repositories;

import edu.nwmissouri.mobile.carparking.beans.users.User;
import org.springframework.data.jpa.repository.JpaRepository;
import io.vavr.control.Option;

public interface UserRepository extends JpaRepository<User, String> {
    Option<User> findByEmailId(String emailId);
}

