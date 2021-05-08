package com.epidemicalarm.api.repository;

import com.epidemicalarm.api.domain.Identity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IIdentityRepository extends CrudRepository<Identity, Long> {}
