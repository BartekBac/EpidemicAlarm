package com.epidemicalarm.api.service;

import com.epidemicalarm.api.domain.Identity;
import com.epidemicalarm.api.exceptions.EntityNotFoundException;
import com.epidemicalarm.api.repository.IIdentityRepository;
import com.epidemicalarm.api.service.interfaces.IIdentityService;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Log
@Service
public class IdentityService implements IIdentityService {

    private final IIdentityRepository identityRepository;

    @Autowired
    public IdentityService(IIdentityRepository identityRepository) {
        this.identityRepository = identityRepository;
    }

    @Override
    public Identity findById(long id) {
        Optional<Identity> identity = identityRepository.findById(id);

        if(identity.isEmpty()) {
            throw new EntityNotFoundException("Identity [ID="+id+"]");
        }

        return identity.get();
    }

    @Override
    public List<Identity> findAll() {
        return identityRepository.findAll();
    }

    @Override
    public Identity add(Identity identity) {
        return identityRepository.save(identity);
    }

    @Override
    public void delete(long id) {
        Identity identity = this.findById(id);
        identityRepository.delete(identity);
    }

    @Override
    public Identity update(Identity identity) {
        identityRepository.save(identity);
        return identity;
    }

}
