package com.epidemicalarm.api.service.distance;

import com.epidemicalarm.api.service.distance.interfaces.IDistanceCalculationStrategy;
import com.epidemicalarm.api.service.distance.interfaces.IDistanceService;
import org.springframework.stereotype.Service;

@Service
public class DistanceService implements IDistanceService {

    IDistanceCalculationStrategy distanceCalculationStrategy;

    public DistanceService() {
        this.distanceCalculationStrategy = new HaversineFormula();
    }

    public DistanceService(IDistanceCalculationStrategy distanceCalculationStrategy) {
        this.distanceCalculationStrategy = distanceCalculationStrategy;
    }

    @Override
    public double calculate(double fromLat, double fromLng, double toLat, double toLng) {
        return distanceCalculationStrategy.compute(fromLat, fromLng, toLat, toLng);
    }

    @Override
    public void setCalculatingStrategy(IDistanceCalculationStrategy distanceCalculationStrategy) {
        this.distanceCalculationStrategy = distanceCalculationStrategy;
    }
}
