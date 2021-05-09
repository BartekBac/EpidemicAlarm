package com.epidemicalarm.api;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.service.geocoder.GeocoderService;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(ApiApplication.class, args);

	}

}
