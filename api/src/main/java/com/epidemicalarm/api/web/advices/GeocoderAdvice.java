package com.epidemicalarm.api.web.advices;

import com.epidemicalarm.api.exceptions.DiagnosedCaseNotFoundException;
import com.epidemicalarm.api.exceptions.GeocodingServiceException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import java.io.IOException;

@ControllerAdvice
public class GeocoderAdvice {
    @ResponseBody
    @ExceptionHandler(GeocodingServiceException.class)
    @ResponseStatus(HttpStatus.SERVICE_UNAVAILABLE)
    String geocodingServiceExceptionHandler(GeocodingServiceException ex) {
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
