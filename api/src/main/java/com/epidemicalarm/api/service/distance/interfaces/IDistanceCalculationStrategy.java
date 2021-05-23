package com.epidemicalarm.api.service.distance.interfaces;

public interface IDistanceCalculationStrategy {
    double compute(double fromLat, double fromLng, double toLat, double toLng);
}
