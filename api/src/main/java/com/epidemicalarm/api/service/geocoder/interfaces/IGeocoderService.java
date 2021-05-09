package com.epidemicalarm.api.service.geocoder.interfaces;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.exceptions.GeocodingServiceException;
import com.epidemicalarm.api.service.geocoder.dtos.GeocoderPosition;

import java.io.IOException;

public interface IGeocoderService {
    GeocoderPosition geocode(Address address) throws GeocodingServiceException, IOException, InterruptedException;
}
