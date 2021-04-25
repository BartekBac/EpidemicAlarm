package com.epidemicalarm.api.persistence;

import com.epidemicalarm.api.domain.DataAdministrator;
import org.springframework.data.repository.CrudRepository;

public interface IDataAdministratorRepository extends CrudRepository<DataAdministrator, Long> {}
