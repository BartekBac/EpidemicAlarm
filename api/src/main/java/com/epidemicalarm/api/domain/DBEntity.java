package com.epidemicalarm.api.domain;

import lombok.Data;

import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;

@Data
@MappedSuperclass
public class DBEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    public DBEntity() {}
}
