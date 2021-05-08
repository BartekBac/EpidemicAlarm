package com.epidemicalarm.api;

import com.epidemicalarm.api.service.GeocoderService;
import com.epidemicalarm.api.service.interfaces.IGeocoderService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ApiApplication {

	public static void main(String[] args) {
		SpringApplication.run(ApiApplication.class, args);
		IGeocoderService geocoderService = new GeocoderService();
		try {
			System.out.println("Found: " + geocoderService.geocode("test"));
		} catch (Exception e) {
			System.out.println("Exception: " + e.toString());
		}
	}

}
