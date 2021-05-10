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
public class Identity extends DBEntity{
    private String firstName;
    private String lastName;
    private String personalId;
    private String phoneNumber;
    private String email;
    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "addressId", referencedColumnName = "id")
    private Address address;
    @JsonManagedReference(value = "diagnosedCase-identity")
    @OneToMany(mappedBy = "identity", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DiagnosedCase> diagnosedCases;

    public Identity() {}
}
