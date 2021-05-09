package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.domain.Identity;

import java.util.List;

public interface IIdentityService {
    Identity findById(long id);
    List<Identity> findAll();
    Identity add(Identity identity);
    Identity update(Identity identity);
    void delete(long id);
}