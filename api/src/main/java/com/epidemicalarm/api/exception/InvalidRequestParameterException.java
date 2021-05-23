package com.epidemicalarm.api.exception;

public class InvalidRequestParameterException extends RuntimeException {
    public InvalidRequestParameterException(String name, String value, String explanation) { super("Invalid request parameter value. [NAME=" + name + ", VALUE=" + value + "] Explanation: " + explanation); }
}
