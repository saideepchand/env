/**
 * Module that provides support for submit 275 request mapping.
 */
%dw 2.0
output application/java
import substringAfter from dw::core::Strings
// Import segment tools.
import 
	createBGN,
	createNM103Type,
	createNM1,
	createN3,
	createN4,
	createDTP,
	createDMG,
	createPER,
	createSV1,
	createSV3,
	createUM,
	createINS,
	createHI,
	createBIN,
	createEFI,
	createCAT,
	createTRN,
	createLX,
	createNX1
from dwl::x12Util::x12SegmentTools
// Import segment qualifiers
import getSegmentQualifiers from dwl::x12Util::x12SegmentQualifiers
// Variables
var segmentQualifiers = getSegmentQualifiers()."275Submit"
var claimResource=vars.claimResource
var requesterOrganization = vars.requesterOrganization
var insurerOrganization = vars.insurerOrganization
var coverage = vars.coverage
var subscriberPatient = vars.subscriberPatient
var beneficiaryPatient = vars.beneficiaryPatient
var subscriberPatientId = subscriberPatient.identifier[0].value	default " "
var beneficiaryPatientId = beneficiaryPatient.identifier[0].value default " "


// Claim Supporting Additional Info contains the value to be mapped to BIN segment
var claimSupportingInfoAdditionalInfo=(claimResource.supportingInfo filter($.category.coding[0].code == "attachment" and $.category.coding[0].system == "http://terminology.hl7.org/CodeSystem/claiminformationcategory"))[0]
---
{
	"TransactionSets": {
		"v005010X210": {
			"275": [
				{
            "Heading" : {
                "BGN_BeginningSegment" : createBGN(segmentQualifiers."BGN"."BGN_BeginningSegment"."bgn01",
                								   claimResource.id default uuid(),
                								   payload.timestamp default now()
                ),
                
                "1000A_Loop" : {
                    "NM1_PayerName" : createNM1("Payer",
                    							segmentQualifiers."NM1"."NM1_PayerName"."nm101",
                    							segmentQualifiers."NM1"."NM1_PayerName"."nm102",
                    							insurerOrganization.name default "",
                    							"","","","",
                    							segmentQualifiers."NM1"."NM1_PayerName"."nm108",
                    							insurerOrganization.identifier[0].value)
                },
                "1000B_Loop" : {
                    "NM1_SubmitterInformation" : createNM1("Submitter",
                    									   segmentQualifiers."NM1"."NM1_SubmitterInformation"."nm101",
	                    									   if(requesterOrganization.resourceType == "Practitioner") "1" else "2",
	                    									   if(requesterOrganization.resourceType == "Practitioner") requesterOrganization.name[0].family else requesterOrganization.name,
	                    									   if(requesterOrganization.resourceType == "Practitioner") requesterOrganization.name[0].given[0] else "",
	                    									   if(requesterOrganization.resourceType == "Practitioner") requesterOrganization.name[0].given[1] else "",
	                    									   "",
	                    									   "",
                    									   segmentQualifiers."NM1"."NM1_SubmitterInformation"."nm108",
                    									   requesterOrganization.identifier[0].value
                    )
                },
                "1000C_Loop" : {
                    "NM1_ProviderNameInformation" : createNM1("Provider",
                    										  segmentQualifiers."NM1"."NM1_ProviderNameInformation"."nm101",
	                    									   if(requesterOrganization.resourceType == "Practitioner") "1" else "2",
	                    									   if(requesterOrganization.resourceType == "Practitioner") requesterOrganization.name[0].family else requesterOrganization.name,
	                    									   if(requesterOrganization.resourceType == "Practitioner") requesterOrganization.name[0].given[0] else "",
	                    									   if(requesterOrganization.resourceType == "Practitioner") requesterOrganization.name[0].given[1] else "",
	                    									   "",
	                    									   "",
                    										  segmentQualifiers."NM1"."NM1_ProviderNameInformation"."nm108",
                    										  requesterOrganization.identifier[0].value
                    ),
                    "1100C_Loop" : {
                        "NX1_ProviderIdentification" : createNX1(segmentQualifiers."NX1"."NX1_ProviderIdentification"."nx101"),
                        "N3_ProviderAddress" : createN3("Provider",
                        								requesterOrganization.address[0].line[0],
                        								requesterOrganization.address[0].line[1]),
                        "N4_ProviderCityStateZIPCode" : createN4("Provider",
                        								requesterOrganization.address[0].city,
                        								requesterOrganization.address[0].state,
                        								requesterOrganization.address[0].postalCode,
                        								requesterOrganization.address[0].country,
                        								requesterOrganization.address[0].district)                            
                    }//End 1100C_Loop
                },//End 1000C_Loop
                "1000D_Loop" : {
                    "NM1_PatientName" : if(isEmpty(beneficiaryPatient)) 
                    					createNM1("Patient",
                    						"275",
                    						segmentQualifiers."NM1"."NM1_PatientName"."nm101",
                    						segmentQualifiers."NM1"."NM1_PatientName"."nm102",
                    						subscriberPatient.name[0].family,
                    						(subscriberPatient.name[0].given joinBy " "),
                    						subscriberPatient.name[0].middle,
                    						subscriberPatient.name[0].suffix[0],
                    						subscriberPatient.name[0].prefix[0],
                    						segmentQualifiers."NM1"."NM1_PatientName"."nm108",
                    						subscriberPatientId
                    					)
                                        else createNM1("Patient",
                                        				"275",
                                        				segmentQualifiers."NM1"."NM1_PatientName"."nm101",
                                        				segmentQualifiers."NM1"."NM1_PatientName"."nm102",
                                        				beneficiaryPatient.name.family,
                                        				beneficiaryPatient.name.given,
                                        				beneficiaryPatient.name.middle,
                                        				beneficiaryPatient.name.suffix,
                                        				beneficiaryPatient.name.prefix,
                                        				segmentQualifiers."NM1"."NM1_PatientName"."nm108",
                                        				beneficiaryPatientId
                                        ),
                    "REF_PatientControlNumber" : {
                        "REF01_ReferenceIdentificationQualifier" : segmentQualifiers."REF"."REF_PatientControlNumber"."ref01",
                        "REF02_PatientControlNumber" : if(isEmpty(beneficiaryPatient)) subscriberPatient.identifier[0].value
                                                       else beneficiaryPatient.identifier[0].value
                    },
                    "REF_MedicalRecordIdentificationNumber" : {
                        "REF01_ReferenceIdentificationQualifier" : segmentQualifiers."REF"."REF_MedicalRecordIdentificationNumber"."ref01",
                        "REF02_MedicalRecordIdentificationNumber" : if(isEmpty(beneficiaryPatient)) subscriberPatient.id
                                                       else beneficiaryPatient.id
                    },
                    ("REF_ClaimIdentificationNumberForClearinghousesAndOtherTransmissionIntermediaries" : {
                        "REF01_ReferenceIdentificationQualifier" : segmentQualifiers."REF"."REF_ClaimIdentificationNumberFor"."ref01",
                        "REF02_ClearinghouseTraceNumber" : claimResource.id
                    }) if(! isEmpty(claimResource.id)),
                    ("DTP_ClaimServiceDate" : {
                        (
                        	if(! isEmpty(claimResource.supportingInfo[0].timing.timingPeriod)) {
	                        	"DTP01_DateTimeQualifier" : segmentQualifiers."DTP"."DTP_ClaimServiceDate"."dtp01",
	                            "DTP02_DateTimePeriodFormatQualifier" : segmentQualifiers."DTP"."DTP_ClaimServiceDate"."dtp02-RD8",
	                            "DTP03_ClaimServicePeriod" : claimResource.supportingInfo[0].timing.timingPeriod
                        	}
	                        else {
	                        	"DTP01_DateTimeQualifier" : segmentQualifiers."DTP"."DTP_ClaimServiceDate"."dtp01",
	                            "DTP02_DateTimePeriodFormatQualifier" : segmentQualifiers."DTP"."DTP_ClaimServiceDate"."dtp02-D8",
	                            "DTP03_ClaimServicePeriod" : claimResource.supportingInfo[0].timing.timingDate                              
	                        }
                        )
                    }) if(((! isEmpty(payload.supportingInfo.servicedPeriod))) or ((! isEmpty(payload.supportingInfo.servicedDate))))
                },//End 1000D_Loop
            }, //End Heading
            "Detail" : {
                "2000A_Loop" : [{
                    "LX_AssignedNumber" : createLX(segmentQualifiers."LX"."LX_AssignedNumber"."lx01"),
                    "TRN_PayerClaimControlNumberProviderAttachmentControlNumber" : createTRN("Payer",segmentQualifiers."TRN"."TRN_PayerClaimControlNumberProviderAttachmentControlNumber"."trn01",
                    																		 (claimResource.identifier[0].value default uuid()),//trn02
                    																		 "",""),
                    "2100A_Loop" : {
                        ("DTP_ServiceLineDateOfService" : {
                            "DTP01_DateTimeQualifier" : segmentQualifiers."DTP"."DTP_ServiceLineDateOfService"."dtp01",
                            (if(isEmpty(claimResource.item[0].servicedDate)) {
                                "DTP02_DateTimePeriodFormatQualifier" : segmentQualifiers."DTP"."DTP_ServiceLineDateOfService"."dtp02-RD8",
                                "DTP03_ServiceDate" : claimResource.item[0].servicedPeriod.start ++ "-" ++ claimResource.item[0].servicedPeriod.end 
                            }
                            else {
                                "DTP02_DateTimePeriodFormatQualifier" : segmentQualifiers."DTP"."DTP_ServiceLineDateOfService"."dtp02-D8",
                                "DTP03_ServiceDate" : claimResource.item[0].servicedDate                             
                            })
                        }) if(((! isEmpty(claimResource.item[0].servicedPeriod))) or ((! isEmpty(claimResource.item[0].servicedDate))))
                    },//End 2100A_Loop
                    "2100B_Loop" : {
                        "DTP_AdditionalInformationSubmissionDate" : createDTP("AdditionalInformationSubmittedDate",
                        													  segmentQualifiers."DTP"."DTP_AdditionalInformationSubmissionDate"."dtp01",
                        													  segmentQualifiers."DTP"."DTP_AdditionalInformationSubmissionDate"."dtp02",
                        													  claimResource.created) ,
                        "CAT_CategoryOfPatientInformationService" : createCAT(segmentQualifiers."CAT"."CAT_CategoryOfPatientInformationService"."cat01",
                        													  segmentQualifiers."CAT"."CAT_CategoryOfPatientInformationService"."cat02"),
                        (if (!(isEmpty(claimSupportingInfoAdditionalInfo.valueAttachment.data)))
                        "2110B_Loop" : {
                            "EFI_ElectronicFormatIdentification" : createEFI(segmentQualifiers."EFI"."EFI_ElectronicFormatIdentification"."efi01"),
                            "BIN_BinaryDataSegment" : createBIN(claimSupportingInfoAdditionalInfo.valueAttachment.data)
                        }  else null)
                    }
                }] //200A_Loop End
            }
        }
			]
		}
	}
}