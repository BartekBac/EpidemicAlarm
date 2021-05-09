package com.epidemicalarm.api.web;

import com.epidemicalarm.api.domain.Identity;
import com.epidemicalarm.api.service.interfaces.IIdentityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/*
* TODO:
* Improve exception handling
* Test rest diagnosed_case endpoints
* Add remaining modules
* */

@RestController
@RequestMapping("api/rest/identity")
public class IdentityController {
    @Autowired
    private IIdentityService identityService;

    @GetMapping
    public List<Identity> findAllIdentities() {
        return identityService.findAll();
    }

    @GetMapping("/{id}")
    public Identity findIdentityById(@PathVariable(value = "id") long id) {
        return identityService.findById(id);
    }

    @PostMapping
    public Identity saveIdentity(@Validated @RequestBody Identity identity) {

        return identityService.add(identity);
    }

    @PutMapping("/{id}")
    public Identity updateIdentityStatus(@Validated @RequestBody Identity identity) {
        return identityService.update(identity);
    }

    @DeleteMapping("/{id}")
    public void deleteIdentity(@PathVariable(value = "id") long id) {
        identityService.delete(id);
    }

}
