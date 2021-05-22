package com.epidemicalarm.api;

import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.domain.Identity;
import com.epidemicalarm.api.repository.IDiagnosedCaseRepository;
import com.epidemicalarm.api.repository.IIdentityRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.util.Assert;

@SpringBootTest
class ApiApplicationTests {

	@Autowired
	IDiagnosedCaseRepository diagnosedCaseRepository;

	@Autowired
	IIdentityRepository identityRepository;

	@Test
	void contextLoads() {
	}

}
