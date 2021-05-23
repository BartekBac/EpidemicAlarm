package com.epidemicalarm.api.service.geocoder.dto;

public class GeocoderPosition {
    public double lat;
    public double lng;
    public String region;
    public String subregion;
    public String city;

    @Override
    public boolean equals(Object o) {

        if (o == this) {
            return true;
        }

        if (!(o instanceof GeocoderPosition)) {
            return false;
        }

        GeocoderPosition g = (GeocoderPosition) o;

        return Double.compare(lat, g.lat) == 0
            && Double.compare(lng, g.lng) == 0
            && region.equals(g.region)
            && subregion.equals(g.subregion)
            && city.equals(g.city);
    }
}
