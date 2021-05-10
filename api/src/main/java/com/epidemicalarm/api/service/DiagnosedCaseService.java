package com.epidemicalarm.api.service;

import com.epidemicalarm.api.domain.DataAdministrator;
import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.domain.Identity;
import com.epidemicalarm.api.domain.Institution;
import com.epidemicalarm.api.dto.DiagnosedCaseDTO;
import com.epidemicalarm.api.exception.EntityNotFoundException;
import com.epidemicalarm.api.repository.IDataAdministratorRepository;
import com.epidemicalarm.api.repository.IDiagnosedCaseRepository;
import com.epidemicalarm.api.repository.IIdentityRepository;
import com.epidemicalarm.api.repository.IInstitutionRepository;
import com.epidemicalarm.api.service.interfaces.IDiagnosedCaseService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.InvalidDataAccessApiUsageException;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Log
@Service
public class DiagnosedCaseService implements IDiagnosedCaseService {

    private final IDiagnosedCaseRepository diagnosedCaseRepository;
    private final IIdentityRepository identityRepository;
    private final IInstitutionRepository institutionRepository;
    private final IDataAdministratorRepository dataAdministratorRepository;
    @Autowired
    public DiagnosedCaseService(IDiagnosedCaseRepository diagnosedCaseRepository, IIdentityRepository identityRepository, IInstitutionRepository institutionRepository, IDataAdministratorRepository dataAdministratorRepository) {
        this.diagnosedCaseRepository = diagnosedCaseRepository;
        this.identityRepository = identityRepository;
        this.institutionRepository = institutionRepository;
        this.dataAdministratorRepository = dataAdministratorRepository;
    }

    private void setDiagnosedCaseFields(DiagnosedCaseDTO diagnosedCaseDTO, DiagnosedCase diagnosedCaseToUpdate) {
        try {
            Identity identity = identityRepository.findById(diagnosedCaseDTO.identity).get();
            diagnosedCaseToUpdate.setIdentity(identity);
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Identity [ID="+diagnosedCaseDTO.identity+"]");
        }
        try {
            Institution institution = institutionRepository.findById(diagnosedCaseDTO.institution).get();
            diagnosedCaseToUpdate.setInstitution(institution);
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Institution [ID="+diagnosedCaseDTO.institution+"]");
        }
        try {
            DataAdministrator dataAdministrator = dataAdministratorRepository.findById(diagnosedCaseDTO.introducer).get();
            diagnosedCaseToUpdate.setIntroducer(dataAdministrator);
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Data Administrator [ID="+diagnosedCaseDTO.introducer+"]");
        }
        diagnosedCaseToUpdate.setDiagnosisDate(diagnosedCaseDTO.diagnosisDate);
        diagnosedCaseToUpdate.setDuration(diagnosedCaseDTO.duration);
        diagnosedCaseToUpdate.setStatus(diagnosedCaseDTO.status);
        diagnosedCaseToUpdate.setExpirationDate(diagnosedCaseDTO.expirationDate);
        diagnosedCaseToUpdate.setLocationLng(diagnosedCaseDTO.locationLng);
        diagnosedCaseToUpdate.setLocationLat(diagnosedCaseDTO.locationLat);
    }

    @Override
    public DiagnosedCase findById(long id) {
        try {
            Optional<DiagnosedCase> diagnosedCase = diagnosedCaseRepository.findById(id);
            return diagnosedCase.get();
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Diagnosed Case [ID="+id+"]");
        }
    }

    @Override
    public List<DiagnosedCase> findAll() {
        return diagnosedCaseRepository.findAll();
    }

    @Override
    public DiagnosedCase add(DiagnosedCaseDTO diagnosedCase) {
        DiagnosedCase newDiagnosedCase = new DiagnosedCase();
        this.setDiagnosedCaseFields(diagnosedCase, newDiagnosedCase);
        return diagnosedCaseRepository.save(newDiagnosedCase);
    }

    @Override
    public DiagnosedCase update(long id, DiagnosedCaseDTO diagnosedCase) {
        DiagnosedCase diagnosedCaseToUpdate = this.findById(id);
        this.setDiagnosedCaseFields(diagnosedCase, diagnosedCaseToUpdate);
        return diagnosedCaseRepository.save(diagnosedCaseToUpdate);
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
        return diagnosedCaseRepository.save(diagnosedCase);
    }

    @Override
    public DiagnosedCase updateDuration(long id, int newDuration) {
        DiagnosedCase diagnosedCase = this.findById(id);
        diagnosedCase.setDuration(newDuration);
        long oneDay = 24*60*60*1000;
        long newExpirationTime = diagnosedCase.getDiagnosisDate().getTime() + oneDay * newDuration;
        Date newExpirationDate = new Date(newExpirationTime);
        diagnosedCase.setExpirationDate(newExpirationDate);
        return diagnosedCaseRepository.save(diagnosedCase);
    }

    @Override
    public DiagnosedCase updateLocation(long id, double newLocationLat, double newLocationLng) {
        DiagnosedCase diagnosedCase = this.findById(id);
        diagnosedCase.setLocationLat(newLocationLat);
        diagnosedCase.setLocationLng(newLocationLng);
        return diagnosedCaseRepository.save(diagnosedCase);
    }
}
