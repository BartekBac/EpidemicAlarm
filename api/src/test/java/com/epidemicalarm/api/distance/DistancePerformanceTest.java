package com.epidemicalarm.api.distance;

import com.epidemicalarm.api.service.distance.*;
import com.epidemicalarm.api.service.distance.interfaces.IDistanceCalculationStrategy;
import com.epidemicalarm.api.service.distance.interfaces.IDistanceService;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import java.math.BigDecimal;
import java.math.RoundingMode;

@SpringBootTest
class DistancePerformanceTest {

    private static IDistanceService distanceService;
    private static IDistanceCalculationStrategy sphericalCosineLaw;
    private static IDistanceCalculationStrategy haversine;
    private static IDistanceCalculationStrategy vincenty;

    private double fromLat = 50.13984915211152;
    private double fromLng = 18.87138099213793;
    private double toLat = 50.142094134576055;
    private double toLng = 18.862278602320597;

    private int bufferLoopSteps = 10;

    private static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();

        BigDecimal bd = BigDecimal.valueOf(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }

    private void runCalculationWith(IDistanceCalculationStrategy method, int loops) {
        // given
        int N = loops;
        distanceService.setCalculatingStrategy(method);

        // when
        for(int i = 0; i<bufferLoopSteps; i++) {
            distanceService.calculate(fromLat,fromLng,toLat,toLng);
        }
        long start = System.nanoTime();
        for(int i = 0; i<N; i++) {
            distanceService.calculate(i % 90,i % 180,toLat,toLng);
        }
        long stop = System.nanoTime();

        double time = (stop - start) / 1000000.0; // ms

        // then
        System.out.println("Parameters: [METHOD=" + method.getClass().getSimpleName() + ", LOOPS=" + N + "], time elapsed: " + round(time,  2)+ " ms.");
    }

    private void runAllStrategiesFor(int loops) {
        runCalculationWith(sphericalCosineLaw, loops);
        runCalculationWith(haversine, loops);
        runCalculationWith(vincenty, loops);
    }


    @BeforeAll
    static void setDistanceService() {
        distanceService = new DistanceService();
        sphericalCosineLaw = new SphericalCosineLaw();
        haversine = new HaversineFormula();
        vincenty = new VincentyFormula();
    }

    @Test
    void measureCalculationTimes(){
        runAllStrategiesFor(10000);
        runAllStrategiesFor(200000);
        runAllStrategiesFor(1000000);
    }

}
