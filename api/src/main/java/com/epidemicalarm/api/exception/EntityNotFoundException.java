package com.epidemicalarm.api.exception;

public class EntityNotFoundException extends RuntimeException {
    public EntityNotFoundException(String message) { super("Entity not found: " + message); }
}
