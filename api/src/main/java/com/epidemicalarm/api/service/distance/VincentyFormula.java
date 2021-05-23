package com.epidemicalarm.api.service.distance;

import com.epidemicalarm.api.service.distance.interfaces.IDistanceCalculationStrategy;

public class VincentyFormula implements IDistanceCalculationStrategy {

    private double rad(double degrees) {
        return degrees * Math.PI / 180.0;
    }

    @Override
    public double compute(double fromLat, double fromLng, double toLat, double toLng) {
        double fromLatRad = rad(fromLat);
        double toLatRad = rad(toLat);
        double lngDifferenceRad = rad(Math.abs(toLng - fromLng));

        double sin1 = Math.sin(fromLatRad);
        double sin2 = Math.sin(toLatRad);
        double cos1 = Math.cos(fromLatRad);
        double cos2 = Math.cos(toLatRad);
        double sind = Math.sin(lngDifferenceRad);
        double cosd = Math.cos(lngDifferenceRad);

        double R = 6371008.8;

        double a = Math.pow(cos2 * sind, 2);
        double b = Math.pow(cos1 * sin2 - sin1 * cos2 * cosd, 2);
        double c = sin1 * sin2 + cos1 * cos2 * cosd;

        double d = Math.atan(Math.sqrt(a + b) / c);

        return d * R;
    }
}
