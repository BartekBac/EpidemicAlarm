package com.epidemicalarm.api.web;

import com.epidemicalarm.api.service.interfaces.IGeocoderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("api/service/geocoder")
public class GeocoderController {
    @Autowired
    private IGeocoderService geocoderService;

    @GetMapping("/geocode/{query}")
    public String geocode(@PathVariable(value = "query") String query) throws IOException, InterruptedException {
        return this.geocoderService.geocode(query);
    }
}
