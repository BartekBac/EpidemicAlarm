package com.epidemicalarm.api.web.advices;

import com.epidemicalarm.api.exception.GeocoderServiceException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.io.IOException;

@ControllerAdvice
public class GeocoderAdvice {
    @ResponseBody
    @ExceptionHandler(GeocoderServiceException.class)
    @ResponseStatus(HttpStatus.SERVICE_UNAVAILABLE)
    String geocodingServiceExceptionHandler(GeocoderServiceException ex) {
        return ex.getMessage();
    }

    @ResponseBody
    @ExceptionHandler(IOException.class)
    @ResponseStatus(HttpStatus.SERVICE_UNAVAILABLE)
    String httpClientSendIOExceptionHandler(IOException ex) {
        return ex.getMessage();
    }

    @ResponseBody
    @ExceptionHandler(InterruptedException.class)
    @ResponseStatus(HttpStatus.SERVICE_UNAVAILABLE)
    String httpClientSendInterruptedExceptionHandler(InterruptedException ex) {
        return ex.getMessage();
    }
}
