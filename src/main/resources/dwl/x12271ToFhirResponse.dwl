/**
 * Module that provides support for HIPAA X12 271 to FHIR R4 Coverage Eligibility Response transformation. 
 */
%dw 2.0
output application/json
skipNullOn="everywhere"

import fhirConstants from dwl::x12Util::fhirConstants
import clean, mapGuid, toString from dwl::Util
import createCoverage, createPatient, createOrganization,createPractitioner,createCoverageEligibilityResponse,createEncounter from dwl::x12Util::x12SegmentTools

var fhirConstantsObj = fhirConstants()
var loop2000A = payload.Detail."2000A_Loop"[0]
var loop2000B = loop2000A."2000B_Loop"[0]
var loop2000C = loop2000B."2000C_Loop"[0]
var loop2000D = loop2000C."2000D_Loop"[0]
var dependentPatientExists = if(! isEmpty(loop2000D default [])) true else false

// Creating subscriberId due to paucity of test data
var subscriberId = "sub-" ++ mapGuid("patient" ++ toString(loop2000C."2100C_Loop"[0]) default uuid())

// Dependent ID
var depdendentId = 
	if(dependentPatientExists) 
		"dep-" ++ mapGuid("dependent" ++ toString(loop2000D."2100D_Loop"[0]) default uuid())
	else 
		subscriberId

// Organization ID
var payorId = "org-" ++ mapGuid("organization" ++ toString(loop2000B."2100A_Loop"[0]) default uuid())

var requesterType = loop2000B."2100B_Loop".NM1_InformationReceiverName.NM102_EntityTypeQualifier

// Provider ID
var providerId = 
	if(requesterType == "1") 
		"prac-" ++ mapGuid("practitioner" ++ toString(loop2000B."2100B_Loop") default uuid())
	else 
		"org-" ++ mapGuid("organization" ++ toString(loop2000B."2100B_Loop"[0]) default uuid())


// Coverage ID
var coverageId = "cov-" ++ mapGuid("coverage" ++ toString(loop2000C."2100C_Loop"[0]) default uuid())

// Coverage Response ID
var covRespId = "covResp-" ++ mapGuid("coverageresponse" ++ toString(payload.Heading[0]) default uuid())

var benefitsLoop = if(dependentPatientExists) loop2000D."2100D_Loop" else loop2000C."2100C_Loop"
var benefitPeriod = {
    "start" : if(dependentPatientExists) (loop2000D."2100D_Loop".DTP_DependentDate filter($.DTP01_DateTimeQualifier == "346"))[0].DTP03_DateTimePeriod 
              else (loop2000C."2100C_Loop".DTP_SubscriberDate filter($.DTP01_DateTimeQualifier == "346"))[0].DTP03_DateTimePeriod,
    "end" : if(dependentPatientExists) (loop2000D."2100D_Loop".DTP_DependentDate filter($.DTP01_DateTimeQualifier == "347"))[0].DTP03_DateTimePeriod 
            else (loop2000C."2100C_Loop".DTP_SubscriberDate filter($.DTP01_DateTimeQualifier == "347"))[0].DTP03_DateTimePeriod
}

var insuranceRelCode = if(! dependentPatientExists)  loop2000C."2100C_Loop"[0].INS_SubscriberRelationship.INS02_IndividualRelationshipCode
else loop2000D."2100D_Loop"[0].INS_DependentRelationship.INS02_IndividualRelationshipCode

---
{
	"resourceType" : "Bundle",
	"type" : "collection",
	"identifier" : {
			"system" : fhirConstantsObj.CoverageEligibilityResponse.bundle.identifierSystem,
			"value" : "http://" ++ uuid()
		},
    "entry" : [  
        {
        	fullUrl: "urn:uuid:" ++ coverageId,
            "resource" : clean(createCoverage(fhirConstantsObj.CoverageEligibilityResponse.coverage.relationshipSystem,
							            coverageId,subscriberId,
							            depdendentId,
							            loop2000C."2100C_Loop"[0].NM1_SubscriberName.NM109_SubscriberPrimaryIdentifier,   insuranceRelCode,
							            payorId)),
        },
		({
			fullUrl: "urn:uuid:" ++ depdendentId,
		    "resource" : clean(createPatient(fhirConstantsObj.CoverageEligibilityResponse.patient.identifierSystem,
	        							fhirConstantsObj.CoverageEligibilityResponse.patient.identificationCode,
							            depdendentId,
							            loop2000D."2100D_Loop"[0].NM1_DependentName,
							            loop2000D."2100D_Loop"[0].N3_DependentAddress,
							            loop2000D."2100D_Loop"[0].N4_DependentCityStateZIPCode,
							            loop2000D."2100D_Loop"[0]."DMG_DependentDemographicInformation"
							            ))        	
        }) if(dependentPatientExists), //Dependent Patient    
        {
        	fullUrl: "urn:uuid:" ++ subscriberId,
            "resource" : clean(createPatient(fhirConstantsObj.CoverageEligibilityResponse.patient.identifierSystem,fhirConstantsObj.CoverageEligibilityResponse.patient.identificationCode,
							            subscriberId,
							            loop2000C."2100C_Loop"[0].NM1_SubscriberName,
							            loop2000C."2100C_Loop"[0].N3_SubscriberAddress,
							            loop2000C."2100C_Loop"[0].N4_SubscriberCityStateZIPCode,
							            loop2000C."2100C_Loop"[0].DMG_SubscriberDemographicInformation
							            ))   
         }, //Subscriber 
         //Mapping the first information source due to lack of data. This process can be repeated for each Information Source
         {
         	fullUrl: "urn:uuid:" ++ payorId,
            "resource" : clean(createOrganization(fhirConstantsObj.CoverageEligibilityResponse.organization.identifierSystem,
            								loop2000A."2100A_Loop"[0].NM1_InformationSourceName, //Mapping the first information source due to lack of data. This process can be repeated for each Information Source
								            {},//No N3 Segment for InformationSource
								            {},//No N3 Segment for InformationSource
            								loop2000A."2100A_Loop"[0].PER_InformationSourceContactInformation[0],
            								fhirConstantsObj.CoverageEligibilityResponse.organization.typeSystem,
            								payorId,
            								"InformationSource"))
        },//Information Source
        //Mapping the first information receiver due to lack of data. This process can be repeated for each Information Source
		{
			fullUrl: "urn:uuid:" ++ providerId,
			"resource" : if(requesterType == "1") 
            			 	clean(createPractitioner(providerId,
		            			 					   fhirConstantsObj.CoverageEligibilityResponse.practitioner.identificationSystem,
		            			 					   loop2000B."2100B_Loop".NM1_InformationReceiverName,
		            			 					   loop2000B."2100B_Loop".N3_InformationReceiverAddress,
		            			 					   loop2000B."2100B_Loop".N4_InformationReceiverCityStateZIPCode
            			 	))
            			 else
            			 	clean(createOrganization(fhirConstantsObj.CoverageEligibilityResponse.organization.identifierSystem,
	            			 						loop2000B."2100B_Loop"[0].NM1_InformationReceiverName,
	    	           			 					loop2000B."2100B_Loop"[0].N3_InformationReceiverAddress,
	             			 					    loop2000B."2100B_Loop"[0].N4_InformationReceiverCityStateZIPCode,
	             			 					    {}, //No PER Segment for Information Receiver
	             			 					    fhirConstantsObj.CoverageEligibilityResponse.organization.typeSystem,
	             			 					    providerId,
	             			 					    "InformationReceiver"
            			 	))
        },
        {        	
        	fullUrl: "urn:uuid:enc-1",
        	"resource": clean(createEncounter(DTP03_DateTimePeriod))
        	
        },
         //Information Receiver can be either Practitioner or Organization
		{
			fullUrl: "urn:uuid:" ++ covRespId,
        	"resource" : clean(createCoverageEligibilityResponse(fhirConstantsObj.CoverageEligibilityResponse,
											        		covRespId,
											            	payload.Heading[0].BHT_BeginningOfHierarchicalTransaction,
												            if(dependentPatientExists) depdendentId else subscriberId,
												            requesterType,
												            providerId,
												            isEmpty(payload.Detail."2000A_Loop"."AAA_RequestValidation"),
												            payorId,
												            coverageId,
												            benefitPeriod,
												            benefitsLoop,
												            dependentPatientExists
												            ))
        }                          
        
    ]
}