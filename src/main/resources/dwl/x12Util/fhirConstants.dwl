/**
 * This module implements FHIR constants that are used in CoverageEligibilityRequest and Response mapping.
 */
%dw 2.0


/**
 * Gets the constants used in lookup functions.
 * @return A map of constants used.
 */
 fun fhirConstants()=(
 {	
 	"CoverageEligibilityResponse" : {
 		"bundle" : {
 			"identifierSystem" : "http://hapi.fhir.org/baseR4/CoverageEligibilityResponse?_pretty=true",
 			"fullUrl" : "http://hapi.fhir.org/baseR4"	
 		},
 		"patient" : {
 			"identifierSystem" : "http://terminology.hl7.org/CodeSystem/v2-0203",
 			"identificationCode" : "MB"
 		},
 		"practitioner" : {
 			"identificationSystem" : "NPI"
 		},
 		"coverage" : {
 			"relationshipSystem" : "https://valueset.x12.org/x217/005010/request/2000D/INS/1/02/00/1069"
 		},
 		"organization" : {
 			"identifierSystem" : "http://hl7.org/fhir/sid/us-npi",
 			"typeSystem" : "https://valueset.x12.org/x217/005010/request/2010A/NM1/1/01/00/98"
 		},
         "coverageEligibilityResponse" : {
             "identificationSystem" : "http://benefitsinc.com/certificate",
             "itemCategorySystem" : "http://terminology.hl7.org/CodeSystem/ex-benefitcategory",
             "networkSystem" : "http://terminology.hl7.org/CodeSystem/benefit-network",
             "unitSystem" : "http://terminology.hl7.org/CodeSystem/benefit-unit",
             "termSystem" : "http://terminology.hl7.org/CodeSystem/benefit-term",
             "benefitTypeSystem" : "http://terminology.hl7.org/CodeSystem/benefit-type"
         }
 	},
 	
 	"Submit" : {
 		"supportingInfo" : {
 			"patientEventCode" : "patientEvent",
 			"patientEventSystem" : "http://hl7.org/fhir/us/davinci-pas/CodeSystem-PASSupportingInfoType",
 			"admissionCode" : "admissionDates",
 			"admissionSystem" : "http://hl7.org/fhir/us/davinci-pas/CodeSystem-PASSupportingInfoType",
 			"dischargeCode" : "dischargeDates",
 			"dischargeSystem": "http://hl7.org/fhir/us/davinci-pas/CodeSystem-PASSupportingInfoType",
 			"additionalInfoCode" : "additionalInformation",
 			"additionalInfoSystem" : "http://hl7.org/fhir/us/davinci-pas/CodeSystem-PASSupportingInfoType",
 			"msgTxtCode" : "freeFormMessage",
 			"msgTxtSystem" : "http://hl7.org/fhir/us/davinci-pas/CodeSystem-PASSupportingInfoType"
 		},
 		"extension" : {
 			"serviceItemRequestType" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-serviceItemRequestType",
 			"certificationType" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-certificationType",
 			"levelOfServiceCode" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-levelOfServiceCode",
 			"itemTraceNumber" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemTraceNumber",
 			"authorizationNumber" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-authorizationNumber",
 			"administrationReferenceNumber" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-administrationReferenceNumber",
 			 "productOrServiceCodeEnd": "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-productOrServiceCodeEnd",
 			 "revenueUnitRateLimit" : 'http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-revenueUnitRateLimit',
 			 "nursingHomeResidentialStatus" : 'http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-nursingHomeResidentialStatus',
 			 "nursingHomeLevelOfCare" : 'http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-nursingHomeLevelOfCare',
 			 "requestedService" : 'http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-requestedService',
 			 "subDepartment" : 'http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-identifierSubDepartment'
 		},
 		"location" : {
 			"typeOfBill" : "https://www.nubc.org/CodeSystem/TypeOfBill",
 			"placeOfServiceCodeSet" : "https://www.cms.gov/Medicare/Coding/place-of-service-codes/Place_of_Service_Code_Set"
 		},
 		
 	},
 	"SubmitResponse" : {
 		"bundle" : {
 			"identifierSystem" : "urn:ietf:rfc:3986"	
 		},
 		"claimResponse" : {
	 		"identifierSystem" : "http://example.org/PATIENT_EVENT_TRACE_NUMBER",
	 		"typeSystem" : "http://hl7.org/fhir/R4/codesystem-claim-type.html",
	 		"typeCodes" : {
	 			"professional" : "professional",
	 			"oral" : "oral",
	 			"institutional" : "institutional" 
	 		},
 		"adjudication" : {
 			"extensionSystem" : "https://build.fhir.org/ig/HL7/davinci-pas/StructureDefinition-extension-reviewAction.html",
 			"codeableConceptSystem" : "https://codesystem.x12.org/005010/306",
 			"categoryCode" : "submitted",
 			"categorySystem" : "http://terminology.hl7.org/CodeSystem/adjudication"
 		},	 		
	 		"extension" : {
 				"reviewAction" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-reviewAction",
 				"reviewActionCode" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-reviewActionCode",
 				"itemPreAuthIssueDate" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemPreAuthIssueDate",
 				"itemAuthorizedProvider" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemAuthorizedProvider"
 			},
 			"x12CodeSystems" : {
 				"hcr0306" : "https://valueset.x12.org/x217/005010/response/2000F/HCR/1/01/00/306",
 				"hcr306_actionCode" : "http://codesystem.x12.org/005010/306"
 			},
 			"disposition" : "Granted",
 			"use" : "preauthorization"
 		}, //End claimResponse
 		"patient" : {
 			"identifierSystem" : "Humana Member ID",
 			"identificationCode" : "MB"
 		},
 		"practitioner" : {
 			"identificationSystem" : "NPI"
 		},
 		"coverage" : {
 			"relationshipSystem" : "https://valueset.x12.org/x217/005010/request/2000D/INS/1/02/00/1069"
 		},
 		"organization" : {
 			"identifierSystem" : "http://hl7.org/fhir/sid/us-npi",
 			"typeSystem" : "https://valueset.x12.org/x217/005010/request/2010A/NM1/1/01/00/98"
 		},
 	},
 	"InquiryResponse" : {
 		"identifierSystem" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-identifier",
 		"extension" : {
	 		"itemTraceNumber" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemTraceNumber",
	 		"preAuthIssueDate" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemPreAuthIssueDate",
	 		"itemPreAuthPeriod" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemPreAuthPeriod",
	 		"authorizationNumber" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-authorizationNumber",
	 		"administrationReferenceNumber" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-administrationReferenceNumber",
	 		"itemAuthorizedDate" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemAuthorizedDate",
	 		"itemAuthorizedDetail" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemAuthorizedDetail",
	 		"itemAuthorizedProvider" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemAuthorizedProvider",
	 		"communicatedDiagnosis" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-communicatedDiagnosis",
	 		"reviewAction" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-reviewAction" 			
 		},
 		"adjudication" : {
 			"extensionSystem" : "https://build.fhir.org/ig/HL7/davinci-pas/StructureDefinition-extension-reviewAction.html",
 			"codeableConceptSystem" : "https://codesystem.x12.org/005010/306",
 			"categoryCode" : "submitted",
 			"categorySystem" : "http://terminology.hl7.org/CodeSystem/adjudication"
 		},
 		"outcome" : {
 			"complete" : ["51","A1","71","A3","A6","C","CT"],
 			"partial" : "A2",
 			"queued" : "A1"
 		}
 	},
 	"Inquiry" : {
 		"extension" : {
 			"preAuthIssueDate" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemPreAuthIssueDate",
 			"preAuthPeriod" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-itemPreAuthPeriod"
 		}
 	} 	
}
)