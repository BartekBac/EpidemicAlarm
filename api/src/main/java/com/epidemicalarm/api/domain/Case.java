package com.epidemicalarm.api.domain;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import java.sql.Date;

@Entity
public class Case extends DBEntity {

    private Date diagnosisDate;
    private int duration; // in days
    private Date expirationDate;
    private int status;
    private double locationLat;
    private double locationLng;
    @ManyToOne
    @JoinColumn(name = "identityId", referencedColumnName = "id")
    private Identity identity;
    private long identityId;
    @ManyToOne
    @JoinColumn(name = "institutionId", referencedColumnName = "id")
    private Institution institution;
    @ManyToOne
    @JoinColumn(name = "dataAdministratorId", referencedColumnName = "id")
    private DataAdministrator introducer;
}
