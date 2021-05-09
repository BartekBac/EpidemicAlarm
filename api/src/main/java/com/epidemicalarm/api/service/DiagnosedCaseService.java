package com.epidemicalarm.api.service;

import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.exceptions.EntityNotFoundException;
import com.epidemicalarm.api.repository.IDiagnosedCaseRepository;
import com.epidemicalarm.api.service.interfaces.IDiagnosedCaseService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

@Log
@Service
public class DiagnosedCaseService implements IDiagnosedCaseService {

    private final IDiagnosedCaseRepository diagnosedCaseRepository;

    @Autowired
    public DiagnosedCaseService(IDiagnosedCaseRepository diagnosedCaseRepository) {
        this.diagnosedCaseRepository = diagnosedCaseRepository;
    }

    @Override
    public DiagnosedCase findById(long id) {
        Optional<DiagnosedCase> diagnosedCase = diagnosedCaseRepository.findById(id);

        if(diagnosedCase.isEmpty()) {
            throw new EntityNotFoundException("Diagnosed Case [ID="+id+"]");
        }

        return diagnosedCase.get();
    }

    @Override
    public List<DiagnosedCase> findAll() {
        return diagnosedCaseRepository.findAll();
    }

    @Override
    public DiagnosedCase add(DiagnosedCase diagnosedCase) {
        return diagnosedCaseRepository.save(diagnosedCase);
    }

    @Override
    public void delete(long id) {
        DiagnosedCase diagnosedCase = this.findById(id);
        diagnosedCaseRepository.delete(diagnosedCase);
    }

    @Override
    public DiagnosedCase updateStatus(long id, int newStatus) {
        DiagnosedCase diagnosedCase = this.findById(id);
        diagnosedCase.setStatus(newStatus);
        diagnosedCaseRepository.save(diagnosedCase);
        return diagnosedCase;
    }

    @Override
    public DiagnosedCase updateDuration(long id, int newDuration) {
        DiagnosedCase diagnosedCase = this.findById(id);
        diagnosedCase.setDuration(newDuration);
        long oneDay = 24*60*60*1000;
        long newExpirationTime = diagnosedCase.getDiagnosisDate().getTime() + oneDay * newDuration;
        Date newExpirationDate = new Date(newExpirationTime);
        diagnosedCase.setExpirationDate(newExpirationDate);
        diagnosedCaseRepository.save(diagnosedCase);
        return diagnosedCase;
    }

    @Override
    public DiagnosedCase updateLocation(long id, double newLocationLat, double newLocationLng) {
        DiagnosedCase diagnosedCase = this.findById(id);
        diagnosedCase.setLocationLat(newLocationLat);
        diagnosedCase.setLocationLng(newLocationLng);
        diagnosedCaseRepository.save(diagnosedCase);
        return diagnosedCase;
    }
}
