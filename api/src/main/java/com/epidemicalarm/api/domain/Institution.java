package com.epidemicalarm.api.domain;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@Entity
public class Institution extends DBEntity{
    private String name;
    private double locationLat;
    private double locationLng;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "addressId", referencedColumnName = "id")
    private Address address;
    @JsonManagedReference(value = "dataAdministrator-institution")
    @OneToMany(mappedBy = "institution")
    private List<DataAdministrator> workers;
    @JsonManagedReference(value = "diagnosedCase-institution")
    @OneToMany(mappedBy = "institution")
    private List<DiagnosedCase> diagnosedCases;

    public Institution() {}
}
