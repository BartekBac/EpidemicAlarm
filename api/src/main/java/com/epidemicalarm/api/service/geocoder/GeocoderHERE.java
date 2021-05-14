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
public class GeocoderHERE implements IGeocoderStrategy {

    private static final String GEOCODING_RESOURCE = "https://geocode.search.hereapi.com/v1/geocode";
    private static final String API_KEY = "V1CVGerHDhNNx9Oy3Wwtk_YvrNlZ7WDu6LY_BdMVUGQ";

    private final double scoreLowerLimit = 0.5;
    
    @Override
    public String prepareRequest(Address address) throws UnsupportedEncodingException {
        String query = address.getStreet() + " " + address.getHouseNumber() + ", " + address.getCity() + ", " + address.getZipCode();
        String encodedQuery = URLEncoder.encode(query,"UTF-8");
        String requestUri = GEOCODING_RESOURCE + "?apiKey=" + API_KEY + "&q=" + encodedQuery;
        return requestUri;
    }

    @Override
    public GeocoderPosition decodeResponse(JsonNode response) {
        JsonNode error = response.get("error");
        if(error != null ) {
            JsonNode errorDescription = response.get("error_description");
            String errorMsg = "Error: " + error.asText() +", description: " + errorDescription.asText();
            log.severe(errorMsg);
            throw new GeocoderServiceException(errorMsg);
        }
        log.info("Response:");
        log.info(response.toPrettyString());

        JsonNode items = response.get("items");
        double maxScore = 0.0;
        GeocoderPosition position = new GeocoderPosition();
        for (JsonNode item : items) {
            double score = item.at("/scoring/queryScore").asDouble();
            if(score > maxScore) {
                maxScore = score;
                position.lat = item.at("/position/lat").asDouble();
                position.lng = item.at("/position/lng").asDouble();
                position.city = item.at("/address/city").asText();
                position.subregion = item.at("/address/county").asText();
                position.region = item.at("/address/state").asText();
            }
        }

        if(maxScore < this.scoreLowerLimit) {
            String errorMsg = "Query response score do not satisfy requirements: " + (maxScore * 100) + "% < " + (this.scoreLowerLimit*100) + "%.";
            log.severe(errorMsg);
            throw new GeocoderServiceException(errorMsg);
        }

        log.info("Found position: [LAT="+position.lat+", LNG="+position.lng+"] with score "+(maxScore*100)+"%");

        return position;
    }
}
