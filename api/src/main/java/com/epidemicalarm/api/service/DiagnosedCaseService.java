package com.epidemicalarm.api.service;

import com.epidemicalarm.api.domain.*;
import com.epidemicalarm.api.dto.DiagnosedCaseDTO;
import com.epidemicalarm.api.exception.EntityNotFoundException;
import com.epidemicalarm.api.exception.GeocoderServiceException;
import com.epidemicalarm.api.exception.InvalidRequestParameterException;
import com.epidemicalarm.api.repository.IDataAdministratorRepository;
import com.epidemicalarm.api.repository.IDiagnosedCaseRepository;
import com.epidemicalarm.api.repository.IIdentityRepository;
import com.epidemicalarm.api.repository.IInstitutionRepository;
import com.epidemicalarm.api.service.distance.interfaces.IDistanceService;
import com.epidemicalarm.api.service.geocoder.GeocoderArcGIS;
import com.epidemicalarm.api.service.geocoder.dto.GeocoderPosition;
import com.epidemicalarm.api.service.geocoder.interfaces.IGeocoderService;
import com.epidemicalarm.api.service.interfaces.IDiagnosedCaseService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.CollectionUtils;
import org.springframework.dao.InvalidDataAccessApiUsageException;
import org.springframework.stereotype.Service;

import java.io.IOException;
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
    private final IGeocoderService geocoderService;
    private final IDistanceService distanceService;

    @Autowired
    public DiagnosedCaseService(IDiagnosedCaseRepository diagnosedCaseRepository, IIdentityRepository identityRepository, IInstitutionRepository institutionRepository, IDataAdministratorRepository dataAdministratorRepository, IGeocoderService geocoderService, IDistanceService distanceService) {
        this.diagnosedCaseRepository = diagnosedCaseRepository;
        this.identityRepository = identityRepository;
        this.institutionRepository = institutionRepository;
        this.dataAdministratorRepository = dataAdministratorRepository;
        this.geocoderService = geocoderService;
        this.distanceService = distanceService;
    }

    private void setLocation(DiagnosedCase diagnosedCase, Address identityAddress) throws IOException, InterruptedException, GeocoderServiceException {
        GeocoderPosition location = this.geocoderService.geocode(identityAddress);
        diagnosedCase.setLocationLat(location.lat);
        diagnosedCase.setLocationLng(location.lng);
    }

    private void setDiagnosedCaseFields(DiagnosedCaseDTO diagnosedCaseDTO, DiagnosedCase diagnosedCaseToUpdate) throws IOException, InterruptedException {
        Identity identity;
        Institution institution;
        DataAdministrator dataAdministrator;
        Address identityAddress;
        try {
            identity = identityRepository.findById(diagnosedCaseDTO.identity).get();
            identityAddress = identity.getAddress();
            diagnosedCaseToUpdate.setIdentity(identity);
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Identity [ID="+diagnosedCaseDTO.identity+"]");
        }
        try {
            institution = institutionRepository.findById(diagnosedCaseDTO.institution).get();
            diagnosedCaseToUpdate.setInstitution(institution);
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Institution [ID="+diagnosedCaseDTO.institution+"]");
        }
        try {
            dataAdministrator = dataAdministratorRepository.findById(diagnosedCaseDTO.introducer).get();
            diagnosedCaseToUpdate.setIntroducer(dataAdministrator);
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Data Administrator [ID="+diagnosedCaseDTO.introducer+"]");
        }
        diagnosedCaseToUpdate.setDiagnosisDate(diagnosedCaseDTO.diagnosisDate);
        diagnosedCaseToUpdate.setDuration(diagnosedCaseDTO.duration);
        diagnosedCaseToUpdate.setStatus(diagnosedCaseDTO.status);
        diagnosedCaseToUpdate.setExpirationDate(diagnosedCaseDTO.expirationDate);
        if(diagnosedCaseDTO.locationLat == null || diagnosedCaseDTO.locationLng == null) {
            try {
                this.setLocation(diagnosedCaseToUpdate, identityAddress);
            } catch (Exception e){
                log.severe("Internal error: " + e.toString());
                log.warning("Cannot resolve location with default strategy, switching to HERE geolocation service...");
                try {
                    this.geocoderService.setGeocoderStrategy(new GeocoderArcGIS());
                    this.setLocation(diagnosedCaseToUpdate,identityAddress);
                } catch (Exception exception) {
                    log.severe("Cannot resolve location with HERE strategy");
                    throw exception;
                }
            }
        } else {
            diagnosedCaseToUpdate.setLocationLng(diagnosedCaseDTO.locationLng);
            diagnosedCaseToUpdate.setLocationLat(diagnosedCaseDTO.locationLat);
        }
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
    public List<DiagnosedCase> findByParameters(Double lat, Double lng, Double range) {
        List<DiagnosedCase> diagnosedCases = diagnosedCaseRepository.findAll();

        if(lat == null && lng == null && range == null) {
            return diagnosedCases;
        }

        if(lat == null) {
            throw new InvalidRequestParameterException("LAT", "NULL", "Latitude cannot be null");
        }

        if(lng == null) {
            throw new InvalidRequestParameterException("LNG", "NULL", "Longitude cannot be null");
        }

        if(range == null) {
            throw new InvalidRequestParameterException("RANGE", "NULL", "Range cannot be null");
        }

        if(range <= 0) {
            throw new InvalidRequestParameterException("RANGE", range.toString(), "Range cannot be <= 0");
        }

        if(lat < -90 || lat > 90 ) {
            throw new InvalidRequestParameterException("LAT", lat.toString(), "Latitude must be in range <-90:90>");
        }

        if(lat < -180 || lat > 180 ) {
            throw new InvalidRequestParameterException("LNG", lng.toString(), "Longitude must be in range <-180:180>");
        }

        CollectionUtils.filter(diagnosedCases, dc -> {
             DiagnosedCase diagnosedCase = ((DiagnosedCase) dc);
             double distance = distanceService.calculate(lat, lng, diagnosedCase.getLocationLat(), diagnosedCase.getLocationLng());
             return distance <= range;
        });

        return diagnosedCases;
    }

    @Override
    public DiagnosedCase add(DiagnosedCaseDTO diagnosedCase) throws IOException, InterruptedException {
        DiagnosedCase newDiagnosedCase = new DiagnosedCase();
        this.setDiagnosedCaseFields(diagnosedCase, newDiagnosedCase);
        return diagnosedCaseRepository.save(newDiagnosedCase);
    }

    @Override
    public DiagnosedCase update(long id, DiagnosedCaseDTO diagnosedCase) throws IOException, InterruptedException {
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
