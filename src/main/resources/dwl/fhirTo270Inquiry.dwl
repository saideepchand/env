/**
 * Module that provides support for FHIR R4 CoverageEligibilityRequest to HIPAA X12 270 transformation.
 */
 %dw 2.0
output application/java
import substringAfter from dw::core::Strings

import getSegmentQualifiers from dwl::x12Util::x12SegmentQualifiers
import getResource,createBHT,createNM1,createN3,createN4,createREF,createINS,createDMG,createHI from dwl::x12Util::x12SegmentTools

var segmentQualifiers = (getSegmentQualifiers())."270"

var coverageEligibilityRequest = getResource(payload.entry,"","CoverageEligibilityRequest")
var insurerId = substringAfter(coverageEligibilityRequest.insurer.reference,"/")
var insurer = getResource(payload.entry,insurerId,"")

var practitionerId = substringAfter(coverageEligibilityRequest.provider.reference,"/")
var requestor = getResource(payload.entry,practitionerId,"")
var coverageId = substringAfter(coverageEligibilityRequest.insurance[0].coverage.reference,"/")
var coverage = getResource(payload.entry,coverageId,"")
var isSubscriberPatient = if(coverageEligibilityRequest.patient.reference  == coverage.subscriber.reference) true else false
var subscriberPatientId =  if(isSubscriberPatient) substringAfter(coverageEligibilityRequest.patient.reference,"/")
						   else substringAfter(coverage.subscriber.reference,"/")
var dependentPatientId = if(! isSubscriberPatient) substringAfter(coverageEligibilityRequest.patient.reference,"/") else ""
var subscriberPatient = getResource(payload.entry,subscriberPatientId,"")
var dependentPatient = if(! isSubscriberPatient) getResource(payload.entry,dependentPatientId,"") 
					   else {}
var informationReceiver = (
	if((coverageEligibilityRequest.provider.reference default "") startsWith "Organization") {
		"qualifier" : "2",
		"lastName" : requestor.name,
		"firstName" : "",
		"middleName" : "",
		"prefix" :  "",
		"suffix" : "",
		"idQualifier" : "SV",
		"identifier" : requestor.identifier[0].value
	}
	else {
		"qualifier" : "1",
		"lastName" : requestor.name.family,
		"firstName" : requestor.name.given[0],
		"middleName" : requestor.name.given[1],
		"prefix" :  "",
		"suffix" : requestor.name.suffix[0],
		"idQualifier" : if(requestor.identifier[0].system == "SS") "34" else "SV",
		"identifier" : requestor.identifier[0].value
	}
)

---
{
	"TransactionSets" : {
		"v005010X279A1" : {
			"270" : [
				{
					"Heading" : {
						"BHT_BeginningOfHierarchicalTransaction" : createBHT("",segmentQualifiers.BHT.BHT_BeginningOfHierarchicalTransaction.bht01,
																			segmentQualifiers.BHT.BHT_BeginningOfHierarchicalTransaction.bht02,
																			coverageEligibilityRequest.identifier[0].value,
																			now(),"")
					},
					"Detail" : {
						"2000A_Loop" : [
							{
								"2100A_Loop" : {
									"NM1_InformationSourceName" : createNM1("InformationSource",
																			segmentQualifiers."NM1"."NM1_InformationSourceName".nm101,
																			segmentQualifiers."NM1"."NM1_InformationSourceName".nm102,
																			insurer.name,
																			"","","","",
																			segmentQualifiers."NM1".NM1_InformationSourceName.nm108,
																			insurer.identifier[0].value
																			)									
								}, //End 2100A_Loop
								"2000B_Loop" : [{
									"2100B_Loop" : {
										"NM1_InformationReceiverName" : createNM1("InformationReceiver",
																		segmentQualifiers."NM1".NM1_InformationReceiverName.nm101,
																		informationReceiver.qualifier,
																		informationReceiver.lastName,
																		informationReceiver.firstName,
																		informationReceiver.middleName,
																		informationReceiver.prefix,
																		informationReceiver.suffix,
																		informationReceiver.idQualifier,
																		informationReceiver.identifier),
										("N3_InformationReceiverAddress" : createN3("InformtionReceiver",
																					requestor.address.line[0],
																					requestor.address.line[1])
										) if(! isEmpty(requestor.address.line)),
										("N4_InformationReceiverCityStateZIPCode" : createN4("InformationReceiver",
																					requestor.address.city,
																					requestor.address.state,
																					requestor.address.postalCode,
																					requestor.address.country,
																					""
																					)
									    ) if(! isEmpty(requestor.address.city))										
									}, //End 2100B_Loop
									"2000C_Loop" : [{
										"2100C_Loop" : {
											"NM1_SubscriberName" : createNM1("Subscriber",
																			 segmentQualifiers.NM1."NM1_SubscriberName".nm101,
																			 segmentQualifiers.NM1."NM1_SubscriberName".nm102,
																			 subscriberPatient.name[0].family,
																			 subscriberPatient.name[0].given[0],
																			 subscriberPatient.name[0].given[1],
																			 "",
																			 subscriberPatient.name[0].suffix[0],
																			 segmentQualifiers.NM1."NM1_SubscriberName".nm108,
																			 subscriberPatient.identifier[0].value
																			 ),
											("N3_SubscriberAddress" : createN3("Subscriber",
																			  subscriberPatient.address.line[0],
																			  subscriberPatient.address.line[1]
																			  )) if(! isEmpty(subscriberPatient.address.line)),
											("N4_SubscriberCityStateZIPCode" : createN4("Subscriber",
																						subscriberPatient.address.city,
																						subscriberPatient.address.state,
																						subscriberPatient.address.postalCode,
																						subscriberPatient.address.country,""
																					   )) if(! isEmpty(subscriberPatient.address.city)),
											("REF_SubscriberAdditionalIdentification" : [
													createREF("SubscriberSupplementalIdentifier",
															  segmentQualifiers.REF.REF_SubscriberAdditionalIdentification.ref01,
															  substringAfter(coverageEligibilityRequest.insurance["coverage"][0].reference,"/")
															  )
											]
											) if(! isEmpty(coverageEligibilityRequest.insurance["coverage"])),
											"DMG_SubscriberDemographicInformation" : createDMG("Subscriber",
																							   segmentQualifiers.DMG.DMG_SubscriberDemographicInformation.dmg01,
																							   subscriberPatient.birthDate,
																							   subscriberPatient.gender
																								),
											//Mapping diagnosis from first item only. Extend mapping to use other items as necessary
											("HI_SubscriberHealthCareDiagnosisCode" : createHI(
																							 segmentQualifiers.HI.HI_SubscriberHealthCareDiagnosisCode.hi101,
																							 coverageEligibilityRequest.item[0].diagnosis[0].diagnosisCodeableConcept.coding[0].code,
																							 segmentQualifiers.HI.HI_SubscriberHealthCareDiagnosisCode.hi201,
																							 coverageEligibilityRequest.item[0].diagnosis[1].diagnosisCodeableConcept.coding[0].code	
																							)
											) if(isEmpty(dependentPatient)),
											("2110C_Loop" : flatten(coverageEligibilityRequest.item) map(it,itIdx) -> {
												//Type 30 implies Health Benefit Plan Coverage, 
												//which returns all of the types of coverages supported 
												//for the given parameters. Request can be made granular if supported by the payer system
											    ("EQ_SubscriberEligibilityOrBenefitInquiry" : {
											        ("EQ01_ServiceTypeCode" : [segmentQualifiers.EQ.EQ_SubscriberEligibilityOrBenefitInquiry.eq01]) if(! isEmpty(it.productOrService.coding[0].code)), 
											        //Use EQ02 only when EQ01 is not used
											        (
											            "EQ02_CompositeMedicalProcedureIdentifier" : {
											                "EQ01_ProductOrServiceIDQualifier" : it.modifier[0].coding[0].code,
											                "EQ02_ProcedureCode" : it.modifier[1].coding[0].code default "",
											                "EQ03_ProcedureCode" : it.modifier[2].coding[0].code default "",
											                "EQ04_ProcedureCode" : it.modifier[3].coding[0].code default "",
											                "EQ05_ProcedureCode" : it.modifier[4].coding[0].code default "",
											                "EQ06_ProcedureCode" : it.modifier[5].coding[0].code default "",
											            }
											        )  if(isEmpty(it.productOrService.coding[0].code)),
											        //EQ05 provides a pointer to the diagnosis in the HI segment
											        //Mapping only from the first item, hence the index is only used for the first occurence
											        "EQ05_CompositeDiagnosisCodePointer" : {
											        	"EQ01_DiagnosisCodePointer" : itIdx + 1
											        }
											    }) if(itIdx == 0)
											}) if(isEmpty(dependentPatient))		
										}, //End 2100C_Loop
										("2000D_Loop" : [
											{
												"2100D_Loop" : {
													"NM1_DependentName" : createNM1("Dependent",
																			 segmentQualifiers.NM1."NM1_DependentName".nm101,
																			 segmentQualifiers.NM1."NM1_DependentName".nm102,
																			 dependentPatient.name[0].family,
																			 dependentPatient.name[0].given[0],
																			 dependentPatient.name[0].given[1],
																			 "",
																			 dependentPatient.name[0].suffix[0],
																			 "",""),
													("N3_DependentAddress" : createN3("Dependent",
																			dependentPatient.address.line[0],
																			dependentPatient.address.line[1]
													)) if(! isEmpty(dependentPatient.address.line)),
													("N4_DependentCityStateZIPCode" : createN4("Dependent",
																						dependentPatient.address.city,
																						dependentPatient.address.state,
																						dependentPatient.address.postalCode,
																						dependentPatient.address.country,""
													)) if(! isEmpty(dependentPatient.address.city)),
													("REF_SubscriberAdditionalIdentification" : [
														createREF("SubscriberSupplementalIdentifier",
																  segmentQualifiers.REF.REF_SubscriberAdditionalIdentification.ref01,
																  substringAfter(coverageEligibilityRequest.insurance["coverage"][0].reference,"/")			
														)	
													]
													) if(! isEmpty(coverageEligibilityRequest.insurance["coverage"])),
													"DMG_DependentDemographicInformation" : createDMG("Dependent",
																									 segmentQualifiers.DMG.DMG_SubscriberDemographicInformation.dmg01,
																									 dependentPatient.birthDate,
																									 dependentPatient.gender	
																									 ), 
													"INS_DependentRelationship" : createINS("Dependent",
																							segmentQualifiers.INS.INS_DependentRelationship.ins01,
																							coverage.relationship.coding[0].code match {
																								case "spouse" -> "01"
																								case "child" -> "19"
																								case "other" -> "34"
																								else -> "34"
																							}				
													),
													//Mapping diagnosis from first item only. Extend mapping to use other items as necessary 
													"HI_DependentHealthCareDiagnosisCode" : createHI(
														segmentQualifiers.HI.HI_SubscriberHealthCareDiagnosisCode.hi101,
														coverageEligibilityRequest.item[0].diagnosis[0].diagnosisCodeableConcept.coding[0].code,
														segmentQualifiers.HI.HI_SubscriberHealthCareDiagnosisCode.hi201,
														coverageEligibilityRequest.item[0].diagnosis[1].diagnosisCodeableConcept.coding[0].code
													),
													("2110D_Loop" : flatten(coverageEligibilityRequest.item) map(it,itIdx) -> {
														//Type 30 implies Health Benefit Plan Coverage, 
														//which returns all of the types of coverages supported 
														//for the given parameters. Request can be made granular if supported by the payer system
													    ("EQ_DependentEligibilityOrBenefitInquiry" : {
													        ("EQ01_ServiceTypeCode" : [segmentQualifiers.EQ.EQ_SubscriberEligibilityOrBenefitInquiry.eq01]) if(! isEmpty(it.productOrService.coding[0].code)), 
													        //Use EQ02 only when EQ01 is not used
													        (
													            "EQ02_CompositeMedicalProcedureIdentifier" : {
													                "EQ01_ProductOrServiceIDQualifier" : it.modifier[0].coding[0].code,
													                "EQ02_ProcedureCode" : it.modifier[1].coding[0].code default "",
													                "EQ03_ProcedureCode" : it.modifier[2].coding[0].code default "",
													                "EQ04_ProcedureCode" : it.modifier[3].coding[0].code default "",
													                "EQ05_ProcedureCode" : it.modifier[4].coding[0].code default "",
													                "EQ06_ProcedureCode" : it.modifier[5].coding[0].code default "",
													            }
													        )  if(! isEmpty(it.productOrService.coding[0].code)),
													        //EQ05 provides a pointer to the diagnosis in the HI segment
													        ("EQ05_CompositeDiagnosisCodePointer" : {
													        	"EQ01_DiagnosisCodePointer" : itIdx + 1
													        }) 
													    }) if(itIdx == 0)
													}) if(! isEmpty(dependentPatient))
												},
											}
										]) if(! isEmpty(dependentPatient))// End 2000D_Loop
									}]	// End 2000C_Loop									

								}], //End 2000B_Loop							
						}
						], //End 2000A_Loop
					},
					"Summary" : {
						
					}
				}
			]
		}
	}
}