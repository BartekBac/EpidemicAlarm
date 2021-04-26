package com.epidemicalarm.api.web;

import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.service.interfaces.IDiagnosedCaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/rest/diagnosed_case")
public class DiagnosedCaseController {
    @Autowired
    private IDiagnosedCaseService diagnosedCaseService;

    @GetMapping
    public List<DiagnosedCase> findAllDiagnosedCases() {
        return diagnosedCaseService.findAll();
    }

    @GetMapping("/{id}")
    public DiagnosedCase findDiagnosedCaseById(@PathVariable(value = "id") long id) {
        return diagnosedCaseService.findById(id);
    }

    @PostMapping
    public DiagnosedCase saveDiagnosedCase(@Validated @RequestBody DiagnosedCase diagnosedCase) {
        return diagnosedCaseService.add(diagnosedCase);
    }

    // TODO: eventually move checking presence also to persistence and use only try/catch blocks in controllers
    @DeleteMapping("/{id}")
    public void deleteDiagnosedCase(@PathVariable(value = "id") long id) {
        diagnosedCaseService.delete(id);
    }

    // TODO: move updates logic to persistence layer
    @PatchMapping("/{id}/status/{status}")
    public DiagnosedCase updateDiagnosedCaseStatus(@PathVariable(value = "id") long id, @PathVariable(value = "status") int status) {
        return diagnosedCaseService.updateStatus(id, status);
    }

    @PatchMapping("/{id}/duration/{duration}")
    public DiagnosedCase updateDiagnosedCaseDuration(@PathVariable(value = "id") long id, @PathVariable(value = "duration") int duration) {
        return diagnosedCaseService.updateDuration(id, duration);
    }

    @PatchMapping("/{id}/location/{location_lat}/{location_lng}")
    public DiagnosedCase updateDiagnosedCase(@PathVariable(value = "id") long id, @PathVariable(value = "location_lat") double locationLat, @PathVariable(value = "location_lng") double locationLng) {
        return diagnosedCaseService.updateLocation(id, locationLat, locationLng);
    }

}
