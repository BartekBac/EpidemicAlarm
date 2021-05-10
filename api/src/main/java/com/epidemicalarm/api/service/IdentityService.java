package com.epidemicalarm.api.service;

import com.epidemicalarm.api.domain.Identity;
import com.epidemicalarm.api.dto.IdentityDTO;
import com.epidemicalarm.api.exception.EntityNotFoundException;
import com.epidemicalarm.api.repository.IIdentityRepository;
import com.epidemicalarm.api.service.interfaces.IIdentityService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.InvalidDataAccessApiUsageException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;

@Log
@Service
public class IdentityService implements IIdentityService {

    private final IIdentityRepository identityRepository;

    @Autowired
    public IdentityService(IIdentityRepository identityRepository) {
        this.identityRepository = identityRepository;
    }

    private void setIdentityFields(IdentityDTO identityDTO, Identity identityToUpdate) {
        identityToUpdate.setPhoneNumber(identityDTO.phoneNumber);
        identityToUpdate.setPersonalId(identityDTO.personalId);
        identityToUpdate.setFirstName(identityDTO.firstName);
        identityToUpdate.setLastName(identityDTO.lastName);
        identityToUpdate.setEmail(identityDTO.email);
        identityToUpdate.setAddress(identityDTO.address);
    }

    @Override
    public Identity findById(long id) {
        try {
            Optional<Identity> identity = identityRepository.findById(id);
            return identity.get();
        } catch (NoSuchElementException | InvalidDataAccessApiUsageException e) {
            throw new EntityNotFoundException("Identity [ID="+id+"]");
        }
    }

    @Override
    public List<Identity> findAll() {
        return identityRepository.findAll();
    }

    @Override
    public Identity add(IdentityDTO identity) {
        Identity newIdentity = new Identity();
        this.setIdentityFields(identity, newIdentity);
        return identityRepository.save(newIdentity);
    }

    @Override
    public Identity update(long id, IdentityDTO identity) {
        Identity identityToUpdate = this.findById(id);
        this.setIdentityFields(identity, identityToUpdate);
        return identityRepository.save(identityToUpdate);
    }

    @Override
    public void delete(long id) {
        Identity identity = this.findById(id);
        identityRepository.delete(identity);
    }
}
