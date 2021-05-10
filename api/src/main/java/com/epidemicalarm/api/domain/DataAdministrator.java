package com.epidemicalarm.api.domain;

import com.fasterxml.jackson.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.*;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@Entity
public class DataAdministrator extends DBEntity{
    private String login;
    private String password;
    //@JsonBackReference(value = "dataAdministrator-institution")
    @JsonIdentityInfo(generator = ObjectIdGenerators.PropertyGenerator.class, property = "id", scope = DataAdministrator.class)
    @JsonIdentityReference(alwaysAsId = true)
    @ManyToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "institutionId", referencedColumnName = "id")
    private Institution institution;
    @JsonManagedReference(value = "diagnosedCase-dataAdministrator")
    @OneToMany(mappedBy = "introducer")
    private List<DiagnosedCase> diagnosedCases;

    public DataAdministrator() {}
}
