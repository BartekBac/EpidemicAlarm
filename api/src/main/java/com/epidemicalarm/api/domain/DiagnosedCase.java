package com.epidemicalarm.api.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIdentityReference;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.CascadeType;
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
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id", scope = DiagnosedCase.class)
    @JsonIdentityReference(alwaysAsId = true)
    @ManyToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "identityId", referencedColumnName = "id")
    private Identity identity;
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id", scope = DiagnosedCase.class)
    @JsonIdentityReference(alwaysAsId = true)
    @ManyToOne
    @JoinColumn(name = "institutionId", referencedColumnName = "id")
    private Institution institution;
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id", scope = DiagnosedCase.class)
    @JsonIdentityReference(alwaysAsId = true)
    @ManyToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "dataAdministratorId", referencedColumnName = "id")
    private DataAdministrator introducer;

    public DiagnosedCase() {}
}
