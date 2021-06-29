package com.epidemicalarm.api.service.distance;

import com.epidemicalarm.api.service.distance.interfaces.IDistanceCalculationStrategy;

public class VincentyFormula implements IDistanceCalculationStrategy {

    private final double a = 6378137.0;
    private final double f = 1.0 / 298.257223563;
    private final double b = 6356752.314245;
    private static final int MAX_ITERATIONS = 100;

    private double rad(double degrees) {
        return degrees * Math.PI / 180.0;
    }

    @Override
    public double compute(double fromLat, double fromLng, double toLat, double toLng) {
        // initial constants
        final double U1 = Math.atan((1.0 - f)*Math.tan(rad(fromLat)));
        final double U2 = Math.atan((1.0 - f)*Math.tan(rad(toLat)));
        final double L1 = rad(fromLng);
        final double L2 = rad(toLng);
        final double L = Math.abs(L2 - L1);

        // iteration variables
        double d = L;
        double newD = 0;
        double sinSig = 0;
        double cosSig = 0;
        double sig = 0;
        double cos2SigM = 0;
        double C = 0;
        double sina = 0;
        double cos2a = 0;
        double sin2a = 0;

        // performance-enhancing variables
        double sinU1 = Math.sin(U1);
        double cosU1 = Math.cos(U1);
        double sinU2 = Math.sin(U2);
        double cosU2 = Math.cos(U2);
        double cosd = Math.cos(d); // UPDATE IN LOOP!
        double sind = Math.sin(d); // UPDATE IN LOOP!

        for(int i=0; i < MAX_ITERATIONS; i++) {
            sinSig = Math.sqrt(Math.pow(cosU2*sind,2) + Math.pow(cosU1*sinU2 - sinU1*cosU2*cosd, 2));
            cosSig = sinU1*sinU2 + cosU1*cosU2*cosd;
            sig = Math.atan2(sinSig, cosSig);
            sina = cosU1 * cosU2 * sind / sinSig;
            sin2a = Math.pow(sina, 2);
            cos2a = 1 - sin2a;
            cos2SigM = cosSig - (2*sinU1*sinU2/cos2a);
            C = f / 16.0 * cos2a * (4 + f*(4-3*cos2a));
            newD = L + (1 - C) * f * sina * (sig + C*sinSig*(cos2SigM + C*cosSig*(-1 + 2*Math.pow(cos2SigM,2))));
            if(newD == d)
                break;
            d=newD;
            cosd = Math.cos(d);
            sind = Math.sin(d);
        }

        double cos22SigM = Math.pow(cos2SigM, 2);
        double u2 = cos2a * ((Math.pow(a,2) - Math.pow(b,2))/Math.pow(b,2));
        double A = 1 + u2 / 16384.0 * (4096 + u2*(-768 + u2*(320-175*u2)));
        double B = u2 / 1024.0 * (256 + u2*(-128+u2*(74-47*u2)));
        double dSig = B * sinSig * (cos2SigM + 0.25*B*(cosSig * (-1 + 2*cos22SigM) - B/6.0*cos2SigM*(-3 + 4*Math.pow(sinSig,2))*(-3 + 4*cos22SigM)));
        double s = b*A*(sig - dSig);

        return s;
    }
}
