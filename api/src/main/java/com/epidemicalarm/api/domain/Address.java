package com.epidemicalarm.api.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.Entity;

@Data
@Builder
@AllArgsConstructor
@Entity
public class Address extends DBEntity{
    private String city;
    private String street;
    private String HouseNumber;
    private String ZipCode;

    public Address() {}
}
