package com.epidemicalarm.api.service.geocoder;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.exception.GeocoderServiceException;
import com.epidemicalarm.api.service.geocoder.dto.GeocoderPosition;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderService;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderStrategy;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.java.Log;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

@Log
@Service
public class GeocoderService implements IGeocoderService {

    private static final int TIMEOUT = 2000;

    private final HttpClient httpClient;
    private IGeocoderStrategy geocoderStrategy;

    public GeocoderService() {
        this.httpClient = HttpClient.newHttpClient();
        this.geocoderStrategy = new GeocoderOpenCage();
    }

    private String sendRequest(Address address) throws IOException, InterruptedException {

        String requestUri = this.geocoderStrategy.prepareRequest(address);

        log.info("Sending request to geocoding api service: [URI=" + requestUri+ "]..." );

        HttpRequest geocodingRequest = HttpRequest.newBuilder().GET().uri(URI.create(requestUri))
                .timeout(Duration.ofMillis(TIMEOUT)).build();

        HttpResponse<String> geocodingResponse = this.httpClient.send(geocodingRequest,
                HttpResponse.BodyHandlers.ofString());

        return geocodingResponse.body();
    }

    @Override
    public GeocoderPosition geocode(Address address) throws GeocoderServiceException, IOException, InterruptedException {
        ObjectMapper mapper = new ObjectMapper();
        String response = this.sendRequest(address);
        log.info("Mapping response JSON...");
        JsonNode responseJsonNode = mapper.readTree(response);

        return this.geocoderStrategy.decodeResponse(responseJsonNode);
    }

    @Override
    public void setGeocoderStrategy(IGeocoderStrategy strategy) {
        this.geocoderStrategy = strategy;
    }

}