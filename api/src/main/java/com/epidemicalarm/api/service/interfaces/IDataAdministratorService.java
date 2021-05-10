package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.domain.DataAdministrator;
import com.epidemicalarm.api.dto.DataAdministratorDTO;

import java.util.List;

public interface IDataAdministratorService {
    DataAdministrator findById(long id);
    List<DataAdministrator> findAll();
    DataAdministrator add(DataAdministratorDTO dataAdministrator);
    DataAdministrator update(long id, DataAdministratorDTO dataAdministrator);
    void delete(long id);
}