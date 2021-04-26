package com.epidemicalarm.api.exceptions;

public class DiagnosedCaseNotFoundException extends RuntimeException {
    public DiagnosedCaseNotFoundException(long id) { super("Diagnosed Case [ID="+id+"] not found."); }
}
