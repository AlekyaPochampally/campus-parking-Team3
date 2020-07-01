package edu.nwmissouri.mobile.carparking.endpoints.base;

import lombok.*;

@Setter
@Getter
@Builder
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class Verified {

    private String message;

    private boolean hasErrors;

    public static Verified failedValidation(String errorMessage) {
        return Verified.builder()
                .message(errorMessage)
                .hasErrors(true)
                .build();
    }

    public static Verified passedValidation() {
        return Verified.builder()
                .hasErrors(false)
                .build();
    }

    public boolean hasErrors() {
        return hasErrors;
    }

}
