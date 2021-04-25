package com.epidemicalarm.api.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@Entity
public class DataAdministrator extends DBEntity{
    private String login;
    private String password;
    @ManyToOne
    @JoinColumn(name = "institutionId", referencedColumnName = "id")
    private Institution institution;
    @OneToMany(mappedBy = "introducer")
    private List<DiagnosedCase> diagnosedCases;

    public DataAdministrator() {}
}
