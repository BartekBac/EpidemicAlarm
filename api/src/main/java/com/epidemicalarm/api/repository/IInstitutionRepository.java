package com.epidemicalarm.api.repository;

import com.epidemicalarm.api.domain.Institution;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IInstitutionRepository extends CrudRepository<Institution, Long> {
}
