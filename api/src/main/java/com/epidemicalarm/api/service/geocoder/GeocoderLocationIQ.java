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
public class GeocoderLocationIQ implements IGeocoderStrategy {

    private static final String GEOCODING_RESOURCE = "https://eu1.locationiq.com/v1/search.php";
    private static final String API_KEY = "pk.0547b396db209b1985d92d2d9ce8bff7";

    private final double scoreLowerLimit = 0.5;

    @Override
    public String prepareRequest(Address address) throws UnsupportedEncodingException {
        String encodedStreet = URLEncoder.encode(address.getStreet()+" "+address.getHouseNumber(),"UTF-8");
        String encodedCity = URLEncoder.encode(address.getCity(),"UTF-8");
        String encodedZipCode = URLEncoder.encode(address.getZipCode(),"UTF-8");
        String requestUri = GEOCODING_RESOURCE + "?key=" + API_KEY + "&street=" + encodedStreet + "&city=" + encodedCity + "&county=" + encodedCity + "&country=Poland&postalcode=" + encodedZipCode + "&format=json&addressdetails=1&accept-language=pl";
        return requestUri;
    }

    @Override
    public GeocoderPosition decodeResponse(JsonNode response) {
        JsonNode error = response.get("error");
        if(error != null ) {
            String errorMsg = "Error: " + error.asText();
            log.severe(errorMsg);
            throw new GeocoderServiceException(errorMsg);
        }

        log.info("Response:");
        log.info(response.toPrettyString());

        double maxScore = 0.0;
        GeocoderPosition position = new GeocoderPosition();

        if (response.isArray()) {
            for (final JsonNode item : response) {
                double score = item.get("importance").asDouble();
                if(score > maxScore) {
                    maxScore = score;
                    position.lat = item.get("lat").asDouble();
                    position.lng = item.get("lon").asDouble();

                    JsonNode city = item.at("/address/city");
                    if(city != null && !city.asText().isEmpty()) {
                        position.city = city.asText();
                    } else {
                        city = item.at("/address/town");
                        if(city != null) position.city = city.asText();
                    }

                    JsonNode region = item.at("/address/state");
                    if(region != null) position.region = region.asText().replace("wojew??dztwo ", "").toLowerCase(Locale.ROOT);

                    JsonNode subregion = item.at("/address/county");
                    if(subregion != null) {
                        position.subregion = subregion.asText().replace("powiat ", "").toLowerCase(Locale.ROOT);
                    }
                }
            }
        } else {
            String errorMsg = "Error: Cannot retrieve json array response from LocationIQ service API.";
            log.severe(errorMsg);
            throw new GeocoderServiceException(errorMsg);
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