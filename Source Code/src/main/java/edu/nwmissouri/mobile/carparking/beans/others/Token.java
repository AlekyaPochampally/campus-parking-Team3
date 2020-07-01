package edu.nwmissouri.mobile.carparking.beans.others;

import edu.nwmissouri.mobile.carparking.beans.base.FunctionEntity;
import edu.nwmissouri.mobile.carparking.beans.constants.TokenType;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.time.LocalDateTime;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor

@Entity
public class Token extends FunctionEntity<Token> {

    @Id
    @GeneratedValue(generator = "uuid_generator")
    @GenericGenerator(
            name = "uuid_generator",
            strategy = "org.hibernate.id.UUIDGenerator"
    )
    private String tokenId;

    @Column(unique = true, nullable = false)
    private String token;

    private LocalDateTime generatedOn;

    private Long expirationTime;

    @Enumerated(EnumType.STRING)
    private TokenType tokenType;

}
