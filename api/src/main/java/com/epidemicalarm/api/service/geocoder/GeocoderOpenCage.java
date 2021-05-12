package com.epidemicalarm.api.service.geocoder;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.exception.GeocoderServiceException;
import com.epidemicalarm.api.service.geocoder.dto.GeocoderPosition;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderStrategy;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.extern.java.Log;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

@Log
public class GeocoderOpenCage implements IGeocoderStrategy {

    private static final String GEOCODING_RESOURCE = "https://api.opencagedata.com/geocode/v1/json";
    private static final String API_KEY = "a7dcdd1891744e9c9344468cad076577";

    private final double scoreLowerLimit = 5.0;
    
    @Override
    public String prepareRequest(Address address) throws UnsupportedEncodingException {
        String query = address.getStreet() + " " + address.getHouseNumber() + ", " + address.getZipCode() + " " + address.getCity() + ", Polska";
        String encodedQuery = URLEncoder.encode(query,"UTF-8");
        String requestUri = GEOCODING_RESOURCE + "?q=" + encodedQuery + "&key=" + API_KEY + "&language=pl&pretty=1";
        return requestUri;
    }

    @Override
    public GeocoderPosition decodeResponse(JsonNode response) {
        JsonNode status = response.get("status");
        if(status.get("code").asInt() != 200) {
            String errorMsg = "Error: [CODE="+status.get("code").asText()+"] message: " + status.get("message");
            log.severe(errorMsg);
            throw new GeocoderServiceException(errorMsg);
        }

        log.info("Response:");
        log.info(response.toPrettyString());

        JsonNode items = response.get("results");
        double maxScore = 0.0;
        GeocoderPosition position = new GeocoderPosition();
        for (JsonNode item : items) {
            double score = item.get("confidence").asDouble();
            if(score > maxScore) {
                maxScore = score;
                position.lat = item.at("/geometry/lat").asDouble();
                position.lng = item.at("/geometry/lng").asDouble();
            }
        }

        if(maxScore < this.scoreLowerLimit) {
            String errorMsg = "Query response score do not satisfy requirements: " + (maxScore * 10) + "% < " + (this.scoreLowerLimit*10) + "%.";
            log.severe(errorMsg);
            throw new GeocoderServiceException(errorMsg);
        }

        log.info("Found position: [LAT="+position.lat+", LNG="+position.lng+"] with score "+(maxScore*10)+"%");

        return position;
    }
}
