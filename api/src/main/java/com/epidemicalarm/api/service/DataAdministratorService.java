package com.epidemicalarm.api.service;

import com.epidemicalarm.api.domain.DataAdministrator;
import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.domain.Institution;
import com.epidemicalarm.api.dto.DataAdministratorDTO;
import com.epidemicalarm.api.exception.EntityNotFoundException;
import com.epidemicalarm.api.repository.IDataAdministratorRepository;
import com.epidemicalarm.api.repository.IInstitutionRepository;
import com.epidemicalarm.api.service.interfaces.IDataAdministratorService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.InvalidDataAccessApiUsageException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Log
@Service
public class DataAdministratorService implements IDataAdministratorService {

    private final IDataAdministratorRepository dataAdministratorRepository;
    private final IInstitutionRepository institutionRepository;

    @Autowired
    public DataAdministratorService(IDataAdministratorRepository dataAdministratorRepository, IInstitutionRepository institutionRepository) {
        this.dataAdministratorRepository = dataAdministratorRepository;
        this.institutionRepository = institutionRepository;
    }

    private void setDataAdministratorFields(DataAdministratorDTO dataAdministratorDTO, DataAdministrator dataAdministratorToUpdate) {
        try {
            Institution institution = institutionRepository.findById(dataAdministratorDTO.institution).get();
            dataAdministratorToUpdate.setInstitution(institution);
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Institution [ID="+dataAdministratorDTO.institution+"]");
        }
        dataAdministratorToUpdate.setLogin(dataAdministratorDTO.login);
        dataAdministratorToUpdate.setPassword(dataAdministratorDTO.password);
    }

    @Override
    public DataAdministrator findById(long id) {
        try {
            Optional<DataAdministrator> dataAdministrator = dataAdministratorRepository.findById(id);
            return dataAdministrator.get();
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("DataAdministrator [ID="+id+"]");
        }
    }

    @Override
    public List<DataAdministrator> findAll() {
        return dataAdministratorRepository.findAll();
    }

    @Override
    public DataAdministrator add(DataAdministratorDTO dataAdministrator) {
        DataAdministrator newDataAdministrator = new DataAdministrator();
        this.setDataAdministratorFields(dataAdministrator, newDataAdministrator);
        return dataAdministratorRepository.save(newDataAdministrator);
    }

    @Override
    public DataAdministrator update(long id, DataAdministratorDTO dataAdministrator) {
        DataAdministrator dataAdministratorToUpdate = this.findById(id);
        this.setDataAdministratorFields(dataAdministrator, dataAdministratorToUpdate);
        return dataAdministratorRepository.save(dataAdministratorToUpdate);
    }

    @Override
    public void delete(long id) {
        DataAdministrator dataAdministrator = this.findById(id);
        try {
            List<DiagnosedCase> diagnosedCases = dataAdministrator.getDiagnosedCases();
            for(DiagnosedCase diagnosedCase : diagnosedCases) {
                diagnosedCase.setIntroducer(null);
            }
        } catch (Exception e) {
            log.severe(e.getMessage());
        }
        dataAdministratorRepository.delete(dataAdministrator);
    }
}
