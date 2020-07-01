package edu.nwmissouri.mobile.carparking.aspects;

import edu.nwmissouri.mobile.carparking.annotations.VerifyRequestBody;
import edu.nwmissouri.mobile.carparking.endpoints.base.IVerifiableRequestBody;
import edu.nwmissouri.mobile.carparking.endpoints.base.Verified;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;

import java.util.Arrays;
import java.util.Objects;

@Aspect
@Component
public class AspectValidateRequestBody {

    @Before("@annotation(verifyRequestBody)")
    public void verifyRequestBody(JoinPoint joinPoint, VerifyRequestBody verifyRequestBody) {
        if (verifyRequestBody.enabled()) {
            Arrays.stream(joinPoint.getArgs())
                    .filter(argument -> argument instanceof IVerifiableRequestBody)
                    .map(argument -> (IVerifiableRequestBody) argument)
                    .map(IVerifiableRequestBody::verify)
                    .filter(Objects::nonNull)
                    .filter(Verified::hasErrors)
                    .findFirst()
                    .ifPresent(verified -> {
                        throw new ResponseStatusException(HttpStatus.BAD_REQUEST, verified.getMessage());
                    });
        }
    }

}
