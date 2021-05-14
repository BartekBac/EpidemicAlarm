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
public class GeocoderArcGIS implements IGeocoderStrategy {

    private static final String GEOCODING_RESOURCE = "https://geocode-api.arcgis.com/arcgis/rest/services/World/GeocodeServer/findAddressCandidates";
    private static final String API_KEY = "AAPKd1606e58e1ef42469d0170b839c9659fE4CVAXBa4CuGgOk5e__Y9RvA1sGqh2Cj0-7k5WpdYPAwGShMDtIiXFTD8_2DmKtR";

    private final double scoreLowerLimit = 50.0;
    
    @Override
    public String prepareRequest(Address address) throws UnsupportedEncodingException {
        String query = address.getStreet() + " " + address.getHouseNumber() + ", " + address.getCity() + " " + address.getZipCode();
        String encodedQuery = URLEncoder.encode(query,"UTF-8");
        String requestUri = GEOCODING_RESOURCE + "?address=" + encodedQuery + "&maxLocations=3&outFields=location,score,City,Subregion,Region&f=json&token=" + API_KEY;
        return requestUri;
    }

    @Override
    public GeocoderPosition decodeResponse(JsonNode response) {
        log.info("Response:");
        log.info(response.toPrettyString());

        JsonNode items = response.get("candidates");
        double maxScore = 0.0;
        GeocoderPosition position = new GeocoderPosition();
        for (JsonNode item : items) {
            double score = item.get("score").asDouble();
            if(score > maxScore) {
                maxScore = score;
                position.lat = item.at("/location/y").asDouble();
                position.lng = item.at("/location/x").asDouble();
                position.city = item.at("/attributes/City").asText();
                position.subregion = item.at("/attributes/Subregion").asText();
                position.region = item.at("/attributes/Region").asText();
            }
        }

        if(maxScore < this.scoreLowerLimit) {
            String errorMsg = "Query response score do not satisfy requirements: " + (maxScore) + "% < " + (this.scoreLowerLimit) + "%.";
            log.severe(errorMsg);
            throw new GeocoderServiceException(errorMsg);
        }

        log.info("Found position: [LAT="+position.lat+", LNG="+position.lng+"] with score "+(maxScore)+"%");

        return position;
    }
}
