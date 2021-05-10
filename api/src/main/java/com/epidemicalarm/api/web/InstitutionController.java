package com.epidemicalarm.api.web;

import com.epidemicalarm.api.domain.Institution;
import com.epidemicalarm.api.dto.InstitutionDTO;
import com.epidemicalarm.api.service.interfaces.IInstitutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/rest/institution")
public class InstitutionController {
    @Autowired
    private IInstitutionService institutionService;

    @GetMapping
    public List<Institution> findAllIdentities() {
        return institutionService.findAll();
    }

    @GetMapping("/{id}")
    public Institution findInstitutionById(@PathVariable(value = "id") long id) {
        return institutionService.findById(id);
    }

    @PostMapping
    public Institution saveInstitution(@Validated @RequestBody InstitutionDTO institution) {
        return institutionService.add(institution);
    }

    @PutMapping("/{id}")
    public Institution updateInstitution(@PathVariable(value = "id") long id, @Validated @RequestBody InstitutionDTO institution) {
        return institutionService.update(id, institution);
    }

    @DeleteMapping("/{id}")
    public void deleteInstitution(@PathVariable(value = "id") long id) {
        institutionService.delete(id);
    }

}
