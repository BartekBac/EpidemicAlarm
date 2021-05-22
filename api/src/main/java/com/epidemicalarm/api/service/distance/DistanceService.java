package com.epidemicalarm.api.service.distance;

import com.epidemicalarm.api.service.distance.interfaces.IDistanceService;

public class DistanceService implements IDistanceService {

    private double rad(double degrees) {
        return degrees * Math.PI / 180.0;
    }

    private double haversine(double fromLat, double fromLng, double toLat, double toLng)
    {
        double fromLatRad = rad(fromLat);
        double toLatRad = rad(toLat);
        double lngDifferenceRad = rad(Math.abs(toLng - fromLng));
        double latDifferenceRad = rad(Math.abs(toLat - fromLat));

        double R = 6371008.8;

        double a = Math.pow(Math.sin(latDifferenceRad/2), 2) +
                   Math.cos(fromLatRad) * Math.cos(toLatRad) *
                   Math.pow(Math.sin(lngDifferenceRad/2), 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1- a));

        double d = R * c;

        return d;
    }

    private double orthodroma(double fromLat, double fromLng, double toLat, double toLng) {
        double lngDifference = Math.abs(toLng - fromLng);

        double d = Math.acos(
                (Math.sin(fromLat) * Math.sin(toLat)) +
                (Math.cos(fromLat) * Math.cos(toLat) * Math.cos(lngDifference))
        );

        double toMeterConverter = 111195.0;

        return d*toMeterConverter;
    }

    @Override
    public double calculate(double fromLat, double fromLng, double toLat, double toLng) {
        return haversine(fromLat, fromLng, toLat, toLng);
    }
}
