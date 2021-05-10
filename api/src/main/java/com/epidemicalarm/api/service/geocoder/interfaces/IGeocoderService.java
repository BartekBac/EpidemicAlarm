package com.epidemicalarm.api.service.geocoder.interfaces;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.exception.GeocoderServiceException;
import com.epidemicalarm.api.service.geocoder.dto.GeocoderPosition;

import java.io.IOException;

public interface IGeocoderService {
    GeocoderPosition geocode(Address address) throws GeocoderServiceException, IOException, InterruptedException;
}
