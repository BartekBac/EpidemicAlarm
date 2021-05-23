package com.epidemicalarm.api.service.interfaces;

import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.dto.DiagnosedCaseDTO;

import java.io.IOException;
import java.util.List;

public interface IDiagnosedCaseService {
    DiagnosedCase findById(long id);
    List<DiagnosedCase> findByParameters(Double lat, Double lng, Double range);
    DiagnosedCase add(DiagnosedCaseDTO diagnosedCase) throws IOException, InterruptedException;
    DiagnosedCase update(long id, DiagnosedCaseDTO diagnosedCase) throws IOException, InterruptedException;
    void delete(long id);
    DiagnosedCase updateStatus(long id, int newStatus);
    DiagnosedCase updateDuration(long id, int newDuration);
    DiagnosedCase updateLocation(long id, double newLocationLat, double newLocationLng);
}