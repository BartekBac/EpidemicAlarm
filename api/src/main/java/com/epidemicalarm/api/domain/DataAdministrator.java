package com.epidemicalarm.api.domain;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import java.util.List;

@Entity
public class DataAdministrator extends DBEntity{
    private String login;
    private String password;
    @ManyToOne
    @JoinColumn(name = "institutionId", referencedColumnName = "id")
    private Institution institution;
    @OneToMany(mappedBy = "introducer")
    private List<Case> cases;
}
