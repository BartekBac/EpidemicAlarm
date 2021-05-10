package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.dto.DiagnosedCaseDTO;

import java.util.List;

public interface IDiagnosedCaseService {
    DiagnosedCase findById(long id);
    List<DiagnosedCase> findAll();
    DiagnosedCase add(DiagnosedCaseDTO diagnosedCase);
    DiagnosedCase update(long id, DiagnosedCaseDTO diagnosedCase);
    void delete(long id);
    DiagnosedCase updateStatus(long id, int newStatus);
    DiagnosedCase updateDuration(long id, int newDuration);
    DiagnosedCase updateLocation(long id, double newLocationLat, double newLocationLng);
}