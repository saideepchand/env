%dw 2.0
output application/json
---
{
	resourceType: "OperationOutcome",
	issue: [{
		severity: "error",
		code: "invalid",
		details: {
			text: error.description
		}
	}]
}