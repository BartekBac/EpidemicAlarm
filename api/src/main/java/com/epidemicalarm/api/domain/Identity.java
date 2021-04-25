package com.epidemicalarm.api.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

@Data
@Builder
@AllArgsConstructor
@Entity
public class Identity extends DBEntity{
    private String firstName;
    private String lastName;
    private String personalId;
    private String phoneNumber;
    private String email;
    @OneToOne
    @JoinColumn(name = "addressId", referencedColumnName = "id")
    private Address address;

    public Identity() {}
}
