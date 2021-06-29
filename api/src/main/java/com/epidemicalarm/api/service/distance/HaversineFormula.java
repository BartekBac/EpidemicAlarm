package com.epidemicalarm.api.service.distance;

import com.epidemicalarm.api.service.distance.interfaces.IDistanceCalculationStrategy;

public class HaversineFormula implements IDistanceCalculationStrategy {

    private final double R = 6371008.8;

    private double rad(double degrees) {
        return degrees * Math.PI / 180.0;
    }

    private double hav(double angle) {
        return Math.pow(Math.sin(angle / 2.0), 2);
    }

    @Override
    public double compute(double fromLat, double fromLng, double toLat, double toLng) {
        final double fromLatRad = rad(fromLat);
        final double toLatRad = rad(toLat);
        final double lngDifferenceRad = rad(Math.abs(toLng - fromLng));
        final double latDifferenceRad = rad(Math.abs(toLat - fromLat));

        double a = hav(latDifferenceRad) + Math.cos(fromLatRad) * Math.cos(toLatRad) * hav(lngDifferenceRad);

        /*double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));*/
        double c = 2 * Math.atan(Math.sqrt(a) / Math.sqrt(1 - a));

        double d = R * c;

        return d;
    }
}
