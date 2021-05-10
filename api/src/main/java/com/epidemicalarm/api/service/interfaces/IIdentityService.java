package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.domain.Identity;
import com.epidemicalarm.api.dto.IdentityDTO;

import java.util.List;

public interface IIdentityService {
    Identity findById(long id);
    List<Identity> findAll();
    Identity add(IdentityDTO identity);
    Identity update(long id, IdentityDTO identity);
    void delete(long id);
}