package com.epidemicalarm.api.service.distance;

import com.epidemicalarm.api.service.distance.interfaces.IDistanceCalculationStrategy;

public class SphericalCosineLaw implements IDistanceCalculationStrategy {

    private final double R = 6371008.8;

    private double rad(double degrees) {
        return degrees * Math.PI / 180.0;
    }

    @Override
    public double compute(double fromLat, double fromLng, double toLat, double toLng) {
        double lngDifference = Math.abs(toLng - fromLng);

        double d = Math.acos(
                (Math.sin(rad(fromLat)) * Math.sin(rad(toLat))) +
                        (Math.cos(rad(fromLat)) * Math.cos(rad(toLat)) * Math.cos(rad(lngDifference)))
        );

        return d*R;
    }
}
