/**
 * Module that provides support for claim 837 professional mapping.
 */
 %dw 2.0
output application/java
import substringAfter,substringBefore from dw::core::Strings
// Import segment tools.
// Import functions from segment tools
import RelationshipLookup, payerSequenceNumberPayerLookup,  getResource, createDMG, createSBR, createBHT, createPER, createNM1,createN3,createN4,createREF from dwl::x12Util::x12SegmentTools
// Import segment qualifiers
import getSegmentQualifiers from dwl::x12Util::x12SegmentQualifiers
// Variables
var segmentQualifiers = (getSegmentQualifiers())."837"
var claimResource= (payload.entry filter($.resource.resourceType == "Claim"))[0].resource
var submitterType = if ( substringBefore(claimResource.provider.reference ,"/") == 'Practitioner' ) '1' // 1 -> Practitioner
					 else if ( substringBefore(claimResource.provider.reference ,"/") == 'Organization' ) '2' // 2 -> Organization
					 else ''
var providerId = substringAfter(claimResource.provider.reference,"/")
var submitter =  getResource(payload.entry,providerId, "") // provider = submitter

var insurerId=substringAfter(claimResource.insurer.reference,"/")
var insurerOrganization = getResource(payload.entry,insurerId,'') 

var coverageId=substringAfter(claimResource.insurance.coverage.reference[0],"/")
var coverage = getResource(payload.entry,coverageId,'')

var subscriberId = substringAfter(claimResource.patient.reference,"/")
var subscriber = getResource(payload.entry,subscriberId,'')

var practitionerRoleId = substringAfter(claimResource.provider.reference,"/")
var practitionerRole = getResource(payload.entry,practitionerRoleId,'')
---
{
	"TransactionSets": {
		"v005010X222A1": {
			"837": [{
				"Heading": {
					// Map BHT
					 "BHT_BeginningOfHierarchicalTransaction": createBHT("OriginatorApplication",
                                                segmentQualifiers."BHT"."BHT_BeginningOfHierarchicalTransaction"."bht01",
                                                segmentQualifiers."BHT"."BHT_BeginningOfHierarchicalTransaction"."bht02",
                                                claimResource.identifier[0].value default uuid(),
                                                 (if (!isEmpty (claimResource.created)) 
                                                 	(if (sizeOf(claimResource.created) >10 ) claimResource.created 
                                                 	else (claimResource.created  ++ "T00:10:00"))

                                                 else now()),                                          
                                                'CH'),                                            
					"1000A_Loop": {
						"NM1_SubmitterName": createNM1("Submitter",
                                                segmentQualifiers.NM1.NM1_SenderInformation.nm101, //NM101
                                                submitterType as String, //NM102
                                                if ( submitterType == '1' ) submitter.name.family[0]
                                                else if ( submitterType == '2' ) submitter.name
                                                else '', //NM103
                                                if ( submitterType == '1' ) submitter.name.given[0]
                                                else '', //NM104
                                                "", //NM105
                                                "", //NM106
                                                "", //NM107
                                                segmentQualifiers."NM1".NM1_SenderInformation.nm108, //NM108
                                                submitter.id //NM109
                                 ), //NM1_SubmitterName

						"PER_SubmitterEDIContactInformation": [createPER(
                                	"Submitter", //perType
                                	segmentQualifiers."PER"."PER_SenderContactInformation"."per01", //per01
                                	"", //per02
                                	(if (!isEmpty(submitter.telecom[0].system)) 
										(if (submitter.telecom[0].system =='phone')"TE" 
										else if (submitter.telecom[0].system =='fax') "no FX"
										else if (submitter.telecom[0].system =='email') "EM"
										else "")
								  	else ""), //per03
                                	(if (!isEmpty(submitter.telecom[0].value)) submitter.telecom[0].value else ''), //per04
                                	(if (!isEmpty(submitter.telecom[1].system)) 
										(if (submitter.telecom[1].system =='phone')"TE" 
										else if (submitter.telecom[1].system =='fax') "no FX"
										else if (submitter.telecom[1].system =='email') "EM"
										else "")
								  	else ""), //per05
                                	(if (!isEmpty(submitter.telecom[1].value)) submitter.telecom[1].value else ''), //per06
                                	(if (!isEmpty(submitter.telecom[2].system)) 
										(if (submitter.telecom[2].system =='phone')"TE" 
										else if (submitter.telecom[2].system =='fax') "no FX"
										else if (submitter.telecom[2].system =='email') "EM"
										else "")
								  	else ""), //per07
                                	(if (!isEmpty(submitter.telecom[2].value)) submitter.telecom[2].value else '') ////per08
                                )],//PER_SenderContactInformation
 
					}, //1000A_Loop
					"1000B_Loop": {	
						NM1_ReceiverName: createNM1("Receiver",
                                          segmentQualifiers.NM1.NM1_ReceiverInformation.nm101, //NM101
                                          segmentQualifiers.NM1.NM1_ReceiverInformation.nm102, //NM102
                                          insurerOrganization.name, //NM103
                                          "","","","",
                                          segmentQualifiers.NM1.NM1_ReceiverInformation.nm108, //NM108
                                          insurerId //NM109	
                                          ) //NM1_ReceiverName				
					},	//1000A_Loop												
				}, //Heading
							
				"Detail": {
					
					"2000A_Loop": [{ //BILLING PROVIDER HIERARCHICAL LEVELNM1_SubscriberName
						"2010AA_Loop": {
							NM1_BillingProviderName: createNM1(
										  "BillingProvider",
                                          segmentQualifiers.NM1.NM1_BillingProviderInformation.nm101, //NM101
                                          submitterType, //NM102
                                                if ( submitterType == '1' ) submitter.name.family[0]
                                                else if ( submitterType == '2' ) submitter.name
                                                else '', //NM103
                                          "","","","",
                                          segmentQualifiers.NM1.NM1_BillingProviderInformation.nm108, //NM108
                                          submitter.id //NM109
                                          ) , //NM1_BillingProviderInformation
                                          
                            N3_BillingProviderAddress: createN3(
                            			  "BillingProvider",
                            			  (if (!isEmpty(submitter.address[0].line[0])) submitter.address[0].line[0] else ''),
                                          (if (!isEmpty(submitter.address[0].line[1])) submitter.address[0].line[1] else '')
                                      	  ),   //N3_BillingProviderAddress
                                      	  
                                                
                           "N4_BillingProviderCityStateZIPCode" : createN4(
                           				"BillingProvider",
                           				submitter.address[0].city, //N401
                                        submitter.address[0].state, //N402
                                        submitter.address[0].postalCode, //N403
                                        submitter.address[0].country, //N404
                                        "" //N407
                           ),  //N4_RequesterCityStateZIPCode
                         
 						   "REF_BillingProviderTaxIdentification": createREF(
 						   	"BillingProvider",
 						    if ( submitterType == '1' ) 'SY'
                            else if ( submitterType == '2' ) 'EI'
                            else '', //NM103
                            (submitter.identifier filter ($.system == "http://hl7.org/fhir/sid/us-npi")).value[0]
 						   ), //REF_BillingProviderTaxIdentification
 						                         
						   "PER_BillingProviderContactInformation" : [createPER(	
										"BillingProvider", //perType
										segmentQualifiers."PER"."PER_Billing ProviderContactInformation"."per01", //per01
										'', //per02
                                	(if (!isEmpty(submitter.telecom[0].system)) 
										(if (submitter.telecom[0].system =='phone')"TE" 
										else if (submitter.telecom[0].system =='fax') "no FX"
										else if (submitter.telecom[0].system =='email') "EM"
										else "")
								  	else ""), //per03
                                	(if (!isEmpty(submitter.telecom[0].value)) submitter.telecom[0].value else ''), //per04
                                	(if (!isEmpty(submitter.telecom[1].system)) 
										(if (submitter.telecom[1].system =='phone')"TE" 
										else if (submitter.telecom[1].system =='fax') "no FX"
										else if (submitter.telecom[1].system =='email') "EM"
										else "")
								  	else ""), //per05
                                	(if (!isEmpty(submitter.telecom[1].value)) submitter.telecom[1].value else ''), //per06
                                	(if (!isEmpty(submitter.telecom[2].system)) 
										(if (submitter.telecom[2].system =='phone')"TE" 
										else if (submitter.telecom[2].system =='fax') "no FX"
										else if (submitter.telecom[2].system =='email') "EM"
										else "")
								  	else ""), //per07
								  	(if (!isEmpty(submitter.telecom[2].value)) submitter.telecom[2].value else '')  //per08
									 
									)]                                                     	           
						}, //2010AA_Loop
						 
						"2000B_Loop": [{ //BILLING PROVIDER HIERARCHICAL LEVEL
							
							
							   "SBR_SubscriberInformation": createSBR (						   	
							   	"SubscriberInformation", //perType
							   	payerSequenceNumberPayerLookup(claimResource.careTeam[0].sequence),	//per01
							   	segmentQualifiers."SBR"."SBR_SubscriberInformation"."SBR02",	//per02
							   	(if (!isEmpty(coverage.identifier[0].value)) coverage.identifier[0].value else ''),	//per03
							   	"",	//per04
							   	"",	//per05
							   	"ZZ" // per09 is hard-Coded to ZZ (Mutually Defined)
							   ),
												
							
							"2010BA_Loop": {
							NM1_SubscriberName: createNM1("Subscriber",
	                                                segmentQualifiers.NM1.NM1_SubscriberName.nm101, //NM101
	                                                segmentQualifiers.NM1.NM1_SubscriberName.nm102, //NM102
	                                                (if (!isEmpty(subscriber.name[0].family)) subscriber.name[0].family else ''), //NM103
	                                                (if (!isEmpty(subscriber.name[0].given[0])) subscriber.name[0].given[0] else ''), //NM104
	                                                (if (!isEmpty(subscriber.name[0].given[1])) subscriber.name[0].given[1] else ''), //NM105
	                                                (if (!isEmpty(subscriber.name[0].prefix[0])) subscriber.name[0].prefix[0] else ''), //NM106
	                                                (if (!isEmpty(subscriber.name[0].suffix[0])) subscriber.name[0].suffix[0] else ''), //NM107
	                                                segmentQualifiers.NM1.NM1_SubscriberName.nm108, //NM108
	                                                submitter.id //NM109
	                                 				), //NM1_SubscriberName	
	                            N3_SubscriberAddress: createN3(
	                            			  "Subscriber",
	                            			  (if (!isEmpty(subscriber.address[0].line[0])) subscriber.address[0].line[0] else ''),
	                                          (if (!isEmpty(subscriber.address[0].line[1])) subscriber.address[0].line[1] else '')
	                                      	  ),   //N3_SubscriberAddress	
	                                      	  
	                           "N4_SubscriberCityStateZIPCode" : createN4(
	                           				"Subscriber",
	                           				subscriber.address[0].city, //N401
	                                        subscriber.address[0].state, //N402
	                                        subscriber.address[0].postalCode, //N403
	                                        subscriber.address[0].country, //N404
	                                        "" //N407
	                           ),  //N4_SubscriberCityStateZIPCode                                      	  
	                                      	  
	                           "DMG_SubscriberDemographicInformation" : createDMG("Subscriber",
	                                                                     segmentQualifiers.DMG.DMG_SubscriberDemographicInformation.dmg01,
	                                                                     (if (!isEmpty(subscriber.birthDate)) (subscriber.birthDate) as Date as String { format: 'yyyyMMdd' }  else ''),
	                                                                     "")                                      	  						
							}, // 2000BA_Loop
 							"2010BB_Loop": {
							NM1_PayerName: createNM1("Payer",
	                                                segmentQualifiers.NM1.NM1_PayerInformation.nm101, //NM101
	                                                segmentQualifiers.NM1.NM1_PayerInformation.nm102, //NM102
	                                                insurerOrganization.name, //NM103
	                                                "", //NM104
	                                                "", //NM105
	                                                "", //NM106
	                                                "", //NM107			
	                                                "PI", //NM108		
	                                                insurerOrganization.identifier[0].value //NM109   
	                                 				), //NM1_SubscriberName								
							}, // 2000BB_Loop
							"2000C_Loop": [{ //PATIENT HIERARCHICAL LEVEL
								"PAT_PatientInformation1": {
									"PAT01_IndividualRelationshipCode": RelationshipLookup(coverage.relationship.coding[0].code) 
								},
								"2010CA_Loop": { // PATIENT NAME
									NM1_PatientName: createNM1("Patient", 
														"837",
		                                                segmentQualifiers.NM1.NM1_PatientName.nm101, //NM101
		                                                segmentQualifiers.NM1.NM1_PatientName.nm102, //NM102
		                                                (if (!isEmpty(subscriber.name[0].family)) subscriber.name[0].family else ''), //NM103
		                                                (if (!isEmpty(subscriber.name[0].given[0])) subscriber.name[0].given[0] else ''), //NM104
		                                                (if (!isEmpty(subscriber.name[0].given[1])) subscriber.name[0].given[1] else ''), //NM105
		                                                (if (!isEmpty(subscriber.name[0].prefix[0])) subscriber.name[0].prefix[0] else ''), //NM106
		                                                (if (!isEmpty(subscriber.name[0].suffix[0])) subscriber.name[0].suffix[0] else ''), //NM107
		                                                segmentQualifiers.NM1.NM1_SubscriberName.nm108, //NM108
		                                                '' //NM109
		                                 				), //NM1_PatientName	
		                                 				
		                            N3_PatientAddress: createN3(
				                            			  "Patient",
				                            			  (if (!isEmpty(subscriber.address[0].line[0])) subscriber.address[0].line[0] else ''),
				                                          (if (!isEmpty(subscriber.address[0].line[1])) subscriber.address[0].line[1] else '')
				                                      	  ),   //N3_PatientAddress	
				                                      	  
		                           "N4_PatientCityStateZIPCode" : createN4(
							                           				"Patient",
							                           				subscriber.address[0].city, //N401
							                                        subscriber.address[0].state, //N402
							                                        subscriber.address[0].postalCode, //N403
							                                        subscriber.address[0].country, //N404
							                                        "" //N407
		                           ),  //N4_PatientCityStateZIPCode
		                           "DMG_PatientDemographicInformation" : createDMG(
		                           											"Patient",
		                                                                     segmentQualifiers.DMG.DMG_PatientDemographicInformation.dmg01  ,
		                                                                     (if (!isEmpty(subscriber.birthDate)) (subscriber.birthDate) as Date as String { format: 'yyyyMMdd' }  else ''),
		                                                                     "") ,                             
		
		                           (if ((!isEmpty(((subscriber.identifier ) filter($."type"..code[0] == "SS"))[0])) or (!isEmpty(((subscriber.identifier ) filter($."type"..code[0] == "MB"))[0])))
		                            "REF_PropertyAndCasualtyPatientIdentifier": createREF(
		 						   	"Patient",
		 			 		 	    if (!isEmpty(((subscriber.identifier ) filter($."type"..code[0] == "SS"))[0])) 'SY'
		                            else if (!isEmpty(((subscriber.identifier ) filter($."type"..code[0] == "MB"))[0])) '1W'
		                            else '', //NM103
		                            if (!isEmpty(((subscriber.identifier ) filter($."type"..code[0] == "SS"))[0])) ((subscriber.identifier ) filter($."type"..code[0] == "SS")).value[0]
		                            else if (!isEmpty(((subscriber.identifier ) filter($."type"..code[0] == "MB"))[0])) ((subscriber.identifier ) filter($."type"..code[0] == "MB")).value[0]
		                            else ''
		 						   ) else null), //REF_BillingProviderTaxIdentification    
		                               											
								}, //2000CA_Loop
		
 						
							}], // 2000C_Loop							
							
						}],	//2000B_Loop	

 

					}],	//2000A_Loop
				}, //Detail
				"Summary": {}
			}] //837
		}
	}
}