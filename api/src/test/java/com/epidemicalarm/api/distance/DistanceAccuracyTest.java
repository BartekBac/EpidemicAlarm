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
class DistanceAccuracyTest {

    private static IDistanceService distanceService;

    private static IDistanceCalculationStrategy sphericalCosineLaw;
    private static IDistanceCalculationStrategy haversine;
    private static IDistanceCalculationStrategy vincenty;


    private static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();

        BigDecimal bd = BigDecimal.valueOf(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }

    @BeforeAll
    static void setDistanceService() {
        distanceService = new DistanceService();
        sphericalCosineLaw = new SphericalCosineLaw();
        haversine = new HaversineFormula();
        vincenty = new VincentyFormula();
    }

    private void checkDistanceAccuracy(IDistanceCalculationStrategy method, double fromLat, double fromLng, double toLat, double toLng, double expectedDistance) {
        // given
        distanceService.setCalculatingStrategy(method);

        // when
        double result = distanceService.calculate(fromLat,fromLng,toLat,toLng);
        result = round(result, 2);

        double absError = Math.abs(result - expectedDistance);
        double relError = absError / expectedDistance * 100.0;

        // then
        System.out.println("Parameters: [METHOD=" + method.getClass().getSimpleName()+"]" +
                           ", expected: " + expectedDistance + "m" +
                           ", result: " + result + "m" +
                           ", absolute error = " + absError + "m" +
                           ", relative error = " + relError + "%");
    }

    private void runAllStrategiesFor(double fromLat, double fromLng, double toLat, double toLng, double expectedDistance) {
        checkDistanceAccuracy(sphericalCosineLaw, fromLat, fromLng, toLat, toLng, expectedDistance);
        checkDistanceAccuracy(haversine, fromLat, fromLng, toLat, toLng, expectedDistance);
        checkDistanceAccuracy(vincenty, fromLat, fromLng, toLat, toLng, expectedDistance);
    }

    @Test
    void calculateFootballPitchLength() {
        //given
        double[] coords = {50.30714560617742, 18.69571501739492, 50.306216769494874, 18.695977575123624};

        //then
        double expectedDistance = 105;
        runAllStrategiesFor(coords[0], coords[1], coords[2], coords[3], expectedDistance);
    }

    @Test
    void calculateFootballPitchLWidth() {
        //given
        double[] coords = {50.30657173049385, 18.6949063313804, 50.30668121730405, 18.6958445827004};

        //then
        double expectedDistance = 68;
        runAllStrategiesFor(coords[0], coords[1], coords[2], coords[3], expectedDistance);
    }

    @Test
    void calculateRunway3200Length() {//Katowice-Pyrzowice
        //given
        double[] coords = {50.47604976327174, 19.05960095634041, 50.47595237760386, 19.104657837280257};

        //then
        double expectedDistance = 3200;
        runAllStrategiesFor(coords[0], coords[1], coords[2], coords[3], expectedDistance);
    }

    @Test
    void calculateRunway2550Length() { // Krakow-Balice
        //given
        double[] coords = {50.07540490730931, 19.76808607088357, 50.08024575247447, 19.80290017192372};

        //then
        double expectedDistance = 2550;
        runAllStrategiesFor(coords[0], coords[1], coords[2], coords[3], expectedDistance);
    }

    @Test
    void calculateRunway1200Length() {// Arłamów-Krajna
        //given
        double[] coords = {49.65300391765174, 22.516047870428682, 49.66352903014466, 22.512411380010406};

        //then
        double expectedDistance = 1200;
        runAllStrategiesFor(coords[0], coords[1], coords[2], coords[3], expectedDistance);
    }

}
