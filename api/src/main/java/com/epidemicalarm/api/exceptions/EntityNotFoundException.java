package com.epidemicalarm.api.exceptions;

public class EntityNotFoundException extends RuntimeException {
    public EntityNotFoundException(String message) { super("Entity not found: " + message); }
}
