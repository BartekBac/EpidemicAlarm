package com.epidemicalarm.api.web;

import com.epidemicalarm.api.domain.DataAdministrator;
import com.epidemicalarm.api.dto.DataAdministratorDTO;
import com.epidemicalarm.api.service.interfaces.IDataAdministratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/rest/data-administrator")
public class DataAdministratorController {
    @Autowired
    private IDataAdministratorService dataAdministratorService;

    @GetMapping
    public List<DataAdministrator> findAllDataAdministrators() {
        return dataAdministratorService.findAll();
    }

    @GetMapping("/{id}")
    public DataAdministrator findDataAdministratorById(@PathVariable(value = "id") long id) {
        return dataAdministratorService.findById(id);
    }

    @PostMapping
    public DataAdministrator saveDataAdministrator(@Validated @RequestBody DataAdministratorDTO dataAdministrator) {
        return dataAdministratorService.add(dataAdministrator);
    }

    @PutMapping("/{id}")
    public DataAdministrator updateDataAdministrator(@PathVariable(value = "id") long id, @Validated @RequestBody DataAdministratorDTO dataAdministrator) {
        return dataAdministratorService.update(id, dataAdministrator);
    }

    @DeleteMapping("/{id}")
    public void deleteDataAdministrator(@PathVariable(value = "id") long id) {
        dataAdministratorService.delete(id);
    }

}
