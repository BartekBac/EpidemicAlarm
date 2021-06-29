package com.epidemicalarm.api.repository;

import com.epidemicalarm.api.domain.DiagnosedCase;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.List;

@Repository
public interface IDiagnosedCaseRepository extends JpaRepository<DiagnosedCase, Long> {

    List<DiagnosedCase> findByExpirationDateAfter(Date date);

}
