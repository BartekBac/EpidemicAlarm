package com.epidemicalarm.api.web.advices;

import com.epidemicalarm.api.exceptions.DiagnosedCaseNotFoundException;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class DiagnosedCaseNotFoundAdvice {
    @ResponseBody
    @ExceptionHandler(DiagnosedCaseNotFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    String diagnosedCaseNotFoundHandler(DiagnosedCaseNotFoundException ex) {
        return ex.getMessage();
    }
}
