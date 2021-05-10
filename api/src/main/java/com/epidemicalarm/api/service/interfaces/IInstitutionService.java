package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.domain.Institution;
import com.epidemicalarm.api.dto.InstitutionDTO;

import java.util.List;

public interface IInstitutionService {
    Institution findById(long id);
    List<Institution> findAll();
    Institution add(InstitutionDTO institution);
    Institution update(long id, InstitutionDTO institution);
    void delete(long id);
}