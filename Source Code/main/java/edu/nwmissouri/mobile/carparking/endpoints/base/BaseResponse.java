package edu.nwmissouri.mobile.carparking.endpoints.base;

import java.time.LocalDateTime;

public abstract class BaseResponse {

    private LocalDateTime createdAt = LocalDateTime.now();

}
