package com.epidemicalarm.api.repository;

import com.epidemicalarm.api.domain.DataAdministrator;
import org.springframework.data.jpa.repository.JpaRepository;

public interface IDataAdministratorRepository extends JpaRepository<DataAdministrator, Long> {}
