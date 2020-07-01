package edu.nwmissouri.mobile.carparking.beans.users;

import edu.nwmissouri.mobile.carparking.beans.base.FunctionEntity;
import edu.nwmissouri.mobile.carparking.beans.others.Token;
import lombok.*;

import javax.persistence.*;
import java.util.Set;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor

@Entity
public class User extends FunctionEntity<User> {

    @Id
    private String emailId;

    @Column(nullable = false)
    private String password;

    private boolean isAccountActivated;

    @OneToOne(
            fetch = FetchType.LAZY,
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JoinColumn(name = "password_reset_token_id")
    private Token passwordResetToken;

    @ElementCollection(targetClass = Role.class)
    @Enumerated(EnumType.STRING)
    @CollectionTable(name = "user_role")
    @Column(name = "role", nullable = false)
    private Set<Role> roles;

    @MapsId
    @OneToOne(
            fetch = FetchType.LAZY,
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JoinColumn(name = "emailId")
    private Profile profile;

}
