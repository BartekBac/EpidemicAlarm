package com.epidemicalarm.api.web;

import com.epidemicalarm.api.domain.DiagnosedCase;
import com.epidemicalarm.api.persistence.IDiagnosedCaseRepository;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;
import java.util.Optional;

@Log
@RestController
@RequestMapping("api/rest/diagnosed_case")
public class DiagnosedCaseController {
    @Autowired
    private IDiagnosedCaseRepository diagnosedCaseRepository;

    @GetMapping
    public List<DiagnosedCase> findAllDiagnosedCases() {
        return diagnosedCaseRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<DiagnosedCase> findDiagnosedCaseById(@PathVariable(value = "id") long id) {
        Optional<DiagnosedCase> diagnosedCase = diagnosedCaseRepository.findById(id);

        if(diagnosedCase.isPresent()) {
            return ResponseEntity.ok(diagnosedCase.get());
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping
    public ResponseEntity<DiagnosedCase> saveDiagnosedCase(@Validated @RequestBody DiagnosedCase diagnosedCase) {
        try {
            DiagnosedCase newDiagnosedCase = diagnosedCaseRepository.save(diagnosedCase);
            String msg = "Diagnosed Case [ID=" + newDiagnosedCase.getId() + "]  added.";
            log.fine(msg);
            return ResponseEntity.ok(newDiagnosedCase);
        } catch (Exception e) {
            String msg = "Cannot add Diagnosed Case [BODY=" + diagnosedCase.toString() + "], exception: \r\n" + e.getMessage();
            log.severe(msg);
            return ResponseEntity.badRequest().build();
        }
    }

    // TODO: eventually move checking presence also to persistence and use only try/catch blocks in controllers
    @DeleteMapping("/{id}")
    public void deleteDiagnosedCase(@PathVariable(value = "id") long id) {
        Optional<DiagnosedCase> diagnosedCase = diagnosedCaseRepository.findById(id);
        if(diagnosedCase.isPresent()) {
            String msg = "Diagnosed Case [ID=" + id + "]  deleted.";
            diagnosedCaseRepository.delete(diagnosedCase.get());
            log.fine(msg);
        } else {
            String msg = "Cannot delete Diagnosed Case [ID=" + id + "].";
            log.warning(msg);
        }
    }

    // TODO: move updates logic to persistence layer
    @PatchMapping("/{id}/status/{status}")
    public ResponseEntity<DiagnosedCase> updateDiagnosedCaseStatus(@PathVariable(value = "id") long id, @PathVariable(value = "status") int status) {
        try {
            DiagnosedCase diagnosedCase = diagnosedCaseRepository.findById(id).get();
            diagnosedCase.setStatus(status);
            diagnosedCaseRepository.save(diagnosedCase);
            String msg = "Diagnosed Case [ID=" + id + ", STATUS=" + status + "] updated.";
            log.fine(msg);
            return ResponseEntity.ok(diagnosedCase);
        } catch (Exception e) {
            String msg = "Cannot updated Diagnosed Case [ID=" + id + ", STATUS=" + status + "], exception: \r\n" + e.getMessage();
            log.severe(msg);
            return ResponseEntity.badRequest().build();
        }
    }

    @PatchMapping("/{id}/duration/{duration}")
    public ResponseEntity<DiagnosedCase> updateDiagnosedCaseDuration(@PathVariable(value = "id") long id, @PathVariable(value = "duration") int duration) {
        try {
            DiagnosedCase diagnosedCase = diagnosedCaseRepository.findById(id).get();
            diagnosedCase.setDuration(duration);
            long oneDay = 24*60*60*1000;
            long newExpirationTime = diagnosedCase.getDiagnosisDate().getTime() + oneDay * duration;
            Date newExpirationDate = new Date(newExpirationTime);
            diagnosedCase.setExpirationDate(newExpirationDate);
            diagnosedCaseRepository.save(diagnosedCase);
            String msg = "Diagnosed Case [ID=" + id + ", DURATION=" + duration + ", EXPIRATION_DATE="+ newExpirationDate.toString() + "] updated.";
            log.fine(msg);
            return ResponseEntity.ok(diagnosedCase);
        } catch (Exception e) {
            String msg = "Cannot updated Diagnosed Case [ID=" + id + ", DURATION=" + duration + "], exception: \r\n" + e.getMessage();
            log.severe(msg);
            return ResponseEntity.badRequest().build();
        }
    }

    @PatchMapping("/{id}/location/{location_lat}/{location_lng}")
    public ResponseEntity<DiagnosedCase> updateDiagnosedCase(@PathVariable(value = "id") long id, @PathVariable(value = "location_lat") double locationLat, @PathVariable(value = "location_lng") double locationLng) {
        try {
            DiagnosedCase diagnosedCase = diagnosedCaseRepository.findById(id).get();
            diagnosedCase.setLocationLat(locationLat);
            diagnosedCase.setLocationLng(locationLng);
            diagnosedCaseRepository.save(diagnosedCase);
            String msg = "Diagnosed Case [ID=" + id + ", LOCATION_LAT=" + locationLat + ", LOCATION_LNG=" + locationLng + "] updated.";
            log.fine(msg);
            return ResponseEntity.ok(diagnosedCase);
        } catch (Exception e) {
            String msg = "Cannot updated Diagnosed Case [ID=" + id + ", LOCATION_LAT=" + locationLat + ", LOCATION_LNG=" + locationLng + "], exception: \r\n" + e.getMessage();
            log.severe(msg);
            return ResponseEntity.badRequest().build();
        }
    }

}
