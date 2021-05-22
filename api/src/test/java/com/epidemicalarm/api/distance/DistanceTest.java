package com.epidemicalarm.api.distance;

import com.epidemicalarm.api.service.distance.DistanceService;
import com.epidemicalarm.api.service.distance.interfaces.IDistanceService;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.Assert;

import java.math.BigDecimal;
import java.math.RoundingMode;

@SpringBootTest
class DistanceTest {

    private static IDistanceService distanceService;
    private static int DECIMAL_PRECISION_POSITION = 4;

    private static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();

        BigDecimal bd = BigDecimal.valueOf(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }

    @BeforeAll
    static void setDistanceService() {
        distanceService = new DistanceService();
    }

    @Test
    void shouldCalculate10MDistance() {
        //given
        double fromLat = 50.13984915211152;
        double fromLng = 18.87138099213793;

        double toLat = 50.13989162222431;
        double toLng = 18.871232013831772;

        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;

        //when
        double result = distanceService.calculate(fromLat, fromLng, toLat, toLng);
        result = round(result, 1);

        //then
        double expectedDistance = 11.6;

        Assert.isTrue(result == expectedDistance,
                "Distance error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedDistance +
                        "\nReturned: " + result);
    }

    @Test
    void shouldCalculate40MDistance() {
        //given
        double fromLat = 50.13984915211152;
        double fromLng = 18.87138099213793;

        double toLat = 50.139987765767636;
        double toLng = 18.870831205915966;

        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;

        //when
        double result = distanceService.calculate(fromLat, fromLng, toLat, toLng);
        result = round(result, 1);

        //then
        double expectedDistance = 42.1;

        Assert.isTrue(result == expectedDistance,
                "Distance error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedDistance +
                        "\nReturned: " + result);
    }

    @Test
    void shouldCalculate100MDistance() {
        //given
        double fromLat = 50.13984915211152;
        double fromLng = 18.87138099213793;

        double toLat = 50.14018402054949;
        double toLng = 18.87004015982688;

        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;

        //when
        double result = distanceService.calculate(fromLat, fromLng, toLat, toLng);
        result = round(result, 1);

        //then
        double expectedDistance = 102.6;

        Assert.isTrue(result == expectedDistance,
                "Distance error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedDistance +
                        "\nReturned: " + result);
    }

    @Test
    void shouldCalculate200MDistance() {
        //given
        double fromLat = 50.13984915211152;
        double fromLng = 18.87138099213793;

        double toLat = 50.14056428005642;
        double toLng = 18.868580766005945;

        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;

        //when
        double result = distanceService.calculate(fromLat, fromLng, toLat, toLng);
        result = round(result, 1);

        //then
        double expectedDistance = 214.8;

        Assert.isTrue(result == expectedDistance,
                "Distance error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedDistance +
                        "\nReturned: " + result);
    }

    @Test
    void shouldCalculate700MDistance() {
        //given
        double fromLat = 50.13984915211152;
        double fromLng = 18.87138099213793;

        double toLat = 50.142094134576055;
        double toLng = 18.862278602320597;

        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;

        //when
        double result = distanceService.calculate(fromLat, fromLng, toLat, toLng);
        result = round(result, 1);

        //then
        double expectedDistance = 695.1;

        Assert.isTrue(result == expectedDistance,
                "Distance error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedDistance +
                        "\nReturned: " + result);
    }

    @Test
    void shouldCalculate1400MDistance() {
        //given
        double fromLat = 50.13984915211152;
        double fromLng = 18.87138099213793;

        double toLat = 50.1434520092474;
        double toLng = 18.852182206913692;

        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;

        //when
        double result = distanceService.calculate(fromLat, fromLng, toLat, toLng);
        result = round(result, 0);

        //then
        double expectedDistance = 1426;

        Assert.isTrue(result == expectedDistance,
                "Distance error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedDistance +
                        "\nReturned: " + result);
    }
}
