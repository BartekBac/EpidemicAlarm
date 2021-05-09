package com.epidemicalarm.api.web;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.service.geocoder.dtos.GeocoderPosition;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
@RequestMapping("api/service/geocoder")
public class GeocoderController {
    @Autowired
    private IGeocoderService geocoderService;

    @GetMapping("/geocode")
    public GeocoderPosition geocode(@Validated @RequestBody Address address) throws IOException, InterruptedException {
        return this.geocoderService.geocode(address);
    }
}
