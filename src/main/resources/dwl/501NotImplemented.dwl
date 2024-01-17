%dw 2.0
output application/json
/**
 * Standard Error Message in FHIR Format for resources that are not implemented.
 * @param No required error message.
 * @return A FHIR R4 formated Operation Outcome message.
 */
---
{
	resourceType: "OperationOutcome",
	issue: [{
		severity: "error",
		code: "not-supported",
		details: {
			text: "The operation is not implemented."
		}
	}]
}