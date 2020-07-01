package edu.nwmissouri.mobile.carparking.beans.users;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Column;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor

@Entity
public class Profile {

    @Id
    private String emailId;

    private String registrationPlate;
    @Column(name="fullname")
    private String name;

}
