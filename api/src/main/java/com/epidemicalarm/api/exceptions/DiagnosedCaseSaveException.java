package com.epidemicalarm.api.exceptions;

import com.epidemicalarm.api.domain.DiagnosedCase;

public class DiagnosedCaseSaveException extends RuntimeException {
    public DiagnosedCaseSaveException(DiagnosedCase diagnosedCase) { super("New diagnosed case cannot be added [BODY="+diagnosedCase.toString()+"]."); }
}
