package com.epidemicalarm.api.service;

import com.epidemicalarm.api.domain.DataAdministrator;
import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.domain.Institution;
import com.epidemicalarm.api.dto.InstitutionDTO;
import com.epidemicalarm.api.exception.EntityNotFoundException;
import com.epidemicalarm.api.repository.IInstitutionRepository;
import com.epidemicalarm.api.service.interfaces.IInstitutionService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.InvalidDataAccessApiUsageException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Log
@Service
public class InstitutionService implements IInstitutionService {

    private final IInstitutionRepository institutionRepository;

    @Autowired
    public InstitutionService(IInstitutionRepository institutionRepository) {
        this.institutionRepository = institutionRepository;
    }

    private void setInstitutionFields(InstitutionDTO institutionDTO, Institution institutionToUpdate) {
        institutionToUpdate.setName(institutionDTO.name);
        institutionToUpdate.setLocationLat(institutionDTO.locationLat);
        institutionToUpdate.setLocationLng(institutionDTO.locationLng);
        institutionToUpdate.setAddress(institutionDTO.address);
    }

    @Override
    public Institution findById(long id) {
        try {
            Optional<Institution> institution = institutionRepository.findById(id);
            return institution.get();
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Institution [ID="+id+"]");
        }
    }

    @Override
    public List<Institution> findAll() {
        return institutionRepository.findAll();
    }

    @Override
    public Institution add(InstitutionDTO institution) {
        Institution newInstitution = new Institution();
        this.setInstitutionFields(institution, newInstitution);
        return institutionRepository.save(newInstitution);
    }

    @Override
    public Institution update(long id, InstitutionDTO institution) {
        Institution institutionToUpdate = this.findById(id);
        this.setInstitutionFields(institution, institutionToUpdate);
        return institutionRepository.save(institutionToUpdate);
    }

    @Override
    public void delete(long id) {
        Institution institution = this.findById(id);
        try {
            List<DiagnosedCase> diagnosedCases = institution.getDiagnosedCases();
            for(DiagnosedCase diagnosedCase : diagnosedCases) {
                diagnosedCase.setInstitution(null);
            }
        } catch (Exception e) {
            log.severe(e.getMessage());
        }
        try {
            List<DataAdministrator> workers = institution.getWorkers();
            for(DataAdministrator worker : workers) {
                worker.setInstitution(null);
            }
        } catch (Exception e) {
            log.severe(e.getMessage());
        }
        institutionRepository.delete(institution);
    }
}
