package com.epidemicalarm.api.domain;

import javax.persistence.*;
import java.util.List;

@Entity
public class Institution extends DBEntity{
    private String name;
    private long locationLat;
    private long locationLng;
    @OneToOne
    @JoinColumn(name = "addressId", referencedColumnName = "id")
    private Address address;
    @OneToMany(mappedBy = "institution")
    private List<DataAdministrator> workers;
    @OneToMany(mappedBy = "institution")
    private List<Case> cases;
}
