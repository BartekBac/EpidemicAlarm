package com.epidemicalarm.api.exceptions;

public class GeocoderServiceException extends RuntimeException {
    public GeocoderServiceException(String info) { super("Exception occurred when connecting to geocoding service: Internal error: ["+info+"]."); }
}
