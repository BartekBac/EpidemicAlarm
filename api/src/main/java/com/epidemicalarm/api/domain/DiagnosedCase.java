package com.epidemicalarm.api.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
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
    @JsonBackReference(value = "identity")
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "identityId", referencedColumnName = "id")
    private Identity identity;
    @JsonBackReference(value = "diagnosedCase-institution")
    @ManyToOne
    @JoinColumn(name = "institutionId", referencedColumnName = "id")
    private Institution institution;
    @JsonBackReference(value = "diagnosedCase-dataAdministrator")
    @ManyToOne
    @JoinColumn(name = "dataAdministratorId", referencedColumnName = "id")
    private DataAdministrator introducer;

    public DiagnosedCase() {}
}
