package com.epidemicalarm.api.geocoding;

import com.epidemicalarm.api.domain.Address;
import com.epidemicalarm.api.service.geocoder.GeocoderLocationIQ;
import com.epidemicalarm.api.service.geocoder.GeocoderService;
import com.epidemicalarm.api.service.geocoder.dto.GeocoderPosition;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderService;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.Assert;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;

@SpringBootTest
class LocationIQGeocoderTest {

    private static IGeocoderService geocoderService;
    private static int DECIMAL_PRECISION_POSITION = 4;

    private static double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();

        BigDecimal bd = BigDecimal.valueOf(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }

    @BeforeAll
    static void setGeocoderService() {
        geocoderService = new GeocoderService();
        geocoderService.setGeocoderStrategy(new GeocoderLocationIQ());
    }

    @Test
    void shouldDefaultGeocoderGeocodeInSmallTown() throws IOException, InterruptedException {
        //given
        Address address = new Address(
                "Kowalewo Pomorskie",
                "Odrodzenia",
                "18",
                "87-410");
        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;
        double originalLat = 53.15721924767368;
        double originalLng = 18.88881030523638;

        //when
        GeocoderPosition result = geocoderService.geocode(address);
        result.lat = round(result.lat, decimalPrecisionPositionError);
        result.lng = round(result.lng, decimalPrecisionPositionError);

        //then
        GeocoderPosition expectedResponse = new GeocoderPosition();
        expectedResponse.lat = round(originalLat, decimalPrecisionPositionError);
        expectedResponse.lng = round(originalLng, decimalPrecisionPositionError);
        expectedResponse.city = "Kowalewo Pomorskie";
        expectedResponse.subregion = "golubsko-dobrzyński";
        expectedResponse.region = "kujawsko-pomorskie";

        Assert.isTrue(result.lat == expectedResponse.lat,
                "Latitude error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedResponse.lat +
                        "\nReturned: " + result.lat);

        Assert.isTrue(result.lng == expectedResponse.lng,
                "Longitude error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedResponse.lng +
                        "\nReturned: " + result.lng);

        Assert.isTrue(result.region.equals(expectedResponse.region),
                "Geocoded Region does not match" +
                        "\nExpected: " + expectedResponse.region +
                        "\nReturned: " + result.region);

        /*Assert.isTrue(result.subregion.equals(expectedResponse.subregion),
                "Geocoded Subregion does not match" +
                        "\nExpected: " + expectedResponse.subregion +
                        "\nReturned: " + result.subregion);*/

        Assert.isTrue(result.city.equals(expectedResponse.city),
                "Geocoded City does not match" +
                        "\nExpected: " + expectedResponse.city +
                        "\nReturned: " + result.city);
    }

    @Test
    void shouldDefaultGeocoderGeocodeInCity() throws IOException, InterruptedException {
        //given
        Address address = new Address(
                "Mikołów",
                "Rybnicka",
                "62",
                "43-190");
        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;
        double originalLat = 50.17279252319675;
        double originalLng = 18.884780732527414;

        //when
        GeocoderPosition result = geocoderService.geocode(address);
        result.lat = round(result.lat, decimalPrecisionPositionError);
        result.lng = round(result.lng, decimalPrecisionPositionError);

        //then
        GeocoderPosition expectedResponse = new GeocoderPosition();
        expectedResponse.lat = round(originalLat, decimalPrecisionPositionError);
        expectedResponse.lng = round(originalLng, decimalPrecisionPositionError);
        expectedResponse.city = "Mikołów";
        expectedResponse.subregion = "mikołowski";
        expectedResponse.region = "śląskie";

        Assert.isTrue(result.lat == expectedResponse.lat,
                "Latitude error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedResponse.lat +
                        "\nReturned: " + result.lat);

        Assert.isTrue(result.lng == expectedResponse.lng,
                "Longitude error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedResponse.lng +
                        "\nReturned: " + result.lng);

        Assert.isTrue(result.region.equals(expectedResponse.region),
                "Geocoded Region does not match" +
                        "\nExpected: " + expectedResponse.region +
                        "\nReturned: " + result.region);

        /*Assert.isTrue(result.subregion.equals(expectedResponse.subregion),
                "Geocoded Subregion does not match" +
                        "\nExpected: " + expectedResponse.subregion +
                        "\nReturned: " + result.subregion);*/

        Assert.isTrue(result.city.equals(expectedResponse.city),
                "Geocoded City does not match" +
                        "\nExpected: " + expectedResponse.city +
                        "\nReturned: " + result.city);
    }

    @Test
    void shouldDefaultGeocoderGeocodeInCapitalCity() throws IOException, InterruptedException {
        //given
        Address address = new Address(
                "Warszawa",
                "Aleje Jerozolimskie",
                "152",
                "02-326");
        int decimalPrecisionPositionError = DECIMAL_PRECISION_POSITION;
        double originalLat = 52.2111098921492;
        double originalLng = 20.950065661687532;

        //when
        GeocoderPosition result = geocoderService.geocode(address);
        result.lat = round(result.lat, decimalPrecisionPositionError);
        result.lng = round(result.lng, decimalPrecisionPositionError);

        //then
        GeocoderPosition expectedResponse = new GeocoderPosition();
        expectedResponse.lat = round(originalLat, decimalPrecisionPositionError);
        expectedResponse.lng = round(originalLng, decimalPrecisionPositionError);
        expectedResponse.city = "Warszawa";
        expectedResponse.subregion = "warszawa";
        expectedResponse.region = "mazowieckie";

        Assert.isTrue(result.lat == expectedResponse.lat,
                "Latitude error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedResponse.lat +
                        "\nReturned: " + result.lat);

        Assert.isTrue(result.lng == expectedResponse.lng,
                "Longitude error is bigger than " +
                        decimalPrecisionPositionError +
                        " decimal precision position." +
                        "\nExpected: " + expectedResponse.lng +
                        "\nReturned: " + result.lng);

        Assert.isTrue(result.region.equals(expectedResponse.region),
                "Geocoded Region does not match" +
                        "\nExpected: " + expectedResponse.region +
                        "\nReturned: " + result.region);

        /*Assert.isTrue(result.subregion.equals(expectedResponse.subregion),
                "Geocoded Subregion does not match" +
                        "\nExpected: " + expectedResponse.subregion +
                        "\nReturned: " + result.subregion);*/

        Assert.isTrue(result.city.equals(expectedResponse.city),
                "Geocoded City does not match" +
                        "\nExpected: " + expectedResponse.city +
                        "\nReturned: " + result.city);
    }
}
