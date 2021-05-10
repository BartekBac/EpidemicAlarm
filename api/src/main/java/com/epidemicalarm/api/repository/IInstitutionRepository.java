package com.epidemicalarm.api.repository;

import com.epidemicalarm.api.domain.Institution;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IInstitutionRepository extends JpaRepository<Institution, Long> {}
