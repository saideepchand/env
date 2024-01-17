/**
 * Module that provides support for inquiry 278 response mapping.
 */
%dw 2.0
output application/json
skipNullOn="everywhere"
import camelize,substringBefore,substringAfter from dw::core::Strings
import clean, mapGuid, toString from dwl::Util
import createCoveragePAS, createTelecom,telecomTypeX12FHIR,relationCodeX12FHIR,genderLookupX12FHIR,createPatient,createPractitioner,createCoverage,createOrganization,createInquiryResponse,createEncounter,createHeader,createCondition,createProcedure,createLocation from dwl::x12Util::x12SegmentTools

import fhirConstants from dwl::x12Util::fhirConstants

var resp278=payload."TransactionSets"."v005010X215"."278"[0]
var loop2000A=resp278.Detail."2000A_Loop"
var loop2000B=loop2000A."2000B_Loop"
var loop2000C=loop2000B."2000C_Loop"[0]
var fhirConstantsObj = fhirConstants()
var dependentPatientExists=(! isEmpty(loop2000C[0]."2000D_Loop")) default false

// Creating subscriberId due to paucity of test data
var subscriberId = "sub-" ++ mapGuid("patient" ++ toString(loop2000C."2010C_Loop") default uuid())

// Dependent ID
var depdendentId = 
	if(dependentPatientExists) 
		"dep-" ++ mapGuid("dependent" ++ toString(loop2000C."2000D_Loop") default uuid())
	else 
		subscriberId

// Organization ID
var payorId = "org-" ++ mapGuid("organization" ++ toString(loop2000A) default uuid())

var inqRespId = "inq-" ++ mapGuid("inquiryresponse" ++ toString(resp278.Heading) default uuid())

var coverageId="cov-" ++ mapGuid("coverage" ++ toString(loop2000C."2000D_Loop") default uuid())

var loop2000FExists=(! isEmpty(flatten(loop2000C."2000E_Loop"."2000F_Loop")))

var inqRespParams={
	"id" : inqRespId,
	"identifier" : {
		"system" : fhirConstantsObj.InquiryResponse.identifierSystem,
	},
	("preAuthPeriod" : {
				"start" : min(flatten(loop2000C."2000E_Loop"."2000F_Loop").DTP_CertificationIssueDate1.DTP03_CertificationIssueDate default [""]),
				"end" : max(flatten(loop2000C."2000E_Loop"."2000F_Loop")."DTP_CertificationExpirationDate1"."DTP03_CertificationExpirationDate" default [""])
			}) if(loop2000FExists)
}
var startDate = inqRespParams.preAuthPeriod.start
var endDate = inqRespParams.preAuthPeriod.end
log(payload)
var orderingNPI=payload."TransactionSets"."v005010X215"."278"[0]."Detail"."2000A_Loop"."2000B_Loop"."2010B_Loop"[0]."NM1_RequesterName"."NM109_RequesterIdentifier"
var performingNPI=(loop2000C."2000E_Loop"."2010EA_Loop" filter (item,idx) -> (item.NM1_PatientEventProviderName.NM101_EntityIdentifierCode=="SJ"))[0].NM1_PatientEventProviderName.NM109_PatientEventProviderIdentifier
//log("Ordering" ++ orderingNPI)
//log("Performing" ++ performingNPI)
---
{
	"resourceType" : "Bundle",
	"type" : "collection",
	"identifier" : 
		{
			"system" : fhirConstantsObj.SubmitResponse.bundle.identifierSystem,
			"value" : uuid()
		}
	,
	"entry" : [
		{"resource": clean(createHeader("orderingPrac"))},
		//clean placeholder and acct for source and practitioner info
		{
			fullUrl: "urn:uuid:" ++ subscriberId,
		    "resource" : clean(createPatient(fhirConstantsObj.SubmitResponse.patient.identifierSystem,
									   fhirConstantsObj.SubmitResponse.patient.identificationCode,
									   "Subscriber",
									   subscriberId,
									   loop2000C."2010C_Loop"."NM1_SubscriberName",
									   loop2000C."2010C_Loop".N3_SubscriberMailingAddress,
									   loop2000C."2010C_Loop".N4_SubscriberCityStateZIPCode,
									   loop2000C."2010C_Loop"."DMG_SubscriberDemographicInformation"))
		}, //End Subscriber Patient
		({
			fullUrl: "urn:uuid:" ++ subscriberId,
		    "resource" : clean(createPatient(fhirConstantsObj.SubmitResponse.patient.identifierSystem,
									   fhirConstantsObj.SubmitResponse.patient.identificationCode,
									   "Dependent",
									   subscriberId,
									   loop2000C."2000D_Loop"."2010D_Loop"."NM1_DependentName",
									   loop2000C."2000D_Loop"."2010D_Loop".N3_DependentAddress,
									   loop2000C."2000D_Loop"."2010D_Loop".N4_DependentCityStateZIPCode,
									   loop2000C."2000D_Loop"."2010D_Loop"."DMG_DependentDemographicInformation"))
		}) if(dependentPatientExists), //End Beneficiary Patient	
/*
 * Practitioner is mapped from 2010EA an array. Extend this by looping over 2010EA instead of 2010EA[0] to get multiple practitioners if applicable
 */	
	{
		fullUrl: "urn:uuid:" ++ "performingPrac1",
		"resource" : clean(createPractitioner("performingPrac",
										fhirConstantsObj.SubmitResponse.practitioner.identificationSystem,
										loop2000C."2000E_Loop"[0]."2010EA_Loop"[0]."NM1_PatientEventProviderName",
										loop2000C."2000E_Loop"[0]."2010EA_Loop"[0].N3_PatientEventProviderAddress,
										loop2000C."2000E_Loop"[0]."2010EA_Loop"[0].N4_PatientEventProviderCityStateZIPCode 
										//loop2000C."2000E_Loop"[0]."2010EA_Loop"[0]."PER_ProviderContactInformation"
		))
	}, //End Practitioner

	({
		fullUrl: "urn:uuid:" ++ "orderingPrac11",
		"resource": {
			"resourceType": "Practitioner",
			"id": "orderingPrac",
			"telecom": [
                    {
                        "system": "email",
                        "value": "daniel.frier@coherehealth.com"
                    }
                ],
            "identifier": [
                {
                    "type": {
                        "text": "NPI"
                    },
                    "value": orderingNPI
                }
            ]
		}
	}) if(orderingNPI != performingNPI),
	{
		fullUrl: "urn:uuid:" ++ coverageId,
	    "resource" : clean(createCoveragePAS(fhirConstantsObj.SubmitResponse.coverage.relationshipSystem,
	    							coverageId,
	    							subscriberId,
	    							loop2000C."2000D_Loop"."2010D_Loop"."NM1_DependentName"."NM109_DependentPrimaryIdentifier",
	    							depdendentId,
	    							loop2000C."2000D_Loop".INS_DependentRelationship."INS02_IndividualRelationshipCode",
	    							payorId
	    							
	    ))	
	}, //End Coverage
	{
		fullUrl: "urn:uuid:" ++ payorId,
	    "resource" : clean(createOrganization(fhirConstantsObj.SubmitResponse.organization.identifierSystem,
											loop2000A."NM1_UtilizationManagementOrganizationUMOName",
											loop2000A."2010A_Loop"."PER_UtilizationManagementOrganizationUMOContactInformation",
											fhirConstantsObj.SubmitResponse.organization.typeSystem,
											payorId
			))
	},//End Insurer Org 
	{        	
        	fullUrl: "urn:uuid:enc-1",
        	"resource": clean(createEncounter(loop2000C."2000E_Loop"[0]))
        	//daniel account for looping?
        	
    },
    {        	
        	fullUrl: "urn:uuid:dx-1",
        	"resource": clean(createCondition("dx-1","R69.",loop2000C."2010C_Loop"."NM1_SubscriberName"."NM109_SubscriberPrimaryIdentifier"))
        	//daniel clean placeholder
        	
    },
    {        	
        	fullUrl: "urn:uuid:px-1",
        	"resource": clean(createProcedure("px-1",loop2000C."2000E_Loop"[0]))
        	//daniel account for multiples
        	
    },
    {        	
        	fullUrl: "urn:uuid:location-1",
        	"resource": clean(createLocation(loop2000C."2000E_Loop"[0],loop2000C."2000E_Loop"[0].UM_HealthCareServicesReviewInformation.UM04_HealthCareServiceLocationInformation.UM01_FacilityTypeCode))
        	
    },
	{
		fullUrl: "urn:uuid:" ++ inqRespParams.id,
		"resource" : clean(createInquiryResponse(inqRespParams,
										   resp278.Heading.BHT_BeginningOfHierarchicalTransaction,
										   if(dependentPatientExists) (loop2000C."2000D_Loop"[0]."2010D_Loop"."NM1_DependentName"."NM109_DependentPrimaryIdentifier" default "")
                			  			   else (subscriberId default ""), //patientRef
                			  			   loop2000A."2010A_Loop"."NM1_UtilizationManagementOrganizationUMOName"."NM109_UtilizationManagementOrganizationUMOIdentifier" default "", //insurerRef
										   loop2000B."2010B_Loop"[0]."NM1_RequesterName"."NM109_RequesterIdentifier" default "", //requesterRef
										   loop2000C."2000E_Loop",//2000E Loop,
										   loop2000FExists,
										   fhirConstantsObj.InquiryResponse
		))//End InquiryResponse
	}	
	]
}