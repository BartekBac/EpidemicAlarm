package com.epidemicalarm.api.persistence;

import com.epidemicalarm.api.domain.Institution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IInstitutionRepository extends CrudRepository<Institution, Long> {
}
