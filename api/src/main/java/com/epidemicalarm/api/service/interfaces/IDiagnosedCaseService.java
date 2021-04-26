package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.domain.DiagnosedCase;

import java.util.List;

public interface IDiagnosedCaseService {
    DiagnosedCase findById(long id);
    List<DiagnosedCase> findAll();
    DiagnosedCase add(DiagnosedCase diagnosedCase);
    void delete(long id);
    DiagnosedCase updateStatus(long id, int newStatus);
    DiagnosedCase updateDuration(long id, int newDuration);
    DiagnosedCase updateLocation(long id, double newLocationLat, double newLocationLng);
}