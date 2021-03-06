package com.epidemicalarm.api.web;

import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.domain.Identity;
import com.epidemicalarm.api.dto.DiagnosedCaseDTO;
import com.epidemicalarm.api.service.interfaces.IDiagnosedCaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("api/rest/diagnosed_case")
public class DiagnosedCaseController {
    @Autowired
    private IDiagnosedCaseService diagnosedCaseService;

    @GetMapping
    public List<DiagnosedCase> findDiagnosedCasesByParameters(
            @RequestParam(required = false) Double lat,
            @RequestParam(required = false) Double lng,
            @RequestParam(required = false) Double range,
            @RequestParam(required = false) String region,
            @RequestParam(required = false) String subregion,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) Boolean onlyActive) {
        return diagnosedCaseService.findByParameters(lat, lng, range, region, subregion, city, onlyActive);
    }

    @GetMapping("/{id}")
    public DiagnosedCase findDiagnosedCaseById(@PathVariable(value = "id") long id) {
        return diagnosedCaseService.findById(id);
    }

    @PostMapping
    public DiagnosedCase saveDiagnosedCase(@Validated @RequestBody DiagnosedCaseDTO diagnosedCase) throws IOException, InterruptedException {
        return diagnosedCaseService.add(diagnosedCase);
    }

    @PutMapping("/{id}")
    public DiagnosedCase updateDiagnosedCase(@PathVariable(value = "id") long id, @Validated @RequestBody DiagnosedCaseDTO diagnosedCase) throws IOException, InterruptedException {
        return diagnosedCaseService.update(id, diagnosedCase);
    }

    @DeleteMapping("/{id}")
    public void deleteDiagnosedCase(@PathVariable(value = "id") long id) {
        diagnosedCaseService.delete(id);
    }

    @PatchMapping("/{id}/status/{status}")
    public DiagnosedCase updateDiagnosedCaseStatus(@PathVariable(value = "id") long id, @PathVariable(value = "status") int status) {
        return diagnosedCaseService.updateStatus(id, status);
    }

    @PatchMapping("/{id}/duration/{duration}")
    public DiagnosedCase updateDiagnosedCaseDuration(@PathVariable(value = "id") long id, @PathVariable(value = "duration") int duration) {
        return diagnosedCaseService.updateDuration(id, duration);
    }

    @PatchMapping("/{id}/location/{location_lat}/{location_lng}")
    public DiagnosedCase updateDiagnosedCaseLocation(@PathVariable(value = "id") long id, @PathVariable(value = "location_lat") double locationLat, @PathVariable(value = "location_lng") double locationLng) {
        return diagnosedCaseService.updateLocation(id, locationLat, locationLng);
    }

}
