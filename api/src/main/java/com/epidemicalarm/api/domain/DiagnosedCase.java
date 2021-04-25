package com.epidemicalarm.api.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.sql.Date;

@Data
@Builder
@AllArgsConstructor
@Entity
public class DiagnosedCase extends DBEntity {

    private Date diagnosisDate;
    private int duration; // in days
    private Date expirationDate;
    private int status;
    private double locationLat;
    private double locationLng;
    @ManyToOne
    @JoinColumn(name = "identityId", referencedColumnName = "id")
    private Identity identity;
    @ManyToOne
    @JoinColumn(name = "institutionId", referencedColumnName = "id")
    private Institution institution;
    @ManyToOne
    @JoinColumn(name = "dataAdministratorId", referencedColumnName = "id")
    private DataAdministrator introducer;

    public DiagnosedCase() {}
}
