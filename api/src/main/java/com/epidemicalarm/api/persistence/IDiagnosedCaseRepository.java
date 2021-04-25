package com.epidemicalarm.api.persistence;

import com.epidemicalarm.api.domain.DiagnosedCase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IDiagnosedCaseRepository extends JpaRepository<DiagnosedCase, Long> {}
