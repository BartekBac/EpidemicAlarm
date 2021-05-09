package com.epidemicalarm.api.repository;

import com.epidemicalarm.api.domain.Identity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IIdentityRepository extends JpaRepository<Identity, Long> {}
