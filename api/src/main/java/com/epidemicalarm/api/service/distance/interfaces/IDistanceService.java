package com.epidemicalarm.api.service.distance.interfaces;

public interface IDistanceService {
    public double calculate(double fromLat, double fromLng, double toLat, double toLng);
}
