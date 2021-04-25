package com.epidemicalarm.api.persistence;

import com.epidemicalarm.api.domain.Identity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IIdentityRepository extends CrudRepository<Identity, Long> {}
