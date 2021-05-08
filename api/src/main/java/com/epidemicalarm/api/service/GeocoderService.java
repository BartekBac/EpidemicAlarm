package com.epidemicalarm.api.service;

import com.epidemicalarm.api.exceptions.GeocodingServiceException;
import com.epidemicalarm.api.service.dtos.GeocoderPosition;
import com.epidemicalarm.api.service.interfaces.IGeocoderService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class GeocoderService implements IGeocoderService {

    private static final String GEOCODING_RESOURCE = "https://geocode.search.hereapi.com/v1/geocode";
    //private static final String API_KEY = "Q4JrNjg37B1GUf4xrexwm77ZYSp27DKBK1dhm-woKwk";
    private static final String API_KEY = "U6sGpu3HP7ZuMTtfCTo9PhZhjjoDyDFjlVFM5be32m0";
    private static final int TIMEOUT = 2000;

    private final HttpClient httpClient;


    public GeocoderService() {
        this.httpClient = HttpClient.newHttpClient();
    }

    private String sendRequest(String query) throws IOException, InterruptedException {
        String encodedQuery = URLEncoder.encode(query,"UTF-8");
        String requestUri = GEOCODING_RESOURCE + "?apiKey=" + API_KEY + "&q=" + encodedQuery;

        HttpRequest geocodingRequest = HttpRequest.newBuilder().GET().uri(URI.create(requestUri))
                .timeout(Duration.ofMillis(TIMEOUT)).build();

        HttpResponse<String> geocodingResponse = this.httpClient.send(geocodingRequest,
                HttpResponse.BodyHandlers.ofString());

        return geocodingResponse.body();
    }

    @Override
    public String geocode(String query) throws GeocodingServiceException, IOException, InterruptedException {
        ObjectMapper mapper = new ObjectMapper();
        System.out.println("before send request");
        String response = this.sendRequest("11 Wall St, New York, NY 10005");
        System.out.println("after send request:");
        System.out.println(response);
        JsonNode responseJsonNode = mapper.readTree(response);

        JsonNode error = responseJsonNode.get("error");

        if(error != null ) {
            JsonNode errorDescription = responseJsonNode.get("error_description");
            throw new GeocodingServiceException("Error: " + error.asText() +", description: " + errorDescription.asText());
        }

        JsonNode items = responseJsonNode.get("items");

        String toReturn = "";

        for (JsonNode item : items) {
            JsonNode address = item.get("address");
            String label = address.get("label").asText();
            JsonNode position = item.get("position");

            double lat = position.get("lat").asDouble();
            double lng = position.get("lng").asDouble();
            toReturn += label + " is located at " + lat + "," + lng + ".";
        }

        return toReturn;
    }

}