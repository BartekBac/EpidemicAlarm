package com.epidemicalarm.api.dto;

import java.sql.Date;

public class DiagnosedCaseDTO {
    public Date diagnosisDate;
    public int duration; // in days
    public Date expirationDate;
    public int status;
    public Double locationLat;
    public Double locationLng;
    public Long identity;
    public Long institution;
    public Long introducer;
}
