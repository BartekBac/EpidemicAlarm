package com.epidemicalarm.api.domain;

import javax.persistence.Entity;

@Entity
public class Address extends DBEntity{
    private String city;
    private String street;
    private String HouseNumber;
    private String ZipCode;
}
