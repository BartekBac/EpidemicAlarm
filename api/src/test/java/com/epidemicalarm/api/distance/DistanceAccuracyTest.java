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
        double fromLat = 50.30621763847188;//50.306159210166605;
        double fromLng = 18.695974991098534;//18.69551734071908;

        double toLat = 50.30714462308835;//50.30709038726973;
        double toLng = 18.695714899594282;//18.695251543871603;

        //then
        double expectedDistance = 105;

        runAllStrategiesFor(fromLat, fromLng, toLat, toLng, expectedDistance);
    }

    @Test
    void calculateFootballPitchLWidth() {
        //given
        double fromLat = 50.30657180419198;//50.30657335410066;
        double fromLng = 18.694908442938786;//18.69490817809401;

        double toLat = 50.30668184608668;//50.30668299058186;
        double toLng = 18.695845406463896;//18.695844269034996;

        //then
        double expectedDistance = 68;

        runAllStrategiesFor(fromLat, fromLng, toLat, toLng, expectedDistance);
    }

    @Test
    void calculateRunway3200Length() {//Katowice-Pyrzowice
        //given
        double fromLat = 50.47595330937944;//50.47595248859598;
        double fromLng = 19.104649572437836;//19.104644561776578;

        double toLat = 50.47604836247455;//50.47605265834345;
        double toLng = 19.0596100937548; //19.05961330774401;

        //then
        double expectedDistance = 3200;

        runAllStrategiesFor(fromLat, fromLng, toLat, toLng, expectedDistance);
    }

    @Test
    void calculateRunway2550Length() { // Krakow-Balice
        //given
        double fromLat = 50.075404388171364;//50.075396979282154;
        double fromLng = 19.768079302040263;//19.768075022366016;

        double toLat = 50.08025707025488;//50.08025687682499;
        double toLng = 19.80292005987431;//19.802919029252273;

        //then
        double expectedDistance = 2550;

        runAllStrategiesFor(fromLat, fromLng, toLat, toLng, expectedDistance);
    }

    @Test
    void calculateRunway1200Length() {// Arłamów-Krajna
        //given
        double fromLat = 49.65300391765174;
        double fromLng = 22.516047870428682;

        double toLat = 49.66352903014466;
        double toLng = 22.512411380010406;

        //then
        double expectedDistance = 1200;

        runAllStrategiesFor(fromLat, fromLng, toLat, toLng, expectedDistance);
    }

}
