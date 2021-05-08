package com.epidemicalarm.api.exceptions;

import com.epidemicalarm.api.domain.DiagnosedCase;

public class GeocodingServiceException extends RuntimeException {
    public GeocodingServiceException(String info) { super("Exception occurred when connecting to geocoding service: Internal error: ["+info+"]."); }
}
