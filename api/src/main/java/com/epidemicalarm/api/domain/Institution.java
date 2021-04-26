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
    private long locationLat;
    private long locationLng;
    @OneToOne
    @JoinColumn(name = "addressId", referencedColumnName = "id")
    private Address address;
    @JsonManagedReference
    @OneToMany(mappedBy = "institution")
    private List<DataAdministrator> workers;
    @JsonManagedReference
    @OneToMany(mappedBy = "institution")
    private List<DiagnosedCase> diagnosedCases;

    public Institution() {}
}
