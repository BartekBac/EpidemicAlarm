package com.epidemicalarm.api.service.geocoder.interfaces;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.service.geocoder.dto.GeocoderPosition;
import com.fasterxml.jackson.databind.JsonNode;

import java.io.UnsupportedEncodingException;

public interface IGeocoderStrategy {
    String prepareRequest(Address address) throws UnsupportedEncodingException;
    GeocoderPosition decodeResponse(JsonNode response);
}
