/**
 * Module that provides support for submit 278 response mapping.
 */
%dw 2.0
output application/json
skipNullOn="everywhere"
import camelize from dw::core::Strings
import clean, mapGuid, toString from dwl::Util
import createCoveragePAS, createTelecom,telecomTypeX12FHIR,relationCodeX12FHIR,genderLookupX12FHIR,createClaimResponse,createPatient,createPractitioner,createCoverage,createOrganization from dwl::x12Util::x12SegmentTools

import fhirConstants from dwl::x12Util::fhirConstants
var resp278=payload."TransactionSets"."v005010X217"."278"[0]
var loop2000A=resp278.Detail."2000A_Loop"
var loop2000B=loop2000A."2000B_Loop"
var loop2000C=loop2000B."2000C_Loop"
var fhirConstantsObj = fhirConstants()
var dependentPatientExists=! isEmpty(resp278.Detail."2000A_Loop"."2000B_Loop"."2000C_Loop"."2000D_Loop")

// Creating subscriberId due to paucity of test data
var subscriberId = "sub-" ++ mapGuid("patient" ++ toString(loop2000C."2010C_Loop") default uuid())

// Dependent ID
var depdendentId = 
	if(dependentPatientExists) 
		"dep-" ++ mapGuid("dependent" ++ toString(loop2000C."2000D_Loop"."2010D_Loop") default uuid()) 
	else 
		subscriberId

// Organization ID
var payorId = "org-" ++ mapGuid("organization" ++ toString(loop2000A."2010A_Loop") default uuid())

var coverageId = "cov-" ++ mapGuid("coverage" ++ toString(loop2000C."2000D_Loop") default uuid())

var practitionerId = "prac-" ++ mapGuid("practitioner" ++ toString(loop2000C."2000E_Loop"[0]."2010EA_Loop"[0]) default uuid())

var claimResponseId = "claim-" ++ mapGuid("claimresponse" ++ toString(resp278.Heading) default uuid())
---
{
	"resourceType" : "Bundle",
	"type" : "collection",
	"identifier" : 
		{
			"system" : fhirConstantsObj.SubmitResponse.bundle.identifierSystem,
			"value" :  "http://" ++  resp278.Heading.BHT_BeginningOfHierarchicalTransaction.BHT03_SubmitterTransactionIdentifier
		}
	,
	"entry" : [
		{
			fullUrl: "urn:uuid:" ++ claimResponseId,
			"resource" : clean(createClaimResponse(claimResponseId, loop2000C,loop2000A,fhirConstantsObj,resp278.Heading))
		}, //End Claim Response
		{
			fullUrl: "urn:uuid:" ++ subscriberId,
			"resource" : clean(createPatient(fhirConstantsObj.SubmitResponse.patient.identifierSystem,
									   fhirConstantsObj.SubmitResponse.patient.identificationCode,
									   "Subscriber",
									   subscriberId,
									   loop2000C."2010C_Loop"."NM1_SubscriberName",
									   loop2000C."2010C_Loop".N3_SubscriberMailingAddress,
									   loop2000C."2010C_Loop".N4_SubscriberCityStateZIPCode,
									   loop2000C."2010C_Loop"."DMG_SubscriberDemographicInformation"
			))
		}, //End Subscriber Patient
		({
			fullUrl: "urn:uuid:" ++ depdendentId,
			"resource" : clean(createPatient(fhirConstantsObj.SubmitResponse.patient.identifierSystem,
									   fhirConstantsObj.SubmitResponse.patient.identificationCode,
									   "Dependent",
									   depdendentId,
									   loop2000C."2000D_Loop"."2010D_Loop"."NM1_DependentName",
									   loop2000C."2000D_Loop"."2010D_Loop".N3_DependentAddress,
									   loop2000C."2000D_Loop"."2010D_Loop".N4_DependentCityStateZIPCode,
									   loop2000C."2000D_Loop"."2010D_Loop"."DMG_DependentDemographicInformation"))
		}) if(dependentPatientExists), //End Beneficiary Patient	
		/*
		 * Practitioner is mapped from 2010EA an array. Extend this by looping over 2010EA instead of 2010EA[0] to get multiple practitioners if applicable
		 */	
		{
			fullUrl: "urn:uuid:" ++ practitionerId,
		"resource" : clean(createPractitioner(practitionerId, 
										fhirConstantsObj.SubmitResponse.practitioner.identificationSystem,
										loop2000C."2000E_Loop"[0]."2010EA_Loop"[0]."NM1_PatientEventProviderName",
										loop2000C."2000E_Loop"[0]."2010EA_Loop"[0].N3_PatientEventProviderAddress,
										loop2000C."2000E_Loop"[0]."2010EA_Loop"[0].N4_PatientEventProviderCityStateZIPCode,
										loop2000C."2000E_Loop"[0]."2010EA_Loop"[0]."PER_ProviderContactInformation"
		))
		
		}, //End Practitioner
		{
			fullUrl: "urn:uuid:" ++ coverageId,
			"resource" : clean(createCoveragePAS(fhirConstantsObj.SubmitResponse.coverage.relationshipSystem,
										coverageId,
										subscriberId,
										loop2000C."2000D_Loop"."2010D_Loop"."NM1_DependentName"."NM109_DependentPrimaryIdentifier",
										depdendentId,
										loop2000C."2000D_Loop".INS_DependentRelationship."INS02_IndividualRelationshipCode",
										payorId))	
		}, //End Coverage
		{
			fullUrl: "urn:uuid:" ++ payorId,
			"resource" : clean(createOrganization(fhirConstantsObj.SubmitResponse.organization.identifierSystem,
											loop2000A."2010A_Loop".NM1_UtilizationManagementOrganizationUMOName,
											loop2000A."2010A_Loop"."PER_UtilizationManagementOrganizationUMOContactInformation",
											fhirConstantsObj.SubmitResponse.organization.typeSystem,
											payorId
			))
		}//End Insurer Org 
	]
}