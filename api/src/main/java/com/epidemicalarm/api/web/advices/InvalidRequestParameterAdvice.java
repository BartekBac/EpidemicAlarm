package com.epidemicalarm.api.web.advices;

import com.epidemicalarm.api.exception.EntityNotFoundException;
import com.epidemicalarm.api.exception.InvalidRequestParameterException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class InvalidRequestParameterAdvice {
    @ResponseBody
    @ExceptionHandler(InvalidRequestParameterException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    String invalidRequestParameterHandler(InvalidRequestParameterException ex) {
        return ex.getMessage();
    }
}
