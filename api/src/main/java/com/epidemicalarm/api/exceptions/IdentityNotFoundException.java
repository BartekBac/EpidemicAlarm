package com.epidemicalarm.api.exceptions;

public class IdentityNotFoundException extends RuntimeException {
    public IdentityNotFoundException(long id) { super("Identity [ID="+id+"] not found."); }
}
