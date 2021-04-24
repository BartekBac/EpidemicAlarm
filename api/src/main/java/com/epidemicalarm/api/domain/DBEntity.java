package com.epidemicalarm.api.domain;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public class DBEntity {
    @Id
    @GeneratedValue()
    private long id;
}
