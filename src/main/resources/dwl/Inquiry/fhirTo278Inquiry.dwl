/**
 * Module that provides support for inquiry 278 request mapping.
 */
 %dw 2.0

 output application/java
 import substringAfter,substringBefore from dw::core::Strings
 // Import segment tools.
 
 //Import functions from segment tools
 import createBHT, createNM103Type, createNM1, createN3, createN4, createDTP, createTRN,createDMG, createPER,createSV1, createUM, createINS, createHI, createDTP, createUM,providerTypeLookup,lookupPERCommType,extensionLookUp,productOrServiceLookUp,fetchSupportingInfo,createInquiry2000ELoop from dwl::x12Util::x12SegmentTools
 
 // Import segment qualifiers
 import getSegmentQualifiers from dwl::x12Util::x12SegmentQualifiers
 import fhirConstants from dwl::x12Util::fhirConstants
 // Variables
 var segmentQualifiers = getSegmentQualifiers()."278Inquiry"
 var fhirConstantsObj = fhirConstants()
 var claimResource=vars.claimResource
 var requesterOrganization = vars.requesterOrganization
 var insurerOrganization = vars.insurerOrganization
 var coverage = vars.coverage
 var subscriberPatient = vars.subscriberPatient
 var beneficiaryPatient = vars.beneficiaryPatient
 var inRequest = payload
 var claimSupportingInfo = {
 	"patientEvent" : fetchSupportingInfo(claimResource.supportingInfo,fhirConstantsObj.Submit.supportingInfo.patientEventCode,fhirConstantsObj.Submit.supportingInfo.patientEventSystem),
 	"admissionDates" : fetchSupportingInfo(claimResource.supportingInfo,fhirConstantsObj.Submit.supportingInfo.admissionCode,fhirConstantsObj.Submit.supportingInfo.admissionSystem),
 	"dischargeDates" : fetchSupportingInfo(claimResource.supportingInfo,fhirConstantsObj.Submit.supportingInfo.dischargeCode,fhirConstantsObj.Submit.supportingInfo.dischargeSystem),
 	"additionalInfo" :  fetchSupportingInfo(claimResource.supportingInfo,fhirConstantsObj.Submit.supportingInfo.additionalInfoCode,fhirConstantsObj.Submit.supportingInfo.additionalInfoSystem),
 	"msgTxt" : fetchSupportingInfo(claimResource.supportingInfo,fhirConstantsObj.Submit.supportingInfo.msgTxtCode,fhirConstantsObj.Submit.supportingInfo.msgTxtSystem)
 }
  //Set time type for each of the supportingInfo dates
 var patientDates = {
 	"patientEventTimeType" : if(! isEmpty(claimSupportingInfo.patientEvent.timingDate)) "timingDate" 
                          else if (! isEmpty(claimSupportingInfo.patientEvent.timingPeriod)) "timingPeriod"
                          else null,
     "patientAdmissionDatesType" : if(! isEmpty(claimSupportingInfo.admissionDates.timingDate)) "timingDate" 
                          else if (! isEmpty(claimSupportingInfo.admissionDates.timingPeriod)) "timingPeriod"
                          else null,
     "patientDischargeDatesType" : if(! isEmpty(claimSupportingInfo.dischargeDates.timingDate)) "timingDate" 
                          else if (! isEmpty(claimSupportingInfo.dischargeDates.timingPeriod)) "timingPeriod"
                          else null                                          
 }
 ---
 {
	"TransactionSets": {
		"v005010X215": {
            "278": [
                {
                    "Heading": {
                        // Map BHT
                     "BHT_BeginningOfHierarchicalTransaction": createBHT("Submitter",segmentQualifiers."BHT"."BHT_BeginningOfHierarchicalTransaction"."bht01",
                                                                     segmentQualifiers."BHT"."BHT_BeginningOfHierarchicalTransaction"."bht02",
                                                                     payload.identifier.value default uuid(),
                                                                     (payload.timestamp default now()),""
                                                                     )
                    },
                    "Detail": {
                        // Map 2000A_Loop
                        "2000A_Loop": {
                             ("2010A_Loop": {
                                 "NM1_UtilizationManagementOrganizationUMOName": createNM1("UtilizationManagementOrganization",
                                                                                        insurerOrganization."type"[0].coding[0].code default segmentQualifiers.NM1.NM1_UtlizationManagementOrganziation.nm101, //NM101
                                                                                        segmentQualifiers."NM1"."NM1_UtlizationManagementOrganziation"."nm102", //NM102
                                                                                        insurerOrganization.name, //NM103
                                                                                        "","","","",
                                                                                        if(insurerOrganization.identifier[0]."type".coding[0].code == "46") "46"
                                                                                        else if(insurerOrganization.identifier[0]."type".coding[0].code == "U") "PI"
                                                                                        else segmentQualifiers."NM1".NM1_UtlizationManagementOrganziation.nm108, //NM108
                                                                                        insurerOrganization.identifier[0].value //NM109
                                 ) 					
                                 }) if(! isEmpty(insurerOrganization)), //End 2010A_Loop
                        	"2000B_Loop" : {
                        		"2010B_Loop" : {
                        			"NM1_RequesterName" : createNM1("Requester",
                        											requesterOrganization."type"[0].coding[0].code default segmentQualifiers."NM1"."NM1_RequesterName"."nm101",
                        											segmentQualifiers."NM1"."NM1_RequesterName"."nm102" default segmentQualifiers."NM1"."NM1_RequesterName"."nm102",
                        											requesterOrganization.name,
                        											"","","","",
                        											segmentQualifiers."NM1".NM1_RequesterName.nm108,
                        											requesterOrganization.identifier[0].value
                        			),
                        			"N3_RequesterAddress" : createN3("Requester",requesterOrganization.address[0].line[0],
                                                                      requesterOrganization.address[0].line[1]
                                     ),
                                    "N4_RequesterCityStateZIPCode" : createN4("Requester",requesterOrganization.address[0].city, //N401
                                                                               requesterOrganization.address[0].state, //N402
                                                                               requesterOrganization.address[0].postalCode, //N403
                                                                               requesterOrganization.address[0].country, //N404
                                                                               "" //N407
                                     ),
                                     (if (!isEmpty(requesterOrganization.contact[0].telecom[0].value))
									"PER_RequesterContactInformation" : 
										createPER(
											"Requester",
											segmentQualifiers."PER"."PER_RequesterContactInformation"."per01",
											requesterOrganization.contact[0].name,
											segmentQualifiers."PER"."PER_RequesterContactInformation"."per03",
											requesterOrganization.contact[0].telecom[0].value,
											segmentQualifiers."PER"."PER_RequesterContactInformation"."per05",
											requesterOrganization.contact[0].telecom[1].value,
											segmentQualifiers."PER"."PER_RequesterContactInformation"."per07",
											requesterOrganization.contact[0].telecom[2].value
										)
								    else null),
                        		}, //2010B_Loop
                                "2000C_Loop" : [{
                                    "TRN_SubscriberTraceNumber" : [createTRN("Subscriber",
                                                                            segmentQualifiers.TRN.TRN_SubscriberTraceNumber.trn01,
                                                                            claimResource.identifier[0].value,
                                                                            claimResource.identifier[0].assigner.identifier.value,
                                                                            ""
                                    )],
                                    "2010C_Loop" : {
                                            "NM1_SubscriberName" : createNM1("Subscriber",
                                                                            segmentQualifiers."NM1"."NM1_SubscriberName"."nm101",
                                                                            segmentQualifiers."NM1"."NM1_SubscriberName"."nm102",
                                                                            subscriberPatient.name[0].family,
                                                                            subscriberPatient.name[0].given[0],
                                                                            subscriberPatient.name[0].given[1],
                                                                            subscriberPatient.name[0].prefix[0],
                                                                            subscriberPatient.name[0].suffix[0],
                                                                            segmentQualifiers."NM1"."NM1_SubscriberName"."nm108",
                                                                            subscriberPatient.identifier[0].value	default " "),
                                            ("DMG_SubscriberDemographicInformation" : createDMG("Subscriber",
                                                                                            segmentQualifiers.DMG.DMG_SubscriberDemographicInformation.dmg01,
                                                                                            subscriberPatient.birthDate,"")
                                                                                            
                                            ) if(! isEmpty(subscriberPatient.birthDate))       									
                                    },//End 2010C_Loop
                                    "2000E_Loop" : [createInquiry2000ELoop(inRequest,claimResource,segmentQualifiers,fhirConstantsObj,patientDates,claimSupportingInfo)],
                                    ("2000D_Loop" : {
                                        "TRN_DependentTraceNumber" : createTRN("Dependent",
                                                                              segmentQualifiers.TRN."TRN_SubscriberTraceNumber".trn01,
                                                                              claimResource.identifier[0].value,
                                                                              claimResource.identifier[0].assigner.identifier.value,
                                                                              ""),
                                        "2010D_Loop" : {
                                            "NM1_DependentName" : createNM1("Dependent",
                                                                            segmentQualifiers."NM1"."NM1_DependentName".nm101,
                                                                            segmentQualifiers."NM1"."NM1_DependentName".nm102,
                                                                            beneficiaryPatient.name[0].family,
                                                                            beneficiaryPatient.name[0].given[0],
                                                                            beneficiaryPatient.name[0].given[1],
                                                                            "",
                                                                            beneficiaryPatient.name[0].suffix[0],
                                                                            "",""    
                                                                            ),
                                            ("DMG_DependentDemographicInformation" : createDMG("Dependent",
                                                                                                segmentQualifiers."DMG"."DMG_DependentDemographicInformation".dmg01,
                                                                                                beneficiaryPatient.birthDate,""
                                                                                              )
                                            ) if(! isEmpty(beneficiaryPatient.birthDate))

                                        }, //End 2010D_Loop
                                        "2000E_Loop" : [createInquiry2000ELoop(inRequest,claimResource,segmentQualifiers,fhirConstantsObj,patientDates,claimSupportingInfo)]
                                        
                                    })if(! isEmpty(beneficiaryPatient)),//End 2000D_Loop
                                }] //End 2000C_Loop
                        	}
                        },
                    },
                    "Summary": {}
                }
            ]
        }
    } 	
 }
 