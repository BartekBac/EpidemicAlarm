package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.exceptions.GeocodingServiceException;
import com.epidemicalarm.api.service.dtos.GeocoderPosition;

import java.io.IOException;

public interface IGeocoderService {
    String geocode(String query) throws GeocodingServiceException, IOException, InterruptedException;
}
