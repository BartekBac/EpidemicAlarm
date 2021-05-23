package com.epidemicalarm.api.service.geocoder;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.exception.GeocoderServiceException;
import com.epidemicalarm.api.service.geocoder.dto.GeocoderPosition;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderStrategy;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.extern.java.Log;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Locale;

@Log
public class GeocoderOpenCage implements IGeocoderStrategy {

    private static final String GEOCODING_RESOURCE = "https://api.opencagedata.com/geocode/v1/json";
    private static final String API_KEY = "7e9a4820669d4967993c48492e0c2d23";

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

                JsonNode city = item.at("/components/city");
                if(city != null && !city.asText().isEmpty()) {
                    position.city = city.asText();
                } else {
                    city = item.at("/components/town");
                    if(city != null) position.city = city.asText();
                }

                JsonNode region = item.at("/components/state");
                if(region != null) position.region = region.asText().replace("województwo ", "").toLowerCase(Locale.ROOT);;

                JsonNode subregion = item.at("/components/county");
                if(subregion != null && !subregion.asText().isEmpty()) {
                    position.subregion = subregion.asText().replace("powiat ", "").toLowerCase(Locale.ROOT);
                } else {
                    position.subregion = position.city.toLowerCase(Locale.ROOT);
                }

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
