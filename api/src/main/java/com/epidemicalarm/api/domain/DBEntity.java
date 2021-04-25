package com.epidemicalarm.api.domain;

import lombok.Data;

import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@Data
@MappedSuperclass
public class DBEntity {
    @Id
    @GeneratedValue()
    private long id;

    public DBEntity() {}
}
