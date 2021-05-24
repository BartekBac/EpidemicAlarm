package com.epidemicalarm.api.service.distance.interfaces;

public interface IDistanceService {
    double calculate(double fromLat, double fromLng, double toLat, double toLng);
    void setCalculatingStrategy(IDistanceCalculationStrategy distanceCalculationStrategy);
}
