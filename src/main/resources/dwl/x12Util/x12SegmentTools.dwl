/**
 * This module implements X12 segment tools needed for 
 * 837, 270 and 271 segments.
 */
%dw 2.0

import * from dw::core::Strings
import clean, formatDate from dwl::Util

/**
 * Function to get resource from bundle using either resourceId or resourceType.
 * @param resourceBundle is the payload bundle to be filtered.
 * @param resourceId is the ID of the resource to be used for filtering resources.
 * @param resourceType is the type of resource to be used for filtering resources. 
 * Use either resourceId or resourceType for filtering.
 */
fun getResource(resourceBundle,resourceId,resourceType)=(
    if(! isEmpty(resourceId))
        (resourceBundle filter($.resource.id == resourceId))[0].resource
    else if (! isEmpty(resourceType))
        (resourceBundle filter($.resource.resourceType == resourceType))[0].resource
    else {}
)


/*
 * Function to Map BHT Segment.
 * Mapped only mandatory segments here.
 * Add optional elements as required.
 * This function sets the transaction set purpose code 
 * to 13 for prior auth.
 * @param bht01 is the BHT01 hierarchical structure code.
 * @param bht02 is the BHT02 hierarchical qualifier 2.
 * @param bht03 is the BHT03 submitter transaction identifier.
 * @param bht04 is a datetime with the 
 * transaction set creation datetime.
 * @return a BHT object.
 */
fun createBHT(bhtType,bht01,bht02,bht03,bht04,bht06) = (
{
    "BHT01_HierarchicalStructureCode" : bht01,
    "BHT02_TransactionSetPurposeCode":  bht02, 
    ("BHT03_" ++ bhtType ++ "TransactionIdentifier"): bht03,
    "BHT04_TransactionSetCreationDate" : bht04 as DateTime as String { format: 'yyyyMMdd' } as Date { format: 'yyyyMMdd' },
    (if (bhtType == 'OriginatorApplication')
    	"BHT05_TransactionSetCreationTime" : (bht04 as Time default now()) as Time as String {format : "HHmmss"} as Number
    else
    	"BHT05_TransactionSetCreationTime" : (bht04 as Time default now()) as Time as Time {format : "HHmmss"} 
    ), 
    "BHT06_ClaimOrEncounterIdentifier" : bht06

}
)
/*
 * Function to Map BGN Segment.
 * @param bgn01 is a string with bgn01 value.
 * @param bgn02 is a string with bgn02 value.
 * @param bgn03 is a string with bgn03 value.
 * @param bht04 is a datetime with the 
 * transaction set creation datetime.
 * @return a BGN object.
 */
fun createBGN(bgn01,bgn02,bgn03)= (
    {
    "BGN01_TransactionSetPurposeCode" : bgn01,
    "BGN02_TransactionSetReferenceNumber" : bgn02,
    "BGN03_TransactionSetCreationDate" : bgn03 as DateTime as String { format: 'yyyyMMdd' } as Date { format: 'yyyyMMdd' }
    
    }
)

/*
 * Function to write NM103 key based on type of NM1 segment.
 * @param nmType is a string with the NM type.
 * @return A NM103 string.
 */
fun createNM103Type(nmType)=(
    if(["UtlizationManagementOrganziation","PatientEventProvider","Submitter","Provider"] contains nmType)
        "NM103_" ++ nmType ++ "LastOrOrganizationName"
    else if (nmType == "Payer") "NM103_" ++ nmType ++ "Name"
    else 
        "NM103_" ++ nmType ++ "LastName"
)
 
/*
 * Function to create various NM1 segments based on the nmType 
 * and provided NM element values.
 * @param nmType is a string with the NM type.
 * @param nm101 is a string with the nm101 value.
 * @param nm102 is a string with the nm102 value.
 * @param nm103 is a string with the nm103 value.
 * @param nm104 is a string with the nm104 value.
 * @param nm105 is a string with the nm105 value.
 * @param nm106 is a string with the nm106 value.
 * @param nm107 is a string with the nm107 value.
 * @param nm108 is a string with the nm108 value.
 * @param nm109 is a string with the nm109 value.
 * @param A formatted NM1 segment object.
 */
  fun createNM1(nmType,nm101,nm102,nm103,nm104,nm105,nm106,nm107,nm108,nm109)=(
  			createNM1(nmType,"",nm101,nm102,nm103,nm104,nm105,nm106,nm107,nm108,nm109)
  )
/*
 * Function to create various NM1 segments based on the nmType 
 * and provided NM element values.
 * @param nmType is a string with the NM type.
 * @param transType is a string with the transaction type.
 * @param nm101 is a string with the nm101 value.
 * @param nm102 is a string with the nm102 value.
 * @param nm103 is a string with the nm103 value.
 * @param nm104 is a string with the nm104 value.
 * @param nm105 is a string with the nm105 value.
 * @param nm106 is a string with the nm106 value.
 * @param nm107 is a string with the nm107 value.
 * @param nm108 is a string with the nm108 value.
 * @param nm109 is a string with the nm109 value.
 * @param A formatted NM1 segment object.
 */  
  fun createNM1(nmType,transType,nm101,nm102,nm103,nm104,nm105,nm106,nm107,nm108,nm109)=(
    {
        "NM101_EntityIdentifierCode": nm101,
        "NM102_EntityTypeQualifier": nm102 ,
		(if (nmType == "Receiver") ("NM103_" ++ nmType++ "Name") 
		else if (nmType == "BillingProvider") "NM103_" ++ nmType ++ "LastOrOrganizationalName"
		else if (nmType == "Subscriber") "NM103_" ++ nmType ++ "LastName"
		else if (nmType == "Patient") "NM103_" ++ nmType ++ "LastName"
		else if (nmType == "Payer") "NM103_" ++ nmType ++ "Name"		
		else if(["UtlizationManagementOrganziation","PatientEventProvider","Submitter","Provider", "InformationSource", "InformationReceiver"] contains nmType) "NM103_" ++ nmType ++ "LastOrOrganizationName"
		else ("NM103_" ++ nmType ++ "LastName")): nm103,
		
        (if ((nmType == "Receiver") or  (nmType == "Payer")) ("NM104_"  ++ "NameFirst")
        else	("NM104_" ++ nmType ++ "FirstName")) : nm104,
        
        (if ((nmType == "Receiver") or (nmType == "Payer") ) ("NM105_" ++ "NameMiddle")
        else if ((nmType == "Submitter") or (nmType == "BillingProvider") or (nmType == "Subscriber") or (nmType == "Patient")) "NM105_" ++ nmType ++ "MiddleNameorInitial"	
        else  ("NM105_" ++ nmType ++ "MiddleName")) : nm105,
        
        ( if ((nmType == "BillingProvider")  or (nmType == "Submitter") or (nmType == "Receiver") or (nmType == "Patient") or (nmType == "Subscriber") or (nmType == "Payer") ) ("NM106_" ++ "NamePrefix")          
         //else if (nmType == "Submitter") "NM106_" ++ nmType ++ "PrefixName"
         else	("NM106_" ++ nmType ++ "NamePrefix")): nm106,

        ( if ((nmType == "BillingProvider") or (nmType == "Subscriber") or (nmType == "PatientEventProvider"))  ("NM107_" ++ nmType ++ "NameSuffix")
        	else if ( (nmType == "Receiver")  or (nmType == "Submitter") or (nmType == "Payer") ) ("NM107_NameSuffix")
        	else if (nmType == "Patient")  ("NM107_" ++ "PatientNameSuffix")
          //else ("NM107_" ++ "SuffixName")) : nm107,
          else ("NM107_" ++ "NameSuffix")) : nm107,     
        "NM108_IdentificationCodeQualifier" : nm108,
        (
           if (nmType == "InformationSource") "NM109_" ++ nmType ++ "PrimaryIdentifier"
           else if (nmType == "UtilizationManagementOrganization") "NM109_" ++ nmType ++ "UMOIdentifier"
           else if(nmType == "InformationReceiver") "NM109_InformationReceiverIdentificationNumber"
           else if(nmType == "Subscriber") "NM109_SubscriberPrimaryIdentifier"
           else if(nmType == "Receiver") "NM109_ReceiverPrimaryIdentifier"
           else if(nmType == "Patient" and transType == "837") "NM109_IdentificationCode"
           else if(nmType == "Patient" and transType == "275") "NM109_PatientPrimaryIdentifier"
           else if(nmType == "Payer") "NM109_PayerIdentifier"
           else if(nmType == "Dependent") "NM109_IdentificationCode"
           else if(nmType == "PatientEventProvider") "NM109_PatientEventProviderIdentifier"
           else if(!(["UtilizationManagementOrganization","Subscriber"] contains nmType)) "NM109_" ++ nmType ++ "Identifier"
           else "NM109_Identifier") : nm109
    }
)

/**
 * Creates an N3 address object with the provided 
 * arguments.
 * @param n3Type is a string with the N3 type.
 * @param n301 is the first address line.
 * @param n302 is the second address line.
 * @return A formatted N3 address object.
 */
fun createN3(n3Type,n301,n302)=(
    {
        ("N301_" ++ n3Type ++ "AddressLine") : n301,
        ("N302_" ++ n3Type ++ "AddressLine") : n302,
    }
)

/**
 * Creates an N4 address (city, state, zip) object with the provided 
 * arguments. **Limitation:** Doesn't support N407 - Assuming address is within 
 * United States of America, including its territories, or Canada 
 * @param n4Type is a string with the N$ type.
 * @param n401 is a string with the address city.
 * @param n402 is a string with the address state.
 * @param n403 is a string with the address postal code.
 * @param n404 is a string with the address country.
 * @param n407 is a string with the address district.
 * @return A formatted N4 address object.
 */
fun createN4(n4Type,n401,n402,n403,n404,n407)=(
    {
        ("N401_" ++ n4Type ++ "CityName") : n401,
        (if(n4Type == "BillingProvider") "N402_" ++ n4Type ++ "StateorProvinceCode" 
         else  if(n4Type != "Requester") "N402_" ++ n4Type ++ "StateCode"
         else "N402_RequesterStateOrProvinceCode"
        ) : n402,
        ("N403_" ++ n4Type ++ "PostalZoneOrZIPCode") : n403, 
        "N404_CountryCode" : n404,
        //"N407_CountrySubdivisionCode" : n407 // Assuming address is within United States of America, including its territories, or Canada
    }
)

/**
 * Creates a DTP (date time period) object with the provided 
 * arguments.
 * @param dtpType is a string with DTP type.
 * @param dtp01 is a string with DTP qualifier.
 * @param dtp02 is a string with DTP format qualifier.
 * @param dtp03 is a string with DTP value.
 * @return A formatted DTP object.
 */
fun createDTP(dtpType,dtp01,dtp02,dtp03)=(
    {
        "DTP01_DateTimeQualifier" : dtp01,
        "DTP02_DateTimePeriodFormatQualifier" : dtp02,
        ("DTP03_" ++ dtpType) : dtp03
    }
)

/**
 * Creates an REF segment with the provided arguments.
 * @param refType is a string with the provider code.
 * @param ref01 is a string with the reference identification qualifier.
 * @param ref02 is a reference with the ref02 element name being constructed with refType and REF02.
 * @return X12 formatted REF segment.
 */
fun createREF(refType,ref01,ref02)=(
	{
		"REF01_ReferenceIdentificationQualifier": ref01,
		(if (refType == 'BillingProvider')
		 ("REF02_" ++ refType ++ "TaxIdentificationNumber") : ref02
		else if (refType == 'Patient')
			("REF02_" ++ "PropertyAndCasualtyPatientIdentifier") : ref02		
		else
			("REF02_" ++ refType) : ref02
		)
	}
)

 /**
  * Function to lookup resource from bundle based on a resource's ID. 
  * Example: Pass in an Organization's ID and 
  * the response would be the Organization object from the bundle. 
  * @param inRequest - Input request to the API.
  * @param resourceId - ID of resource to be looked up.
  * @return Resource Object for the matching resource.
  * 
  */
fun getFHIRResource(inRequest,resourceId) = (
	(inRequest.entry filter($.resource.id == resourceId))[0]
)

/**
   * Function for HSD03 mapping for serviceRequest.
   * @oaram inRequest - This is the input request to the API.
   * @param reqRef - This is a reference object for a ServiceRequest/DeviceRequest/MedicationRequest.
   * @return Returns the appropriate resource object from the bundle.
   */

fun servicesRequest(inRequest,reqRef)=(
	inRequest.entry filter($.resource.resourceType == substringBefore(reqRef,"/"))
)

/**
 * Creates a PER contact information object with the provided 
 * arguments.
 * @param perType is a string with the PER type.
 * @param per01 is a string with the function code.
 * @param per02 is a string with the contact name.
 * @param per03 is a string with the number qualifier.
 * @param per04 is a string with the number value.
 * @param per05 is a string with the second number qualifier.
 * @param per06 is a string with the second number value.
 * @param per07 is a string with the third number qualifier.
 * @param per08 is a string with the third number value.
 * @return A formatted PER contact information object.
 */


fun createPER(perType,per01,per02,per03,per04,per05,per06,per07,per08)=({
    "PER01_ContactFunctionCode" : per01,
    ("PER02_" ++ perType ++ "ContactName") : per02,
    "PER03_CommunicationNumberQualifier" : if(!isEmpty(per04)) (per03) else "",
    (if ((perType == "BillingProvider") or (perType == "Submitter"))
    	("PER04_CommunicationNumber") : per04
    else if (perType == "Requester") ("PER04_" ++ perType ++ "ContactCommunicationNumber") : per04
    else if (perType == "PatientEventProvider") ("PER04_" ++ perType ++ "ContactCommunicationsNumber") : per04
    else ("PER04_" ++ perType ++ "CommunicationNumber") : per04
    ),
    "PER05_CommunicationNumberQualifier" : if(!isEmpty(per06)) (per05) else "",
    (if ((perType == "BillingProvider") or (perType == "Submitter")) ("PER06_CommunicationNumber") : per06
	else if (perType == "Requester") ("PER06_" ++ perType ++ "ContactCommunicationNumber") : per06
	else if (perType == "PatientEventProvider") ("PER06_" ++ perType ++ "ContactCommunicationsNumber") : per06
    else ("PER06_" ++ perType ++ "CommunicationNumber") : per06
    ),
    "PER07_CommunicationNumberQualifier" : if(!isEmpty(per08)) (per07) else "",
    (if ((perType == "BillingProvider") or (perType == "Submitter")) ("PER08_CommunicationNumber") : per08
	else if (perType == "Requester") ("PER08_" ++ perType ++ "CotactCommunicationNumber") : per08
	else if (perType == "PatientEventProvider") ("PER08_" ++ perType ++ "ContactCommunicationsNumber") : per08
    else ("PER08_" ++ perType ++ "CommunicationNumber") : per08
    ),
    
    }) 

/**
 * Creates a SV303 oral cavity designation object with the 
 * provided arguments.
 * @param inputData is a claim resource object.
 * @return A SV303 oral cavity object.
 */
fun createSV303(inputData)=({
    "SV301_OralCavityDesignationCode" : inputData.item[0].bodySite.coding[0].code,
    "SV301_OralCavityDesignationCode": inputData.item[0].subSite[0].coding[0].code
})

/**
 * Creates a SV3 dental service object with the provided 
 * arguments.
 * @param inputData is a claim resource object.
 * @return A formatted SV3 dental service object.
 */
fun createSV3(inputData)=({
    "SV304_OralCavityDesignation" : createSV303(inputData)
})

/**
 * Creates a SV1 professional service object with the 
 * provided arguments.
 * @param sv1_1 is a string with the EPSDT indicator.
 * @param sv1_2 is a string with product or service ID qualifier.
 * @param sv1_3 is a claim resource object.
 * @return A formatted SV1 professional service object.
 */
 
fun createSV1(sv101_01,sv101_02,sv101_03,sv101_04,sv101_05,sv101_06,sv101_07,sv101_08,sv102,sv103,sv104)=({
    "SV101_CompositeMedicalProcedureIdentifier": {
        "SV101_ProductOrServiceIDQualifier" : sv101_01,
        "SV102_ProcedureCode" : sv101_02,
        "SV103_ProcedureModifier" : sv101_03,
        "SV104_ProcedureModifier" : sv101_04,
        "SV105_ProcedureModifier" : sv101_05,
        "SV106_ProcedureModifier" : sv101_06,
        "SV107_Description" : sv101_07,
        "SV108_ProductOrServiceID" : sv101_08
        },
    "SV102_MonetaryAmount" : sv102,
    "SV103_UnitOrBasicOfMeasureCode" : sv103
})

/**
 * Creates an SBR contact information object with the provided 
 * arguments.
 * @param perType is a string with the PER type.
 * @param per01 is a string with the Contact Function code.
 * @param per02 is a string with the contact name.
 * @param per03 is a string with the Communication Number Qualifier.
 * @param per04 is a string with the Communication Number.
 * @param per05 is a string with the Communication Number Qualifier.
 * @param per09 is a string with the Contact Inquiry Reference.
 * @return A formatted PER contact information object.
 */
fun createSBR(perType,per01,per02,per03,per04,per05,per09)=({  
    "SBR01_PayerResponsibilitySequenceNumberCode" : per01,
    (if (perType == "SubscriberInformation") "SBR02_IndividualRelationshipCode" 
     else ("SBR02_" ++ perType ++ "IndividualRelationshipCode"))  : per02,
    (if (perType == "SubscriberInformation") "SBR03_SubscriberGrouporPolicyNumber"
     else ("SBR03_" ++ perType ++ "CommunicationNumberQualifier")) : per03,
    (if (perType == "SubscriberInformation") "SBR04_SubscriberGroupName" 
     else ("SBR04_" ++ perType ++ "SubscribeGrouporPolicyNumber")) : per04,
    (if (perType == "SubscriberInformation") "SBR05_InsuranceTypeCode" 
     else ("SBR05_" ++ perType ++ "InsuranceTypeCode")) : per05,
    (if (perType == "SubscriberInformation") "SBR09_ClaimFilingIndicatorCode" 
     else ("SBR09_" ++ perType ++ "ClaimFilingIndicatorCode")) : per09,
     
}) 

/**
 * Formats the provided gender string into a valid gender. 
 * String that can be cast to the gender value.
 * @param gndr is the string with gender type.
 * @return A required gender value.
 */
fun genderLookup(gndr) = (
    if (upper(gndr) == "MALE") "M"
    else if (upper(gndr) == "FEMALE") "F"
    else "U" 
)

/**
 * Creates a DMG demographic information object with the 
 * provided arguments.
 * @param dmgType is a string with the DMG type.
 * @param dmg01 is a string with the format qualifier.
 * @param dmg02 is a patient object.
 * @return A formatted DMG demographic information object.
 */
fun createDMG(dmgType,dmg01,dmg02,dmg03)=({
    (if(["Dependent","Subscriber"] contains dmgType) "DMG01_DateTimePeriodFormatQualifier" 
    	else  if(["Patient"] contains dmgType) "DMG01_DateTimePeriodFormatQualifier" 
        else "DMG01_DateTimePeriodQualifier"
    ) : dmg01,
    ("DMG02_" ++ dmgType ++ "BirthDate") : dmg02,
    ("DMG03_" ++ dmgType ++ "GenderCode") :genderLookup(dmg03)
})

/**
 * Formats the provided gender string into a valid gender.  
 * String that can be cast to the gender value.
 * @param gndr is the string with gender type.
 * @return A required gender value.
 */
fun payerSequenceNumberPayerLookup(code) = (
    if (code == 1) "P"
    else if (code == 2) "S"
    else if (code == 3) "T"
    else if (code == 4) "A"
    else if (code == 5) "B" 
    else if (code == 6) "C" 
    else if (code == 7) "D" 
    else if (code == 8) "E" 
    else if (code == 9) "F" 
    else if (code == 10) "G" 
    else if (code == 11) "H"      
    else "P" 
)
/**
 * Function to convert X12 relationship code to FHIR format.
 * @param inCode X12 relationship code.
 * @return FHIR format relationship code.
 */
fun relationCodeX12FHIR(inCode)=(
	inCode match {
		case "01" -> "spouse"
        case "18" -> "self"
		case "19" -> "child"
		else -> "other"
	}
)

/**
 * Function to convert X12 Gender codes to FHIR format.
 * @param inCode X12 Gender code.
 * @return FHIR format Gender code.
 */

fun genderLookupX12FHIR(inCode)=(
	inCode match {
		case "U" -> "unknown"
		case "F" -> "female"
		case "M" -> "male"
		else -> "unknown"
	}
)

/**
 * Function to convert X12 telecom codes to FHIR format.
 * @param inCode X12 relationship code.
 * @return FHIR format relationship code.
 */
fun telecomTypeX12FHIR(inCode)=(
	inCode match {
		case "TE" -> "phone"
		case "FX" -> "fax"
		case "EM" -> "email"
		case "UR" -> "url"
		else -> inCode
	}
)

/**
 * Function to create a telecom object for the FHIR resource using the X12 PER segment.
 * @param perSegment PER segment from X12 message.
 * @return telecom object formatted per FHIR specification.
 */
 
fun createTelecom(perSegment)=(
	[
		{
			"system" : telecomTypeX12FHIR(perSegment."PER03_CommunicationNumberQualifier") ,
			"value"	: perSegment."PER04_Utilization ManagementOrganizationUMOContactCommunicationNumber"
		},
		({
			"system" : telecomTypeX12FHIR(perSegment."PER05_CommunicationNumberQualifier") ,
			"value"	: perSegment."PER06_Utilization ManagementOrganizationUMOContactCommunicationNumber"			
		}) if(! isEmpty(perSegment."PER05_CommunicationNumberQualifier")),
		({
			"system" : telecomTypeX12FHIR(perSegment."PER07_CommunicationNumberQualifier") ,
			"value"	: perSegment."PER08_Utilization ManagementOrganizationUMOContactCommunicationNumber"			
		}) if(! isEmpty(perSegment."PER07_CommunicationNumberQualifier")),
		
	]
)

 

/**
 * Function to fetch element from segment with the key name prefix.
 * @param segment from which to extract the element value.   
 * @selector is the prefix of the element to be fetched.
 * 
 */
fun pluckValuefromSeg(segment,selector)=(
    if(! isEmpty(segment))
    (segment filterObject((value, key, index) -> key contains selector) pluck($))[0]
    else 
    ""
)

/**
 * Function to create a PWK segment using the provided parameters.
 * @param pwkType Describes the PWK segment being mapped.
 * @param pwk01 Report Type code.
 * @param pwk02 Report Transmission code.
 * @param pwk05 Attachment control number.
 * @param pwk06 Attachment description.
 * @return X12 formatted BIN segment.
 */
fun createPWK(pwkType,pwk01,pwk02,pwk05,pwk06)=(
	[{
		"PWK01_AttachmentReportTypeCode": pwk01, // First PWK has 77 as PWK01, there will be a maximum of 9 more PWK repetitions based on claimResource.item.itemSequence( and supportingInfo)
		"PWK02_ReportTransmissionCode" : pwk02,
		"PWK05_AttachmentControlNumber" : pwk05,
		"PWK06_AttachmentDescription" : pwk06
	}]
)

/**
 * Function to create an MSG segment using the provided parameters.
 * @param msgType Describes the MSG segment being mapped.
 * @param msg01 Message to be written to MSG segment.
 * @return X12 formatted MSG segment.
 */
fun createMSG(msgType,msg01)=(
	{
		"MSG01_FreeFormMessageText" : msg01	
	}
)

/**
 * Function to translate X12 benefit type to FHIR format.
 * @param x12BenefitType - X12 benefit type.
 * @return FHIR benefit format benefit type.
 */
fun benefitTypeLookup(x12BenefitType)=(
    x12BenefitType match {
        case "B" -> "copay"
        case "C" -> "deductible"
        else -> ""
    }
)

/**
 * Creates a PRV provider information object with the 
 * provided arguments.
 * @param prvType describes the provider type being mapped. Not in use now, but could be used if multiple PRV segments with varying fields names are required.
 * @param prv01 is a string with the provider code.
 * @param prv02 is a string with the reference identification qualifier.
 * @param prv03 is a string with the provider taxonomy code.
 * @return X12 formatted PRV segment.
 */
fun createPRV(prvType,prv01,prv02,prv03) = (
	{
		"PRV01_ProviderCode" : prv01,
		"PRV02_ReferenceIdentificationQualifier" : prv02,
		"PRV03_ProviderTaxonomyCode" : prv03
	}
)

/**
 * Function to convert term type  from X12 to FHIR.
 * @param x12TermCode - X12 term type.
 * @return FHIR format term type.
 */
fun termTypeLookup(x12TermCode)=(
	if(x12TermCode == "32") "lifetime"
	else if(["6","27"] contains x12TermCode) "day"
	else if(["22","23"] contains x12TermCode) "annual"
	else ""
)

/**
 * Function to create coverage json from incoming EDI Submit Response
 * with parameters relationshipCodeSystem,subscriber,subscriberId,dependentId,relationshipCode,payerId.
 * @param relationshipCodeSystem Coverage Relationship Code System from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse. 
 * @param subscriber  is the subscriber ID from the X12 Submit Response.
 * @param subscriberId is the dependent primary identifier.
 * @param dependentId is the dependent ID from the X12 Submit Response.
 * @param relationshipCode is the relationship between the dependent and subscriber from INS segment in X12 Submit Response.
 * @param payerId is the payer ID in the X12 Submit Response.
 * @return - FHIR formatted Coverage object.
 */
fun createCoveragePAS(relationshipCodeSystem,coverageId,subscriber,subscriberId,dependentId,relationshipCode,payerId)=(
	{
				"resourceType" : "Coverage",
				"id" : coverageId,
				"status" : "active",
				("subscriber" : {
					"reference" : "Patient/" ++ subscriber
				}) if(dependentId != subscriber),
				("subscriberId" : { 
					value: subscriber
				}) if (!isEmpty(subscriberId)),
				"beneficiary" : {
					"reference" : "Patient/" ++ dependentId
				},
				"relationship" : {
					"coding" : [
						{
							"code" : relationCodeX12FHIR(relationshipCode),
							"system" : relationshipCodeSystem
						}
					]
				},
				"payor" : [{
					"reference" : "Organization/" ++ payerId
				}]
			}
)

/**
 * Function to create coverage json from incoming EDI Submit Response.
 * with parameters relationshipCodeSystem,subscriber,subscriberId,dependentId,relationshipCode,payerId.
 * @param relationshipCodeSystem Coverage Relationship Code System from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.
 * @coverageId ID for coverage resource being created.
 * @param subscriber  is the subscriber ID from the X12 Submit Response.
 * @param subscriberId is the dependent primary identifier.
 * @param dependentId is the dependent ID from the X12  Submit Response.
 * @param relationshipCode is the relationship between the dependent and subscriber from INS segment in X12 Submit Response.
 * @param payerId is the payer ID in the X12 Submit Response.
 * @return - FHIR formatted Coverage object.
 */
fun createCoverage(relationshipCodeSystem,coverageId,subscriberId,dependentId,subscriber,relationshipCode,payerId)=(
	{
				"resourceType" : "Coverage",
                "id" : coverageId,
				"status" : "active",
				("subscriber" : {
					"reference" : "Patient/" ++ subscriberId
				}) if(dependentId != subscriberId),
				("subscriberId" : { 
					value: subscriber
				}) if (!isEmpty(subscriberId)),
				"beneficiary" : {
					"reference" : "Patient/" ++ dependentId
				},
				"relationship" : {
					"coding" : [
						{
							"code" : relationCodeX12FHIR(relationshipCode),
							"system" : relationshipCodeSystem
						}
					]
				},
				"payor" : [{
					"reference" : "Organization/" ++ payerId
				}]
			}
)
/**
 * Function to create patient(subscriber/dependent) json from incoming EDI Submit Response.
 * with parameters identifierSystem,identificationCode,patientType,patientId,nm1Segment,n3Segment,n4Segment,dmgSegment.
 * @param identifierSystem - Patient Identifier system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.
 * @param identificationCode - Patient Identifier code from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.
 * @param patientType - Identify if patient is Subscriber or Dependent.
 * @param patientId - Identifier for the patient.
 * @param nm1Segment - X12's NM1 segment for subscriber/dependent.
 * @param n3Segment - X12's N3 segment for subscriber/dependent.
 * @param n4Segment - X12's N4 segment for subscriber/dependent.
 * @param dmgSegment - X12's DMG segment for subscriber/dependent.
 * @return - FHIR formatted Patient object.
 */
fun createPatient(identifierSystem,identificationCode,patientType,patientId,nm1Segment,n3Segment,n4Segment,dmgSegment)=(
	{
			"resourceType" : "Patient",
			"id" : patientId,
			(if(patientType == "Subscriber") {
				"identifier" : [
				{
					"type": {"text": identifierSystem},
					//"code" : identificationCode,
					"value" : nm1Segment."NM109_SubscriberPrimaryIdentifier"

				}
			],
			"name" : [
				{
				"use" : "official",
				"family" : nm1Segment."NM103_SubscriberLastName",
				"given" : ((nm1Segment."NM104_SubscriberFirstName" default "") ++ "|" ++ (nm1Segment."NM105_SubscriberMiddleNameOrInitial" default "")) splitBy("|"),
				"prefix" : [nm1Segment."NM105_SubscriberNamePrefix"],
				"suffix" : [nm1Segment."NM106_SubscriberNameSuffix"],
			}
			],//End Name
			"address" : [
				{
					"use" : "home",
					"line" : ((n3Segment."N301_SubscriberAddressLine" default "") ++ "|" ++ (n3Segment."N302_SubscriberAddressLine" default "")) splitBy("|"),
					"city" : n4Segment."N401_SubscriberCityName",
					"state" : n4Segment."N402_SubscriberStateCode",
					"postalCode" : n4Segment."N403_SubscriberPostalZoneOrZIPCode",
				}
			],
			"birthDate": formatDate(dmgSegment."DMG02_SubscriberBirthDate"),
			"gender" : genderLookupX12FHIR(dmgSegment."DMG03_SubscriberGenderCode")
			}
			else {
				"identifier" : [
				{
					"system" : identifierSystem,
					"code" : identificationCode,
					"value" : nm1Segment."NM109_DependentPrimaryIdentifier"

				}
			],
			"name" : [
				{
				"use" : "official",
				"family" : nm1Segment."NM103_DependentLastName",
				"given" : ((nm1Segment."NM104_DependentFirstName" default "") ++ "|" ++ (nm1Segment."NM105_DependentMiddleNameOrInitial" default "")) splitBy("|"),
				"prefix" : [nm1Segment."NM105_DependentNamePrefix"],
				"suffix" : [nm1Segment."NM106_DependentNameSuffix"],
			}
			],//End Name
			"address" : [
				{
					"use" : "home",
					"line" : ((n3Segment."N301_DependentAddressLine" default "") ++ "|" ++ (n3Segment."N302_DependentAddressLine" default "")) splitBy("|"),
					"city" : n4Segment."N401_DependentCityName",
					"state" : n4Segment."N402_DependentStateCode",
					"postalCode" : n4Segment."N403_DependentPostalZoneOrZIPCode",
				}
			],
			"birthDate" : dmgSegment."DMG02_DependentBirthDate",
			"gender" : genderLookupX12FHIR(dmgSegment."DMG03_DependentGenderCode")
			})
		}
)


fun createEncounter(loop2000E) = (
    {
            "period": {
                "start": substringBefore(loop2000E."DTP_EventDate"."DTP03_ProposedOrActualEventDate","-") as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' } ++ "T00:00:00+00:00",
               "end" : substringAfter(loop2000E."DTP_EventDate"."DTP03_ProposedOrActualEventDate","-") as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' } ++ "T00:00:00+00:00"
            },
            "id": "enc-1",
            "type": [
                {
                    "coding": [
                        {
                            "system": "api.availity.com/serviceTypes",
                            "code": "2"
                        }
                    ],
                    "text": "Surgical"
                }
            ],
            "resourceType": "Encounter"
        }
    )

fun createHeader(practitionerId) = (
	{
                "extension": [
                    {
                        "valueString": "STAGE",
                        "url": "api.availity.com/environments"
                    }
                ],
                "sender": {
                    "reference": "Practitioner/" ++ practitionerId
                },
                "id": "21a7a051-910b-419c-9d2b-91c4790f25da",
                "source": {
                    "endpoint": "source.system.uri",
                    "name": "Epic EHR"
                },
                "eventCoding": {
                    "system": "Epic EHR",
                    "code": "SaveAuthorizationRequest"
                },
                "resourceType": "MessageHeader"
            }
)
fun createCondition(dxId,dxCode,memberId) = (
	{
                "identifier": [
                    {
                        "value": "1"
                    }
                ],
                "code": {
                    "coding": [
                        {
                            "system": "ICD-10",
                            "code": dxCode,
                            "display": "Diagnosis"
                        }
                    ],
                    "text": "Diagnosis"
                },
                "verificationStatus": {
                    "text": "confirmed"
                },
                "subject": {
                    "reference": "Patient/" ++ memberId
                },
                "id": dxId,
                "resourceType": "Condition"
            }
)

fun createProcedure(pxId,loop2000E) = ({
                "extension": [
                    {
                        "valueString": "Procedure",
                        "url": "http://hit.humana.com/UnitTypes"
                    },
                    {
                    	"url": "QuantityUnits",
                    	"valueString": loop2000E."2000F_Loop"[0]."SV1_ProfessionalService".SV104_ServiceUnitCount
                    	}
                ],
                "code": {
                    "coding": [
                        {
                            "system": "CPT",
                            "code": loop2000E."2000F_Loop"[0]."SV1_ProfessionalService"."SV101_CompositeMedicalProcedureIdentifier"."SV102_ProcedureCode",
                            "display": "Procedure"
                        }
                    ],
                    "text": "Procedure"
                },
                "id": pxId,
                "performedPeriod": {
                    "start": substringBefore(loop2000E."DTP_EventDate"."DTP03_ProposedOrActualEventDate","-") as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' } ++ "T00:00:00+00:00",
              		"end" : substringAfter(loop2000E."DTP_EventDate"."DTP03_ProposedOrActualEventDate","-") as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' } ++ "T00:00:00+00:00"
            	},
                "resourceType": "Procedure",
                "status": "preparation"
            })
            
fun createLocation(loop2000E,posCode) = (
	{
                "identifier": [
                    {
                        "type": {
                            "text": "NPI"
                        },
                        "value": ((loop2000E."2010EA_Loop" filter ((item) -> item.NM1_PatientEventProviderName.NM101_EntityIdentifierCode == "77"))[0].NM1_PatientEventProviderName.NM109_PatientEventProviderIdentifier) default 9999999999
                }
                ],
                "name": "Location",
                "physicalType": {
                    "coding": [
                        {
                            "system": "https://api.availity.com/placeOfService",
                            "code": posCode default 11,
                            "display": "POS"
                        }
                    ],
                    "text": "Place of Service"
                },
                "id": "location-1",
                "resourceType": "Location"
            }
	
	
)
/**
 * Function to create patient(subscriber/dependent) json from incoming EDI Submit Response
 * with parameters identifierSystem,identificationCode,patientType,patientId,nm1Segment,n3Segment,n4Segment,dmgSegment.
 * @param identifierSystem - Patient Identifier system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.
 * @param identificationCode - Patient Identifier code from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.
 * @param patientId - Identifier for the patient.
 * @param nm1Segment - NM1 segment for subscriber/dependent.
 * @param n3Segment - N3 segment for subscriber/dependent.
 * @param n4Segment - N4 segment for subscriber/dependent.
 * @param dmgSegment - DMG segment for subscriber/dependent.
 * @return - FHIR formatted Patient object.
 */
fun createPatient(identifierSystem,identificationCode,patientId,nm1Segment,n3Segment,n4Segment,dmgSegment)=(
	{
			"resourceType" : "Patient",
			"id" : patientId,
			"identifier" : [
				"type" : {
					"coding" : [
						{
							"system" : identifierSystem,
							"code" : identificationCode,							
						}
						]		
					},
				"value" : pluckValuefromSeg(nm1Segment,"NM109_")
			],
			"name" : [
				{
				"use" : "official",
				"family" : pluckValuefromSeg(nm1Segment,"NM103_"),
				"given" : ((pluckValuefromSeg(nm1Segment,"NM104_") default "") ++ "|" ++ (pluckValuefromSeg(nm1Segment,"NM105_") default "")) splitBy("|"),
				"prefix" : [pluckValuefromSeg(nm1Segment,"NM106_")],
				"suffix" : [pluckValuefromSeg(nm1Segment,"NM107_")],
			}
			],//End Name
			"address" : [
				{
					"use" : "home",
					"line" : ((pluckValuefromSeg(n3Segment,"N301_") default "") ++ "|" ++ (pluckValuefromSeg(n3Segment,"N302_") default "")) splitBy("|"),
					"city" : pluckValuefromSeg(n4Segment,"N401_"),
					"state" : pluckValuefromSeg(n4Segment,"N402_"),
					"postalCode" : pluckValuefromSeg(n4Segment,"N403_"),
				}
			],
			"birthDate" : pluckValuefromSeg(dmgSegment,"DMG02_") as Date {"format" : "yyyyMMdd"} as Date,
			"gender" : genderLookupX12FHIR(pluckValuefromSeg(dmgSegment,"DMG03_"))
}
)
/**
 * Function to create Organization json from incoming EDI Submit Response
 * with parameters identifierSystem,nm1Segment,perSegment,codingSystem,payorId.
 * @param identifierSystem is Organization Identifier system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.  
 * @param nm1Segment is X12's NM1 segment for practitioner.
 * @param perSegment is X12's PER segment for practitioner.
 * @codingSystem is the nm1 coding system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.
 * @payorId - payerId is the payer ID in the X12 Submit Response.
 * @return - FHIR formatted Practitioner object.
 */
fun createOrganization(identifierSystem,nm1Segment,perSegment,codingSystem,payorId)=(
	{
				"resourceType" : "Organization",
				"id" : payorId,
				"identifier" : [
					{
						"system" : identifierSystem,
						"value" : nm1Segment."NM109_UtilizationManagementOrganizationUMOIdentifier"
   
					}
				],
				"active" : true,
				"name" : nm1Segment."NM103_UtilizationManagementOrganizationUMOLastOrOrganizationName",
				"type" : [{
					"coding" : [
						{
							"code" : nm1Segment."NM108_IdentificationCodeQualifier",
							"system" : codingSystem
						}
					]
				}],
				"telecom" : createTelecom(perSegment)
			}
)
/**
 * Function to create Organization json from incoming non-EDI Submit Response
 * with parameters identifierSystem,nm1Segment,perSegment,codingSystem,payorId.
 * @param identifierSystem is Organization Identifier system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse. 
 * @param nm1Segment is X12's NM1 segment for practitioner.
 * @param perSegment is X12's PER segment for practitioner.
 * @codingSystem is the nm1 coding system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse.
 * @orgId - payerId is the payer ID in the X12 Submit Response.
 * @orgType - Type of 2100A Loop to be used for creating the Org.
 * @return - FHIR formatted Practitioner object.
 */
fun createOrganization(identifierSystem,nm1Segment,n3Segment,n4Segment,perSegment,codingSystem,orgId,orgType)=(
	{
				"resourceType" : "Organization",
				"id" : orgId,
				"identifier" : [
					{
						"system" : identifierSystem,
						"value" : pluckValuefromSeg(nm1Segment,("NM109_" ++ orgType))
   
					}
				],
				"active" : true,
				"name" : pluckValuefromSeg(nm1Segment,("NM103_" ++ orgType)),
				"type" : [{
					"coding" : [
						{
							"code" : nm1Segment."NM108_IdentificationCodeQualifier",
							"system" : codingSystem
						}
					]
				}],
			"address" : [
				({
					"use" : "work",
					"line" : ((pluckValuefromSeg(n3Segment,"N301_") default "") ++ "|" ++ (pluckValuefromSeg(n3Segment,"N302_") default "")) splitBy("|"),
					"city" : pluckValuefromSeg(n4Segment,"N401_"),
					"state" : pluckValuefromSeg(n4Segment,"N402_"),
					"postalCode" : pluckValuefromSeg(n4Segment,"N403_"),
				}) if((! isEmpty(n3Segment)) or (! isEmpty(n4Segment)))
			],
				("telecom" : createTelecom(perSegment)) if(orgType == "InformationSource")
			}
)

/**
 * Function to create practitioner json from incoming EDI Submit Response
 * with parameters identifierSystem,nm1Segment,n3Segment,n4Segment,perSegment.
 * @param identifierSystem - Patient Identifier system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse. 
 * @param nm1Segment - X12's NM1 segment for practitioner.
 * @param n3Segment - X12's N3 segment for practitioner.
 * @param n4Segment - X12's N4 segment for practitioner.
 * @param perSegment - X12's PER segment for practitioner.
 * @return - FHIR formatted Practitioner object.
 */
fun createPractitioner(practitionerId, identifierSystem,nm1Segment,n3Segment,n4Segment,perSegment)=(
	{
			"resourceType" : "Practitioner",
			"id" : practitionerId,
			"identifier" : [
				{
					"type" : {"text":identifierSystem},
					"value" : nm1Segment."NM109_PatientEventProviderIdentifier"
				}],
			"name" : [
				{
					"use" : "official",
					"family" : nm1Segment."NM103_PatientEventProviderLastOrOrganizationName",
					"given" : ((nm1Segment."NM104_PatientEventProviderFirstName" default "") ++ "|" ++ (nm1Segment."NM105_PatientEventProviderMiddleName" default "")) splitBy("|"),
					"prefix" : [nm1Segment."NM106_PatientEventProviderNamePrefix"],
					"suffix" : [nm1Segment."NM107_PatientEventProviderNameSuffix"]
				}
			],
			//"telecom" : [
				//({
				//	"system" : if(perSegment."PER03_CommunicationNumberQualifier" == "TE") "phone" else "email",
				//	"value" : perSegment."PER04_PatientEventProviderContactCommunicationsNumber"
				//}) if(! isEmpty(perSegment."PER04_PatientEventProviderContactCommunicationsNumber")),
				//({
				//	"system" : if(perSegment."PER05_CommunicationNumberQualifier" == "EM") "email" else "phone",
				//	"value" : perSegment."PER06_PatientEventProviderContactCommunicationsNumber"					
				//}) if(! isEmpty(perSegment."PER06_PatientEventProviderContactCommunicationsNumber"))
				//{
				//	"system": "email",
				//	"value": "daniel.frier@coherehealth.com"
				//}
			//],
			"address" : [
				({
					"use" : "work",
					"line" : ((n3Segment.N301_PatientEventProviderAddressLine default "") ++ "|" ++ (n3Segment.N302_PatientEventProviderAddressLine default "")) splitBy("|"),
					"city" : n4Segment.N401_PatientEventProviderCityName,
					"state" : n4Segment.N402_PatientEventProviderStateCode,
					"postalCode" : n4Segment.N403_PatientEventProviderPostalZoneOrZIPCode,
				}) if((! isEmpty(n3Segment)) or (! isEmpty(n4Segment)))
			]
		}
)

/**
 * Function to create practitioner json from incoming EDI Submit Response
 * with parameters identifierSystem,nm1Segment,n3Segment,n4Segment,perSegment.
 * @param practitionerId - ID of the practitioner to be created.
 * @param identifierSystem - Patient Identifier system from /src/main/resources/dwl/x12Util/fhirConstants.dwl's SubmitResponse. 
 * @param nm1Segment - X12's NM1 segment for practitioner.
 * @param n3Segment - X12's N3 segment for practitioner.
 * @param n4Segment - X12's N4 segment for practitioner.
 * @return - FHIR formatted Practitioner object.
 */
fun createPractitioner(practitionerId,identifierSystem,nm1Segment,n3Segment,n4Segment)=(
	{
			"resourceType" : "Practitioner",
			"id" : practitionerId,
			"identifier" : [
				{
					"type" : {"text":identifierSystem},
					"value" : nm1Segment."NM109_PatientEventProviderIdentifier"
				}],
			"name" : [
				{
					"use" : "official",
					"family" : pluckValuefromSeg(nm1Segment,"NM103_"),
					"given" : ((pluckValuefromSeg(nm1Segment,"NM104_") default "") ++ "|" ++ (pluckValuefromSeg(nm1Segment,"NM105_") default "")) splitBy("|"),
					"prefix" : [pluckValuefromSeg(nm1Segment,"NM106_")],
					"suffix" : [pluckValuefromSeg(nm1Segment,"NM107_")]
				}
			],
			"address" : [
				({
					"use" : "work",
					"line" : ((pluckValuefromSeg(n3Segment,"N301_") default "") ++ "|" ++ (pluckValuefromSeg(n3Segment,"N302_") default "")) splitBy("|"),
					"city" : pluckValuefromSeg(n4Segment,"N401_"),
					"state" : pluckValuefromSeg(n4Segment,"N402_"),
					"postalCode" : pluckValuefromSeg(n4Segment,"N403_"),
				}) if((! isEmpty(n3Segment)) or (! isEmpty(n4Segment)))
			],
			//"telecom" : [
			//	({
			//		"system" : if(perSegment."PER03_CommunicationNumberQualifier" == "TE") "phone" else "email",
			//		"value" : perSegment."PER04_PatientEventProviderContactCommunicationsNumber"
			//	}) if(! isEmpty(perSegment."PER04_PatientEventProviderContactCommunicationsNumber")),
			//	({
			//		"system" : if(perSegment."PER05_CommunicationNumberQualifier" == "EM") "email" else "phone",
			//		"value" : perSegment."PER06_PatientEventProviderContactCommunicationsNumber"					
			//	}) if(! isEmpty(perSegment."PER06_PatientEventProviderContactCommunicationsNumber"))
				//{
				//	"system": "email",
				//	"value": "daniel.frier@coherehealth.com"
				//}
			//],
		}
)

/**
 * Function to create item array within CoverageEligibilityResponse.
 * @param item - item is the input x12's EB segment.
 * @param itemCategorySystem - system identifier for item's category.
 * @return - An array of item with benefit and other details.
 */
fun createResponseItem(item,fhirConstants) = (
    "tempItem" : flatten((item.*EB_SubscriberEligibilityOrBenefitInformation map(eb,ebIdx) -> {
        "tempEb" : eb.EB03_ServiceTypeCode map(servType,servIdx) -> {
            "category" : {
                "coding" : [{
	                    "code" : servType,
	                    "system" : fhirConstants.coverageEligibilityResponse.itemCategorySystem
                	}]
            },
            "productOrService" : eb.EB13_CompositeMedicalProcedureIdentifier.EB02_ProcedureCode,
            "unit" : {
                "coding" : [{
                	"system" : fhirConstants.coverageEligibilityResponse.unitSystem,
                    "code" : if(eb.EB02_BenefitCoverageLevelCode == "IND") "individual"
                             else if(eb.EB02_BenefitCoverageLevelCode == "FAM") "family"
                             else ""
                }]
            },
            "term" : {
            	"coding" : [{
            		"system" : fhirConstants.coverageEligibilityResponse.termSystem,
            		"code" : termTypeLookup(eb.EB06_TimePeriodQualifier)	
            	}]
            },
            "network" : {
            	"coding" : [
            		{
            			"system" : fhirConstants.coverageEligibilityResponse.networkSystem,
            			"code" : if(eb.EB12_InPlanNetworkIndicator == "Y") "in"
                        		 else if(eb.EB12_InPlanNetworkIndicator == "N") "out"
                        		 else ""			
            		}
            	]
            },
            "benefit" : [
                {
                    "type" : {
                        "coding" : [{
                        	"system" : fhirConstants.coverageEligibilityResponse.benefitTypeSystem,
                            "code" : if(eb.EB01_EligibilityOrBenefitInformation == "B") "copay"
                                     else if (eb.EB01_EligibilityOrBenefitInformation == "C") "deductible"
                                     else ""
                        }]
                    },
                    "allowedUnsignedInt" : eb.EB07_BenefitAmount
                }
            ]
        }
    }).*tempEb)  
)

/**
 * Function to fetch the benefits loop based on the patient being a subscriber or a dependent.
 * @param dependentPatientExists - Boolean indicating if the patient is the subscriber or dependent.
 * @param benefitsLoop - X12 271's 2100C or 2100D based on the patient being a dependent or subscriber.
 */
fun fetchBenefitLoop(dependentPatientExists,benefitsLoop) = (
	if(dependentPatientExists) benefitsLoop."2110D_Loop"
	else benefitsLoop."2110C_Loop"
)

/**
 * Function to create CoverageEligibilityResponse.
 * @param fhirConstants - List of constants used to for identifiers and system.
 * @param covRespId - Unique ID for CoverageEligibilityResponse.
 * @param bhtSegment - BHT segment from X12 271 input.
 * @param patientId - the patient's ID (either subscriber or dependent) from X12 271 2100C Loop.
 * @param requesterType - Type of the party sending the CoverageEligibilityRequest can be either Practitioner or Organization.
 * @param requestorId - ID of the sender of the CoverageEligibilityRequest.
 * @param outcome - Outcome of the 271 X12 based on AAA segment.
 * @param payorId - ID of the Information Source, which is the payer in this case.
 * @param coverageId - ID of the Coverage created as part of the bundle.
 * @param benefitPeriod - Benefit begin and end date.
 * @param benefitsLoop - 2110D or 2110C loop of the X12 271 based on the patient.
 * @param dependentPatientExists - Boolean indicating if the patient is the subscriber or dependent.
 */
fun createCoverageEligibilityResponse(fhirConstants,covRespId,bhtSegment,patientId,requesterType,requestorId,outcome,payorId,coverageId,benefitPeriod,benefitsLoop,dependentPatientExists)=(
    {
        "resourceType" : "CoverageEligibilityResponse",
        "id" : covRespId,
        "identifier" : [
            {
                "system" : fhirConstants.coverageEligibilityResponse.identificationSystem,
                "value" : bhtSegment.BHT03_SubmitterTransactionIdentifier
            }
        ],
        "status" : "active",
        "purpose" : ["auth-requirements"],
        "patient" : {
        		"reference" : "Patient/" ++ patientId
        },
        "serviced" : "",
        "created" : bhtSegment.BHT04_TransactionSetCreationDate,
        "requestor" : {
        	"reference" : if(requesterType == "1") "Practitioner/" ++ requestorId
        				  else "Organization/" ++ requestorId
        },
        "request" : {
        	"reference" : "CoverageEligibilityRequest/" ++ bhtSegment.BHT03_SubmitterTransactionIdentifier
        },
        "outcome" : if(outcome) "complete" else "error",
        "insurer" : {
        	"reference" : "Organization/" ++ payorId
        },
        "inforce" : (fetchBenefitLoop(dependentPatientExists,benefitsLoop)."EB_SubscriberEligibilityOrBenefitInformation"."EB01_EligibilityOrBenefitInformation" default []) contains "1", 
        "insurance" : [
            {
                "coverage" : {
                	"reference" : "Coverage/" ++ coverageId
                },
                "benefitPeriod" : benefitPeriod,
                //Filtering out type L(unsupported, see mapping document for details) 
                "item" : flatten((fetchBenefitLoop(dependentPatientExists,benefitsLoop) map(item,ItemIdx) -> {
                    (createResponseItem(item,fhirConstants))
                }).*tempItem)

            }
        ]
    }
)

/**
 * Formats the provided coverage relationship string into a valid relationship string that 
 * can be cast to the relationship value. **Limitation:** Only support FHIR relations - Spouse, 
 * Child, and Other Relationship. 
 *  **Limitation:** Only support FHIR relations - Spouse, Child, and Other Relationship.
 * @param relateship is the string with gender type.
 * @return A required gender value.
 */
fun RelationshipLookup(relateship) = (
    if (upper(relateship) == "spouse") "01"
    else if (upper(relateship) == "child") "19"
    else "G8" //Other Relationship 
)

/**
 * Function to create an INS segment with the provided input parameters.
 * @param insType - INS segment for patient(subscriber or dependent).
 * @param ins01 - insured indicator.
 * @param ins02 - relationship to insured.
 * @return An X12 formatted INS segment.
 */
fun createINS(insType,ins01,ins02) = (
 	{
 		"INS01_InsuredIndicator" : ins01,
 		"INS02_IndividualRelationshipCode" : ins02
 	}
 )

/**
 * Creates an INS object with the provided 
 * arguments.
 * @param ins01 is an Insured Indicator value.
 * @param inso2 is value for Individual Relationship code.
 * @param ins08 is a string with Employment Status code.
 * @return X12 formatted INS segment.
 */
fun createINS(insType,ins01,ins02,ins08)=({
    "INS01_InsuredIndicator" : ins01,
    "INS02_IndividualRelationshipCode": if(insType != "Subscriber") insuredRelationLookup(ins02) else ins02,
    "INS08_EmploymentStatusCode": ins08
})

/**
 * Formats the provided relationship code into a valid  
 * code that can be cast to relationship code.
 * @param relCode is the code with relationship type.
 * @return A required relationship code.
 */
fun insuredRelationLookup(relCode)=(
    if (upper(relCode) == "SELF") "18"
    else if(["PARENT","COMMON","OTHER","INJURED"] contains upper(relCode) ) "G8"
    else if(upper(relCode) == "CHILD") "19"
    else if(upper(relCode) == "SPOUSE") "01"
    else "G8" 
)
/**
 * Creates a BIN object with the provided 
 * arguments.
 * @param bin01 is a Binary Data value.
 * @return X12 formatted BIN segment.
 */
fun createBIN(bin01) = {
    "BIN01_BinaryDataLengthNumber": sizeOf(bin01),
    "BIN02_BinaryData": bin01
}

/**
 * Creates a EFI (Electronic Format Identification) object with the provided 
 * arguments.
 * @param efi01 is a Security Level code.
 * @return X12 formatted EFI segment.
 */
fun createEFI(efi01) = {
    "EFI01_SecurityLevelCode": efi01
}

/**
 * Creates a CAT (Category Of Patient Information Service) object with the provided arguments.
 * @param cat01 is a Attachment Report Type code.
 * @param cat02 is a Attachment Information Format code.
 * @return X12 formatted CAT segment.
 */
fun createCAT(cat01,cat02) = {
    "CAT01_AttachmentReportTypeCode": cat01,
    "CAT02_AttachmentInformationFormatCode": cat02
}

/**
 * Creates an LX object with the provided arguments.
 * @param lx01 is a Assigned Number.
 * @return X12 formatted LX segment.
 */
fun createLX(lx01) = {
    "LX01_AssignedNumber": lx01
}
/**
 * Creates an NX1 object with the provided arguments.
 * @param nx1_01 is a Entity Identifier code.
 * @return X12 formatted NX1 segment.
 */
fun createNX1(nx1_01) = {
    "NX101_EntityIdentifierCode": nx1_01
}

/**
 * Function to convert provider type from FHIR to X12 format.
 * @param inCode FHIR format lookup value.
 * @return X12 format qualifier for provider.
 */
fun providerTypeLookup(inCode)=(
    if(lower(inCode) == "primary") "71"
    else if(lower(inCode) == "assist") "73"
    else if(lower(inCode) == "other") "OT"
    else ""
)
/**
 * Function to convert PER segments from FHIR format to X12 format.
 * @param inCode - Telecom system in FHIR.
 * @return X12 format communication type qualifier.
 */
fun lookupPERCommType(inCode)=(
	inCode match {
        			case commType if(["phone","pager","sms"] contains commType) -> "TE"
        			case "email" -> "EM"
        			case "fax" -> "FX"
        			case "url" -> "UR"
        			else -> inCode //return input value
        			
        		}
)

/**
 * Function to lookup extension using URL comparison and return the appropriate code based on type of extension.
 * @param extension - Array of extensions to be filtered.
 * @param valueType - Defines whether extension is of valueCodeableConcept or string.
 * @param url - URL of the extension being filtered identifying MilitaryStatus, leveOfService, and so forth.
 */
fun extensionLookUp(extension,valueType,url)=(
    (
    	if(valueType == "valueCodeableConcept")
    		(extension filter($.url == url))[0].valueCodeableConcept.coding[0].code
    	else if(valueType == "valueIdentifier")
    		(extension filter($.url == url))[0].valueIdentifier
    	else if(valueType == "valueBoolean")
    		(extension filter($.url == url))[0].valueBoolean
		else if(valueType == "valueDecimal")
		    (extension filter($.url == url))[0].valueDecimal
		else if(valueType == "valueReference")
		    (extension filter($.url == url))[0].valueReference.reference
	    else if(valueType == "valueDate")
		    (extension filter($.url == url))[0].valueDate    
	    else if(valueType == "valueString")
	    	(extension filter($.url == url)[0]).valueString
	    else if(valueType == "valuePeriod")
	    	(extension filter($.url == url))[0].valuePeriod
	    else 
	    	(extension filter($.url == url)[0])
	)
)

/**
 * Function to lookup Product/Service system and generate X12 format qualifiers.
 * @param inCode is the FHIR system expressed in an URL format.
 * @return X12 formatted qualifiers for the system in FHIR.
 */
fun productOrServiceLookUp(inCode)=(
    inCode match {
        case 'http://www.ama-assn.org/go/cpt' -> 'HC'
        case 'http://www.cms.gov/Medicare/Coding/HCPCSReleaseCodeSets' -> 'HC'
        case 'http://hl7.org/fhir/sid/ndc' -> 'N4'
        case 'https://bluebutton.cms.gov/resources/codesystem/hcpcs' -> 'HC'
        else -> ""
    }
)

/**
 * Function to fetch claim resource's supporting Info for Patient Event, Admission, Discharge, AdditionalInfo, Message, and so forth.
 * @param supportingInfoArray - List of supportinginfos from FHIR PAS Claim Resource.
 * @param eventCode - Codeable concept's code to filter the list.
 * @param eventSystem - Codeable concept's system to filter the list.
 * @return - supportingInfo from FHIR Claim that matches the code and system.
 */
fun fetchSupportingInfo(supportingInfoArray,eventCode,eventSystem)=(
	(supportingInfoArray filter($.category.coding[0].code == eventCode and $.category.coding[0].system == eventSystem))[0]
)

/**
 * X12 formats the period range string with the provided 
 * FHIR period object.
 * @param periodObject is an FHIR-formatted period object.
 * @return A X12 period range string.
 */
fun formatPeriod(periodObject) = 
(if (!isEmpty(periodObject.start) and !isEmpty(periodObject.end))
    periodObject.start ++ "-" ++ periodObject.end
else null)

/**
 * Formats the provided date string into a valid datetime 
 * string that can be cast to a date or a time.
 * @param str is the current datetime string.
 * @return A datetime formatted string.
 */
fun formatDateTime(str) = 
(if (!isEmpty(str))
    (
        if (str matches(/^\\d{4}-\\d{2}-\\d{2}$/))
            (str ++ "T00:00:00")
        else str
    )
else null)

/**
 * Creates a TRN object with the provided arguments.
 * @param trnType is a string with TRN type.
 * @param trn01 is value for Trace Type code.
 * @param trn02 is a string with TRN type Trace Number.
 * @param trn03 is a string with Trace Assigning Entity Identifier.
 * @param trn04 is a string with Trace Assigning Entity Additional Identifier.
 * @return X12 formatted TRN segment
 */
fun createTRN(trnType,trn01,trn02,trn03,trn04)=(
    {
        "TRN01_TraceTypeCode": trn01, 
        //("TRN02_" ++ trnType ++ "TraceNumber"): trn02,
        (if(["PatientEvent","Service","Subscriber"] contains trnType) "TRN02_" ++ trnType ++ "TraceNumber" 
        else "TRN02_PayerClaimControlNumberOrProviderAttachmentControlNumber"
    ) : trn02,
        "TRN03_TraceAssigningEntityIdentifier": trn03 default "",
        "TRN04_TraceAssigningEntityAdditionalIdentifier":  trn04 default ""     
    }
)

/**
 * Function to create HI segment with provided input parameters.
 * @param hi101 - Diagnosis code classification library identifier.
 * @param hi102 - Diagnosis code.
 * @param hi201 - Diagnosis code classification library identifier.
 * @param hi202 - Diagnosis code.
 * @return An X12 formatted HI segment.
 */
fun createHI(hi101,hi102,hi201,hi202) = (
	{
		"HI01_HealthCareCodeInformation" : {
			"HI01_DiagnosisTypeCode" : hi101,
			"HI02_DiagnosisCode" : hi102
		},
		"HI02_HealthCareCodeInformation" : {
			"HI01_DiagnosisTypeCode" : hi201,
			"HI02_DiagnosisCode" : hi202
		}
		 
	}
)

/** Creates an HI healthcare information object with the 
 * provided arguments.
 * @param hi01 is a segment qualifier for diagnosys code admitting.
 * @param hi02 is a segment qualifier for diagnosys code principal.
 * @param hi03 is a segment qualifier for diagnosys code patientreasonforvisit.
 * @param hi04 is a string with diagnosys code.
 */
fun createHI(hi01,hi02)=({
    "HI01_HealthCareCodeInformation":{
    "HI01_DiagnosisTypeCode" : if("admitting"==hi01) "ABJ" 
                                else if("principal"==hi01) "ABK" 
                                else if("patientreasonforvisit"==hi01)"APR" 
                                else "",
    "HI02_DiagnosisCode": hi02 
                                        }
})

/** Creates a UM object with the 
 * provided arguments.
 * @param um01 is request category code.
 * @param um02 is certification type code.
 * @param um03 is service type code.
 * @param um0401 is a sub element of UM04 for facility code.
 * @param um0402 is a sub element of UM04 for facility code qualifier.
 * @param um0501 is a sub element of UM05 for related causes code.
 * @param um0504 is a sub element of UM05 for state or province code.
 * @param um0506 is the level of service code.
 * @return X12 formatted UM segment.
 */
fun createUM(um01,um02,um03,um0401,um0402,um0501,um0504,um06)=({
    "UM01_RequestCategoryCode": um01,
    "UM02_CertificationTypeCode" : um02,
    "UM03_ServiceTypeCode" : um03,
    ("UM04_HealthcareServiceLocationInformation" : {
    	"UM01_FacilityTypeCode" : um0401,
    	"UM02_FacilityCodeQualifier" : um0402
    }) if(! isEmpty(um0401)),
    ("UM05_RelatedCausesInformation": {
        "UM01_RelatedCausesCode": um0501,
        "UM04_StateOrProvinceCode" : um0504
    }) if(! isEmpty(um0501)),
    "UM06_LevelOfServiceCode": um06
})

/**
 * Function creates 2000E_Loop and its child loops like 2010EA and 2000F; 2000E_Loop includes 
 * TRN, UM, DTP,HI,PWK,MSG, 2010EA_Loop and 2000F_Loop; 2010EA_Loop includes NM1, N3, N4, PER, 
 * PRV; 2000F_Loop includes TRN, REF, UM, DTP, SV1 or SV2. This loop can occur in either 2000C at 
 * the subscriber level, when the subscriber is the patient; or it can occur at 2000D at the 
 * beneficiary level, when a dependent of the subscriber is the patient.
 */
 fun createSubmit2000ELoop(inRequest,claimResource,segmentQualifiers,fhirConstantsObj,patientDates,claimSupportingInfo)=(
    {
        "TRN_PatientEventTrackingNumber" : 	[createTRN("PatientEvent",
                                                      segmentQualifiers."TRN"."TRN_PatientEventTrackingNumber"."trn01",
                                                      claimResource.identifier[0].value default uuid(),
                                                      claimResource.identifier[0].assigner.identifier.value default segmentQualifiers.TRN.TRN_PatientEventTrackingNumber.trn03,
                                                      (claimResource.identifier[0].extension filter($.url == fhirConstantsObj."Submit"."extension"."subDepartment"))[0].valueString default " ")],
        "UM_HealthCareServicesReviewInformation" : createUM(
                       extensionLookUp(claimResource.item[0].extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.serviceItemRequestType) default segmentQualifiers.UM.UM_HealthCareServicesReviewInformation1.um01,//UM01
                       extensionLookUp(claimResource.item[0].extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.certificationType) default segmentQualifiers.UM.UM_HealthCareServicesReviewInformation1.um02,//UM02
                       claimResource.item[0].category.coding[0].code,//UM03,
                       claimResource.item[0].locationCodeableConcept.coding[0].code, //UM0401
                       if( claimResource.item[0].locationCodeableConcept.coding[0].system == fhirConstantsObj.Submit.location.typeOfBill) "A"
                       else if(claimResource.item[0].locationCodeableConcept.coding[0].system == fhirConstantsObj.Submit.location.placeOfServiceCodeSet) "B"
                       else "", //UM0402 This has to be either A or B, cannot be any other value. Any other value fails validation
                       claimResource.accident."type".coding[0].code,//UM0501
                       claimResource.accident.locationAddress.state, //UM0504
                       extensionLookUp(claimResource.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.levelOfServiceCode) //UM06
       ),
       ("DTP_AccidentDate": createDTP("AccidentDate",segmentQualifiers."DTP"."DTP_AccidentDate"."dtp01",
                                        segmentQualifiers."DTP"."DTP_AccidentDate"."dtp02",
                                        claimResource.accident.date)
       ) if(! isEmpty(claimResource.accident.date)),
       ("DTP_EventDate" : createDTP("ProposedOrActualEventDate",segmentQualifiers."DTP"."DTP_EventDate"."dtp01",
                                   if(patientDates.patientEventTimeType == "timingDate") "D8" 
                                   else "RD8",
                                   if(patientDates.patientEventTimeType == "timingDate") claimSupportingInfo.patientEvent.timingDate
                                   else (claimSupportingInfo.patientEvent.timingPeriod.start default "") ++ "-" ++ (claimSupportingInfo.patientEvent.timingPeriod.end default ""))
       ) if(! isEmpty(patientDates.patientEventTimeType)),
       ("DTP_AdmissionDate" : createDTP("AdmissionDate",segmentQualifiers."DTP"."DTP_AdmissionDate"."dtp01",
                                   if(patientDates.patientAdmissionDatesType == "timingDate") "D8" 
                                   else "RD8",
                                   if(patientDates.patientAdmissionDatesType == "timingDate") claimSupportingInfo.admissionDates.timingDate
                                   else (claimSupportingInfo.admissionDates.timingPeriod.start default "") ++ "-" ++ (claimSupportingInfo.admissionDates.timingPeriod.end default ""))
       ) if(! isEmpty(patientDates.patientAdmissionDatesType)),
       ("DTP_DischargeDate" : createDTP("DischargeDate",segmentQualifiers."DTP"."DTP_AdmissionDate"."dtp01",
                                   if(patientDates.patientDischargeDatesType == "timingDate") "D8" 
                                   else "RD8",
                                   if(patientDates.patientDischargeDatesType == "timingDate") claimSupportingInfo.dischargeDates.timingDate
                                   else (claimSupportingInfo.dischargeDates.timingPeriod.start default "") ++ "-" ++ (claimSupportingInfo.dischargeDates.timingPeriod.end default ""))
       ) if(! isEmpty(patientDates.patientDischargeDatesType)),
       ("HI_PatientDiagnosis": createHI(claimResource.diagnosis[0]."type".coding[0].code, //HI01
                                        claimResource.diagnosis[0].diagnosisCodeableConcept[0].coding[0].code)//HI0102
       ) if(! isEmpty(claimResource.diagnosis[0].diagnosisCodeableConcept[0].coding[0].code)),
       ("PWK_AdditionalPatientInformation" : createPWK("Patient",segmentQualifiers."PWK"."PWK_AdditionalPatientInformation".pwk01,
                                                       segmentQualifiers."PWK"."PWK_AdditionalPatientInformation".pwk02,
                                                       segmentQualifiers."PWK"."PWK_AdditionalPatientInformation".pwk05,
                                                       claimResource.identifier[0].value default uuid())//PWK06
       ) if(! isEmpty(claimSupportingInfo.additionalInfo)),  
       ("MSG_MessageText1": createMSG("FreeFormatMsg",claimSupportingInfo.msgTxt.valueString)) if(! isEmpty(claimSupportingInfo.msgTxt)),
       "2010EA_Loop" : (claimResource.careTeam filter($.extension[0].valueBoolean == true) default []) map(prv,prvIdx) -> {
 
            "NM1_PatientEventProviderName" : createNM1("PatientEventProvider",
                                           providerTypeLookup(prv.role.coding[0].code),
                                           if(substringBefore(prv.provider.reference,"/") == "Practitioner") "1" else "2",
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].family,
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].given[0],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].given[1],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].prefix[0],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].suffix[0],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.identifier[0]."type".coding[0].code match {
                                                           case "NPI" -> "XX"
                                                           case "EN" -> "24"
                                                           case "SB" -> "34"
                                                           case "46" -> "46"
                                                           else -> ""
                                                       },
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.identifier[0].value),
 
           ("N3_PatientEventProviderAddress" : createN3("PatientEventProvider",
                                                       getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.line[0],
                                                       getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.line[1])) if(! isEmpty(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address)),
           ("N4_PatientEventProviderCityStateZIPCode" : createN4("PatientEventProvider",
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.city,
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.state,
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.postalCode,
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.country,
                                                               "")) if(! isEmpty(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address)),
           ("PER_PatientEventProviderContactInformation" : createPER("PatientEventProvider",
                                                                     segmentQualifiers.PER.PER_RequesterContactInformation.per01,
                                                                     "",
                                                                     lookupPERCommType(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.telecom[0].system),
                                                                     getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.telecom[0].value,
                                                                     lookupPERCommType(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.telecom[1].system),
                                                                     getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.telecom[1].value,
                                                                     lookupPERCommType(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.telecom[2].system),
                                                                     getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.telecom[2].value)) if(! isEmpty(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.telecom)),															                                         
        ("PRV_PatientEventProviderInformation" : createPRV("PatientEventProvider",
                                                               providerTypeLookup(prv.role.coding[0].code),
                                                               segmentQualifiers.PRV.PRV_PatientEventProviderInformation,
                                                               prv.qualification.coding[0].code)) if(! isEmpty(prv.qualification)),	
                                                               
       }, //End 2010EA Loop
       "2000F_Loop" : claimResource.item map(it,itIdx) -> {
           ("TRN_ServiceTraceNumber" : [createTRN("Service",
           								segmentQualifiers."TRN"."TRN_ServiceTraceNumber".trn01,
                                        extensionLookUp(it.extension,"valueIdentifier",fhirConstantsObj.Submit.extension.itemTraceNumber).value,
                                        extensionLookUp(it.extension,"valueIdentifier",fhirConstantsObj.Submit.extension.itemTraceNumber).assigner.value,
                                        "")]) if(! isEmpty(extensionLookUp(it.extension,"valueIdentifier",fhirConstantsObj.Submit.extension.itemTraceNumber))),
			/*"UM_HealthCareServicesReviewInformation" : createUM(
									extensionLookUp(it.extension,"valueCodeableConcept","http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-serviceItemRequestType"),//UM01
									extensionLookUp(it.extension,"valueCodeableConcept","http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-certificationType"),//UM02
									it.category.coding[0].code,//UM03,
									it.locationCodeableConcept.coding[0].code, //UM0401
									if( it.locationCodeableConcept.coding[0].system == "https://www.nubc.org/CodeSystem/TypeOfBill") "A"
									else if(it.locationCodeableConcept.coding[0].system == "https://www.cms.gov/Medicare/Coding/place-of-service-codes/Place_of_Service_Code_Set") "B"
									else "", //UM0402 This has to be either A or B, cannot be any other value. Any other value fails validation
									"","",""),*/ //Send this UM if there are multiple items with extension for service, due to data constraints we have not included these           
           ("REF_PreviousReviewAuthorizationNumber" : createREF("PreviousReviewAuthorizationNumber",
                                                       segmentQualifiers.REF.REF_PreviousReviewAuthorizationNumber.ref01,
                                                       extensionLookUp(it.extension,"valueString",fhirConstantsObj.Submit.extension.authorizationNumber) default "")
   		   ) if(! isEmpty(extensionLookUp(it.extension,"valueString",fhirConstantsObj.Submit.extension.authorizationNumber) default "")),
		  ("REF_PreviousReviewAdministrativeReferenceNumber" : createREF("PreviousReviewAdministrativeReferenceNumber",
																		   segmentQualifiers."278".REF.REF_PreviousReviewAdministrativeReferenceNumber.ref01,
																		   extensionLookUp(it.extension,"valueString",fhirConstantsObj.Submit.extension.administrationReferenceNumber) default "")
			) if(! isEmpty(extensionLookUp(it.extension,"valueString",fhirConstantsObj.Submit.extension.administrationReferenceNumber) default "")),
			"DTP_ServiceDate" : createDTP("ProposedOrActualServiceDate",
										  segmentQualifiers.DTP."DTP_ServiceDate".dtp01,
										  if(! isEmpty(it.servicedDate)) "D8" 
										  else "RD8",
										  if(! isEmpty(it.servicedDate)) it.servicedDate
										  else (it.servicedPeriod.start default "") ++ "-" ++ (it.servicedPeriod.end default "")),
			("SV1_ProfessionalService" : createSV1(productOrServiceLookUp(it.productOrService.coding[0].system),
												  it.productOrService.coding[0].code,
												  it.modifier[0].coding[0].code,
												  it.modifier[1].coding[0].code,
												  it.modifier[2].coding[0].code,
												  it.modifier[3].coding[0].code,
												  it.productOrService.coding[0].display,
												  extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.productOrServiceCodeEnd),
												  it.unitPrice.value,
												  it.quantity.unit,
												  it.quantity.value)) if((claimResource."type".coding[0].code == "professional")),
			("SV2_InstitutionalServiceLine" : {
				"SV201_ServiceLineRevenueCode" : it.revenue.coding[0].code,
				"SV202_CompositeMedicalProcedureIdentifier" : {
					"SV201_ProductOrServiceIDQualifier" : it.productOrService.coding[0].system,
					"SV202_ProcedureCode" : it.productOrService.coding[0].code,
					"SV203_ProcedureModifier" : it.modifier[0].coding[0].code,
					"SV204_ProcedureModifier" : it.modifier[1].coding[0].code,
					"SV205_ProcedureModifier" : it.modifier[2].coding[0].code,
					"SV206_ProcedureModifier" : it.modifier[3].coding[0].code,
					"SV207_ProcedureCodeDescription" : it.productOrServiceCode.text,
					"SV208_ProcedureCode" : extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.productOrServiceCodeEnd)
				},
				"SV203_ServiceLineAmount" : it.unitPrice.value,
				"SV204_UnitOrBasisForMeasurementCode" : it.quantity.unit,
				"SV205_ServiceUnitCount" : it.quantity.value,
				"SV206_ServiceLineRate" : extensionLookUp(it.extension,"valueDecimal",fhirConstantsObj.Submit.extension.revenueUnitRateLimit),
				"SV209_NursingHomeResidentialStatusCode" : extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.nursingHomeResidentialStatus),
				"SV210_NursingHomeLevelOfCare" : extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.nursingHomeLevelOfCare)
			}
			)if(claimResource."type".coding[0].code == "institutional")															  										 
       }
       
   }         
)

/**
 * Function to create claim response json from incoming EDI Submit Response
 * with parameters loop2000C, loop2000A, fhirConstantsObj, heading.
 * @param loop2000C - X12's 2000C_Loop.
 * @param loop2000A - X12's 2000A_Loop.
 * @param fhirConstantsObj - List of constants defined in /src/main/resources/dwl/x12Util/fhirConstants.dwl for SubmitResponse.
 * @param heading - X12's Heading segment.
 * @return - FHIR formatted ClaimResponse Object.
 * 
 */  
fun createClaimResponse(claimResponseId,loop2000C,loop2000A,fhirConstantsObj,heading)=(
	{
				"resourceType" : "Claim",
				"id":claimResponseId,
				"identifier" : [
					{
						"system" : fhirConstantsObj.SubmitResponse.claimResponse.identifierSystem,
						"value" : loop2000C."2000E_Loop"[0].TRN_PatientEventTrackingNumber[0].TRN02_PatientEventTraceNumber default ""
					}
				],
				"status" : "active",
				"type" : {
					"coding" : [
						{
							(
								if(! isEmpty(loop2000C."2000E_Loop"[0]."2000F_Loop"[0]."SV1_ProfessionalService")) {
									"system" : fhirConstantsObj.SubmitResponse.claimResponse.typeSystem,					
									"code" : fhirConstantsObj.SubmitResponse.claimResponse.typeCodes.professional, 
									"display" : camelize(fhirConstantsObj.SubmitResponse.claimResponse.typeCodes.professional)									
									
								}
								else if(! isEmpty(loop2000C."2000E_Loop"[0]."2000F_Loop"[0]."SV2_InstitutionalServiceLine")) {
									"system" : fhirConstantsObj.SubmitResponse.claimResponse.typeSystem,					
									"code" : fhirConstantsObj.SubmitResponse.claimResponse.typeCodes.institutional, 
									"display" : camelize(fhirConstantsObj.SubmitResponse.claimResponse.typeCodes.institutional)									
									
								}
								else if(! isEmpty(loop2000C."2000E_Loop"[0]."2000F_Loop"[0]."SV3_DentalService")) {
									"system" : fhirConstantsObj.SubmitResponse.claimResponse.typeSystem,					
									"code" : fhirConstantsObj.SubmitResponse.claimResponse.typeCodes.oral, 
									"display" : camelize(fhirConstantsObj.SubmitResponse.claimResponse.typeCodes.oral)									
								}
								else {
									
								}
							)
						}
					]
				}, // End Type
				"use" : fhirConstantsObj.SubmitResponse.claimResponse.use,
				"patient" : {
					"reference" : "Patient/" ++ (loop2000C."2010C_Loop"."NM1_SubscriberName".NM109_SubscriberPrimaryIdentifier default "")
				},
				"created" : heading.BHT_BeginningOfHierarchicalTransaction."BHT04_TransactionSetCreationDate",
				"insurer" : {
					"reference" : "Organization/" ++ (loop2000A."2010A_Loop"."NM1_UtilizationManagementOrganizationUMOName"."NM109_UtilizationManagementOrganizationUMOIdentifier" default "")
				},
				"outcome": if(heading."BHT_BeginningOfHierarchicalTransaction"."BHT06_TransactionTypeCode" == "18") "complete"
						   else "partial",
				"disposition" : fhirConstantsObj.SubmitResponse.claimResponse.disposition,
				"preAuthRef" : loop2000C."2000E_Loop"[0]."HCR_HealthCareServicesReview1".HCR02_ReviewIdentificationNumber,
				"preAuthPeriod" : {
					"start" : loop2000C."2000E_Loop"[0]."DTP_CertificationEffectiveDate"."DTP03_CertificationEffectiveDate" as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' }
				},
				"item" : loop2000C."2000E_Loop" map(event,eventIdx) -> {
					"extension" : [
						{
										"url": fhirConstantsObj.SubmitResponse.claimResponse.extension.reviewActionCode,
										"valueCodeableConcept": {
											"coding" : [
												{
													"system": fhirConstantsObj.SubmitResponse.claimResponse.x12CodeSystems."hcr0306",
													"code" : event."HCR_HealthCareServicesReview1".HCR01_ActionCode
												}
											]
										}
						},
						if (!(isEmpty(event.DTP_CertificationIssueDate1.DTP03_CertificationIssueDate)))
						{
							"url" : fhirConstantsObj.SubmitResponse.claimResponse.extension.itemPreAuthIssueDate,
							"valueDate" : event.DTP_CertificationIssueDate1.DTP03_CertificationIssueDate
						
						}else null,
						if (!(isEmpty(event."2010EA_Loop"."NM1_PatientEventProviderName"."NM109_PatientEventProviderIdentifier")))
						{

									"url": fhirConstantsObj.SubmitResponse.claimResponse.extension.itemAuthorizedProvider,
									"valueCodeableConcept": {
											"coding" : [
												{
													"system": fhirConstantsObj.SubmitResponse.claimResponse.x12CodeSystems."hcr0306",
													"code" : event."2010EA_Loop"."NM1_PatientEventProviderName"."NM109_PatientEventProviderIdentifier"[0]
												}
											]
										}							
							
						}else null
						
					],
					"itemSequence" : eventIdx + 1, //Add 1 to the index, as the index is 0 based

				"adjudication" : [{
					"extension" : [
						{
							"url" : fhirConstantsObj.SubmitResponse.claimResponse.x12CodeSystems."hcr306_actionCode",
							"valueCodeableConcept" : {
								"coding" : [
										{
				                        "system" : fhirConstantsObj.SubmitResponse.claimResponse.x12CodeSystems."hcr306_actionCode",
				                        "code" : event."HCR_HealthCareServicesReview1".HCR01_ActionCode,
				                        
				                        }
				                        ]
							}
						}
					],
					"category" : {
						"coding" : [
							{	 
								"code" : fhirConstantsObj.SubmitResponse.claimResponse.adjudication.categoryCode,
								"system" : fhirConstantsObj.SubmitResponse.claimResponse.adjudication.categorySystem
							}
		
						]
					}
			}]				
				
				}, //End item
								
			}
)

/**
 * Function to get EventLoop from 2000E or 2000F. There are situations where 2000F loops are not 
 * populated in the X12 message. This function looks at both and returns the one that is present.
 * @param loop2000E is the 2000E_Loop from X12 Response.
 * @param loop2000FExists is a boolean that identifies the presence of a 2000F_Loop.
 * @return Loop structure of either 2000E or 2000F. 
 */
fun getEventLoop(loop2000E,loop2000FExists)=(
    (if(loop2000FExists) flatten(loop2000E."2000F_Loop") else loop2000E)
)

/**
 * Function to get extension values segment from either 2000E or 2000F loops. There are situations where 2000F loops are not populated in the X12 message with parameters LoopESegName,LoopFSegName,LoopE_Element,LoopF_Element,loop2000FExists,loop2000E. 
 * This function looks at both and returns the element from 2000F_Loop if it exists, else from 2000E_Loop. 
 * This function looks at both and returns the element from 2000F_Loop if it exists else from 2000E_Loop.
 * @param LoopESegName is the segment name from 2000E_Loop of X12 Response.
 * @param LoopFSegName is the segment name from 2000E_Loop of X12 Response.
 * @param LoopE_Element is the element name from 2000E_Loop of X12 Response.
 * @param LoopF_Element is the element name from 2000E_Loop of X12 Response.
 * @param loop2000FExists is a boolean that identifies the presence of a 2000F_Loop.
 * @param loop2000E is the 2000E_Loop from X12 Response.
 * @return Loop structure of either 2000E or 2000F.
 */

 fun getExtensionValue(LoopESegName,LoopFSegName,LoopE_Element,LoopF_Element,loop2000FExists,loop2000E)=(
	if(loop2000FExists) flatten(getEventLoop(loop2000E,loop2000FExists)[LoopFSegName])[LoopF_Element] else (getEventLoop(loop2000E,loop2000FExists)[LoopESegName])[LoopE_Element]
)

/**
 * Function to create inquiry response json from incoming EDI Inquiry Response
 * with parameters inqRespParams, bhtSegment, patientRef, insurerRef, requesterRef, loop2000E, loop2000FExists, fhirConstants.
 * @param inqRespParams is variable created in claim	sponse278toFHIR with paramters used for InquiryResponse.
 * @param bhtSegment is Heading.BHT segment of X12 Inquiry Response.
 * @param patientRef is reference to patient from X12 Inquiry Response.
 * @param insurerRef is reference to insurer from X12 Inquiry Response.
 * @param requesterRef is reference to requester from X12 Inquiry Response.
 * @param loop2000FExists is a boolean that identifies the presence of a 2000F_Loop.
 * @param loop2000E is the 2000E_Loop from X12 Response.
 * @param fhirConstants is the set of constants defined in InquiryResponse of /src/main/resources/x12Util/fhirConstants.dwl.
 * @return - FHIR formatted InquiryResponse Object.
 * 
 */ 
fun createInquiryResponse(inqRespParams,bhtSegment,patientRef,insurerRef,requesterRef,loop2000E,loop2000FExists,fhirConstants)=(
	{
			"resourceType" : "Claim",
			"id" : inqRespParams.id,
			"identifier" : [
				{
					"system" : inqRespParams.identifier.system,
					"value" : bhtSegment.BHT03_SubmitterTransactionIdentifier
				}
			],
			"status" : "active",
			"type" : {
			  "coding" : [
			    {
			      "system" : "http://terminology.hl7.org/CodeSystem/claim-type",
			      "code" : "professional"
			    }
			  ]
			},
			"use" : "preauthorization",			
			"created" : now(),
			
			"patient" : {
				"reference" : "Patient/" ++ patientRef
			},
			"insurer" : {
				"reference" : "Organization/" ++ insurerRef 
			},
 			"requestor" : {
				"reference" : "Organization/" ++ requesterRef
			},
			"encounter" : {
				"reference" : "Encounter/enc-1"
			}, 
			"facility" : {
				"reference" : "Location/location-1"
			}, 
			//daniel account for multi
			"procedure" : [
				{
				"procedureReference" : { "reference": "Procedure/px-1"},
				"sequence": 1,
				}
			], 
			//daniel account for multi
			"diagnosis" : [
				{
				"diagnosisReference" : { "reference": "Condition/dx-1"},
				"sequence": 1,
				}
			], 
			"provider": {
				"reference": "Practitioner/orderingPrac"
			},
			"careTeam": [
                    {
                        "sequence": 1,
                        "provider": {
                            "reference": "Practitioner/performingPrac"
                        }
                    }
                ],
			"request" : {
				"reference" : "Request/" ++ (bhtSegment.BHT03_SubmitterTransactionIdentifier default "")
			},
			"outcome" : if(fhirConstants.outcome.complete contains loop2000E[0]."HCR_HealthCareServicesReview1"."HCR01_ActionCode") "complete"
						else if(loop2000E[0]."HCR_HealthCareServicesReview1"."HCR01_ActionCode" == fhirConstants.outcome.partial) "partial"
						else if(loop2000E[0]."HCR_HealthCareServicesReview1"."HCR01_ActionCode" == fhirConstants.outcome.queued) "queued"
						else "error",
			("preAuthPeriod" : {
				start: formatDate(inqRespParams.preAuthPeriod.start),
				end: formatDate(inqRespParams.preAuthPeriod.end)
			}
			) if(loop2000FExists),
			"item" : (loop2000E default []) map(item,itIdx) -> {
				"itemSequence" : itIdx + 1, //Add 1 to the index, as the index is 0 based
				"extension" : (createInquiryExtension(item,inqRespParams,bhtSegment,patientRef,insurerRef,requesterRef,loop2000E,loop2000FExists,fhirConstants)).extension,
				"adjudication" : [{
					"extension" : [
						{
							"url" : fhirConstants.adjudication.extensionSystem,
							"valueCodeableConcept" : {
								"coding" : [
									"system" : fhirConstants.adjudication.codeableConceptSystem,
									"code" : getExtensionValue("HCR_HealthCareServicesReview1","HCR_HealthCareServicesReview","HCR01_ActionCode","HCR01_ActionCode",loop2000FExists,loop2000E)[0]
								]
							}
						}
					],
					"category" : {
						"coding" : [
							{
								"code" : fhirConstants.adjudication.categoryCode,
								"system" : fhirConstants.adjudication.categorySystem
							}
		
						]
					}
			}]				
			}, //item
 	
		}
)
/**
 * Function to create inquiry response extension json from incoming EDI Inquiry Response
 * with parameters inqRespParams, bhtSegment, patientRef, insurerRef, requesterRef, loop2000E, loop2000FExists, fhirConstants.
 * @param item is every item of the 2000E_Loop from X12 Response. 
 * @param inqRespParams is variable created in claimInquiryResponse278toFHIR with paramters used for InquiryResponse.
 * @param bhtSegment is Heading.BHT segment of X12 Inquiry Response.
 * @param patientRef is reference to patient from X12 Inquiry Response.
 * @param insurerRef is reference to insurer from X12 Inquiry Response.
 * @param requesterRef is reference to requester from X12 Inquiry Response.
 * @param loop2000FExists is a boolean that identifies the presence of a 2000F_Loop.
 * @param loop2000E is the 2000E_Loop from X12 Response.
 * @param fhirConstants is the set of constants defined in InquiryResponse of /src/main/resources/x12Util/fhirConstants.dwl.
 * @return - FHIR formatted InquiryResponse Object.
 * 
 */  
fun createInquiryExtension (item,inqRespParams,bhtSegment,patientRef,insurerRef,requesterRef,loop2000E,loop2000FExists,fhirConstants) = (
	{
				"extension" : [
					if (!(isEmpty((getExtensionValue("TRN_PatientEventTrackingNumber","TRN_ServiceTraceNumber","TRN02_PatientEventTraceNumber","TRN02_ServiceTraceNumber",loop2000FExists,loop2000E))[0])))
					{
						"url": fhirConstants.extension.itemTraceNumber,
						"valueIdentifier" :  
							{
								"system" : fhirConstants.extension.itemTraceNumber,
								"value" : (getExtensionValue("TRN_PatientEventTrackingNumber","TRN_ServiceTraceNumber","TRN02_PatientEventTraceNumber","TRN02_ServiceTraceNumber",loop2000FExists,loop2000E))[0]
							}
						 
					} else null,
					if (!(isEmpty(getExtensionValue("DTP_CertificationIssueDate","DTP_CertificationIssueDate1","DTP03_CertificationIssueDate","DTP03_CertificationIssueDate",loop2000FExists,loop2000E)[0])))					
					{
						"url" : fhirConstants.extension.preAuthIssueDate,
						"valueDate" : formatDate(getExtensionValue("DTP_CertificationIssueDate","DTP_CertificationIssueDate1","DTP03_CertificationIssueDate","DTP03_CertificationIssueDate",loop2000FExists,loop2000E)[0])
					}else null,
(if (!(isEmpty((getExtensionValue("DTP_CertificationIssueDate","DTP_CertificationIssueDate1","DTP03_CertificationIssueDate","DTP03_CertificationIssueDate",loop2000FExists,loop2000E)[0]))) or (!(isEmpty(getExtensionValue("DTP_CertificationExpirationDate","DTP_CertificationExpirationDate1","DTP03_CertificationExpirationDate","DTP03_CertificationExpirationDate",loop2000FExists,loop2000E)[0]))))  					
					{
						"url" : fhirConstants.extension.itemPreAuthPeriod,
						"valuePeriod" : {
							"start" : (getExtensionValue("DTP_CertificationIssueDate","DTP_CertificationIssueDate1","DTP03_CertificationIssueDate","DTP03_CertificationIssueDate",loop2000FExists,loop2000E)[0]) as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' },
	                        "end" : getExtensionValue("DTP_CertificationExpirationDate","DTP_CertificationExpirationDate1","DTP03_CertificationExpirationDate","DTP03_CertificationExpirationDate",loop2000FExists,loop2000E)[0] as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' }
						}
					}else null),
					
					({
						"url" : fhirConstants.extension.authorizationNumber,
						"valueString" : getExtensionValue("REF_PreviousReviewAdministrativeReferenceNumber","REF_PreviousReviewAdministrativeReferenceNumber","REF02_PreviousReviewAdministrativeReferenceNumber","REF02_PreviousReviewAdministrativeReferenceNumber",loop2000FExists,loop2000E)[0]
					}) if(! isEmpty(getExtensionValue("REF_PreviousReviewAdministrativeReferenceNumber","REF_PreviousReviewAdministrativeReferenceNumber","REF02_PreviousReviewAdministrativeReferenceNumber","REF02_PreviousReviewAdministrativeReferenceNumber",loop2000FExists,loop2000E)[0])),
					{
						"url" : fhirConstants.extension.administrationReferenceNumber,
						"valueString" : (getExtensionValue("TRN_PatientEventTrackingNumber","TRN_ServiceTraceNumber","TRN03_TraceAssigningEntityIdentifier","TRN03_TraceAssigningEntityIdentifier",loop2000FExists,loop2000E))[0]
					},
					({
						"url" : fhirConstants.extension.itemAuthorizedDate,
						(if(item."DTP_EventDate"."DTP03_ProposedOrActualEventDate" == "D8") ("valueDateTime" : item."DTP_EventDate"."DTP03_ProposedOrActualEventDate") 
						else ("valuePeriod" : {
							"start" : substringBefore(item."DTP_EventDate"."DTP03_ProposedOrActualEventDate","-") as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' },
							"end" : substringAfter(item."DTP_EventDate"."DTP03_ProposedOrActualEventDate","-") as Date { format: 'yyyyMMdd' } as String { format: 'yyyy-MM-dd' }
						}))
					}) if(! isEmpty(item."DTP_EventDate")),
					{
						"url" : fhirConstants.extension.itemAuthorizedDetail,
						"valueCodeableConcept" : {
							"coding" : [
								{
									"system" : fhirConstants.extension.itemAuthorizedDetail,
									"code" : flatten(item."2000F_Loop"."SV2_InstitutionalServiceLine" default [])[0]."SV201_ServiceLineRevenueCode"
								}
							]
						}
					},
					({
						"url" : fhirConstants.extension.itemAuthorizedProvider,
						"valueReference" : {
							"reference" : if(item."2000F_Loop"."2010F_Loop"."NM1_ServiceProviderName"."NM102_EntityTypeQualifier" == "1") "Practitioner/" ++ (item."2000F_Loop"."2010F_Loop"."NM1_ServiceProviderName"."NM109_ServiceProviderIdentifier" default "")
										  else "Organization/" ++ (item."2000F_Loop"."2010F_Loop"."NM1_ServiceProviderName"."NM109_ServiceProviderIdentifier" default "")
						}
					}) if(! isEmpty(item."2000F_Loop"."2010F_Loop"."NM1_ServiceProviderName"))							
				]		
	}
)
 
 
 
/**
 * Function creates 2000E_Loop and its child loops like 2010EA and 2000F; 
 * 2000E_Loop includes TRN, DTP, 2010EA_Loop and 2000F_Loop; 
 * 2010EA_Loop includes NM1, N3, N4, PER, PRV; 
 * 2000F_Loop includes TRN, UM, HCR, REF, DTP, SV1 or SV2.
 * This loop can occur in either 2000C at the subscriber level, when the subscriber is the patient, or 
 * it can occur at 2000D at the beneficiary level, when a dependent of the subscriber is the patient.
 */
fun createInquiry2000ELoop(inRequest,claimResource,segmentQualifiers,fhirConstantsObj,patientDates,claimSupportingInfo)= (
	{
		"TRN_PatientEventTrackingNumber" : [createTRN("PatientEvent",
													 segmentQualifiers."TRN"."TRN_PayerClaimControlNumberProviderAttachmentControlNumber"."trn01",
													 claimResource.identifier[0].value,
													 claimResource.identifier[0].assigner.identifier.value,
													 ""
		)],
       ("DTP_AccidentDate": createDTP("AccidentDate",segmentQualifiers."DTP"."DTP_AccidentDate"."dtp01",
                                        segmentQualifiers."DTP"."DTP_AccidentDate"."dtp02",
                                        claimResource.accident.date)
       ) if(! isEmpty(claimResource.accident.date)),
       ("DTP_EventDate" : createDTP("ProposedOrActualEventDate",segmentQualifiers."DTP"."DTP_EventDate"."dtp01",
                                   if(patientDates.patientEventTimeType == "timingDate") "D8" 
                                   else "RD8",
                                   if(patientDates.patientEventTimeType == "timingDate") claimSupportingInfo.patientEvent.timingDate
                                   else (claimSupportingInfo.patientEvent.timingPeriod.start default "") ++ "-" ++ (claimSupportingInfo.patientEvent.timingPeriod.end default ""))
       ) if(! isEmpty(patientDates.patientEventTimeType)),       
       ("DTP_AdmissionDate" : createDTP("AdmissionDate",segmentQualifiers."DTP"."DTP_AdmissionDate"."dtp01",
                                   if(patientDates.patientAdmissionDatesType == "timingDate") "D8" 
                                   else "RD8",
                                   if(patientDates.patientAdmissionDatesType == "timingDate") claimSupportingInfo.admissionDates.timingDate
                                   else (claimSupportingInfo.admissionDates.timingPeriod.start default "") ++ "-" ++ (claimSupportingInfo.admissionDates.timingPeriod.end default ""))
       ) if(! isEmpty(patientDates.patientAdmissionDatesType)),
	    "2010EA_Loop" : (claimResource.careTeam filter($.extension[0].valueBoolean == true) default []) map(prv,prvIdx) -> {
           "NM1_PatientEventProviderName" : createNM1("PatientEventProvider",
                                           providerTypeLookup(prv.role.coding[0].code),
                                           if(substringBefore(prv.provider.reference,"/") == "Practitioner") "1" else "2",
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].family,
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].given[0],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].given[1],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].prefix[0],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.name[0].suffix[0],
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.identifier[0]."type".coding[0].code match {
                                                           case "NPI" -> "XX"
                                                           case "EN" -> "24"
                                                           case "SB" -> "34"
                                                           case "46" -> "46"
                                                           else -> ""
                                                       },
                                           getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.identifier[0].value),
           ("N3_PatientEventProviderAddress" : createN3("PatientEventProvider",
                                                       getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.line[0],
                                                       getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.line[1])) if(! isEmpty(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address)),
           ("N4_PatientEventProviderCityStateZIPCode" : createN4("PatientEventProvider",
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.city,
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.state,
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.postalCode,
                                                               getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address.country,
                                                               "")) if(! isEmpty(getFHIRResource(inRequest,substringAfter(prv.provider.reference,"/")).resource.address)),
	        ("PRV_PatientEventProviderInformation" : createPRV("PatientEventProvider",
	                                                               providerTypeLookup(prv.role.coding[0].code),
	                                                               segmentQualifiers.PRV.PRV_PatientEventProviderInformation,
	                                                               prv.qualification.coding[0].code)) if(! isEmpty(prv.qualification)),					    	
	    }, //End 2010EA_Loop
	    "2000F_Loop" : claimResource.item map(it,itIdx) -> {
				("TRN_ServiceTraceNumber" : [createTRN("Service","1",
                                        			  extensionLookUp(it.extension,"valueIdentifier",fhirConstantsObj.Submit.extension.itemTraceNumber).value,
                                        			  extensionLookUp(it.extension,"valueIdentifier",fhirConstantsObj.Submit.extension.itemTraceNumber).system,
                                        			  extensionLookUp(it.extension,'valueString',fhirConstantsObj.Submit.extension.subDepartment)
                                        			)]
                ) if(! isEmpty(extensionLookUp(it.extension,"valueIdentifier",fhirConstantsObj.Submit.extension.itemTraceNumber))),	    	
		        "UM_HealthCareServicesReviewInformation" : createUM(
		                       extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.serviceItemRequestType) default segmentQualifiers.UM.UM_HealthCareServicesReviewInformation1.um01,//UM01
		                       extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.certificationType) default segmentQualifiers.UM.UM_HealthCareServicesReviewInformation1.um02,//UM02
		                       it.category.coding[0].code,//UM03,
		                       it.locationCodeableConcept.coding[0].code, //UM0401
		                       if( it.locationCodeableConcept.coding[0].system == fhirConstantsObj.Submit.location.typeOfBill) "A"
		                       else if(it.locationCodeableConcept.coding[0].system == fhirConstantsObj.Submit.location.placeOfServiceCodeSet) "B"
		                       else "", //UM0402 This has to be either A or B, cannot be any other value. Any other value fails validation
		                       "",//UM0501
		                       "", //UM0504
		                       "" //UM06
		       ),
		       ("HCR_HealthCareServicesReview" : createHCR(
		       	extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.InquiryResponse.extension.reviewActionCode)
		       )) if(! isEmpty(it.extension filter($.url == fhirConstantsObj.InquiryResponse.extension.reviewActionCode))),
		       ("REF_PreviousReviewAuthorizationNumber" : createREF("PreviousReviewAuthorization",
		       														segmentQualifiers."REF"."REF_PreviousReviewAuthorizationNumber".ref01,
		       														extensionLookUp(it.extension,'valueString',fhirConstantsObj.Submit.extension.authorizationNumber)
		       											)
		       ) if(! isEmpty(it.extension filter($.url == fhirConstantsObj.Submit.extension.authorizationNumber))),
		       (
		       	"REF_PreviousReviewAdministrativeReferenceNumber" : createREF("PreviousReviewAdministrativeReference",
		       																  segmentQualifiers."REF"."REF_PreviousReviewAdministrativeReferenceNumber".ref01,
		       																  extensionLookUp(it.extension,'valueString',fhirConstantsObj.Submit.extenion.administrationReferenceNumber)
		       																  )
		       ) if(! isEmpty(it.extension filter($.url == fhirConstantsObj.Submit.extension.administrationReferenceNumber))),
		       ("DTP_ServiceDate" : createDTP("ServiceDate",
		       								  	segmentQualifiers."DTP"."DTP_ServiceDate".dtp01,
		       								  	segmentQualifiers."DTP"."DTP_ServiceDate".dtp02,
		       								  	it.servicedDate)
		       ) if(! isEmpty(it.servicedDate)),
		       ("DTP_CertificationIssueDate1" : createDTP("CertificationIssueDate",
		       											  segmentQualifiers."DTP"."DTP_CertificationIssueDate1".dtp01,
		       											  segmentQualifiers."DTP"."DTP_CertificationIssueDate1".dtp02,
		       											  extensionLookUp(it.extension,'valueDate',fhirConstantsObj.Inquiry.extension.preAuthIssueDate)
		       ))  if(! isEmpty(it.extension filter($.url == fhirConstantsObj.Inquiry.extension.preAuthIssueDate))),
		       (
		       	"DTP_CertificationExpirationDate" : createDTP("CertificationExpirationDate",
		       												  segmentQualifiers."DTP"."DTP_CertificationExpirationDate".dtp01,
		       												  segmentQualifiers."DTP"."DTP_CertificationExpirationDate".dtp02,
		       												  extensionLookUp(it.extension,'valuePeriod',fhirConstantsObj.Inquiry.extension.preAuthPeriod).end
		       	)
		       ) if(! isEmpty(it.extension filter($.url == fhirConstantsObj.Inquiry.extension.preAuthPeriod))),
		       (
		       	"DTP_CertificationEffectiveDate1" : createDTP("CertificationEffectiveDate",
		       												  segmentQualifiers."DTP"."DTP_CertificationEffectiveDate".dtp01,
		       												  segmentQualifiers."DTP"."DTP_CertificationEffectiveDate".dtp02,
		       												  extensionLookUp(it.extension,'valuePeriod',fhirConstantsObj.Inquiry.extension.preAuthPeriod).start
		       												  )
		       	) if(! isEmpty(it.extension filter($.url == fhirConstantsObj.Inquiry.extension.preAuthPeriod))),
				("SV1_ProfessionalService" : createSV1(productOrServiceLookUp(it.productOrService.coding[0].system),
												  it.productOrService.coding[0].code,
												  it.modifier[0].coding[0].code,
												  it.modifier[1].coding[0].code,
												  it.modifier[2].coding[0].code,
												  it.modifier[3].coding[0].code,
												  it.productOrService.coding[0].display,
												  extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.productOrServiceCodeEnd),
												  it.unitPrice.value,
												  it.quantity.unit,
												  it.quantity.value)) if((claimResource."type".coding[0].code == "professional")),
				("SV2_InstitutionalServiceLine" : {
					"SV201_ServiceLineRevenueCode" : it.revenue.coding[0].code,
					"SV202_CompositeMedicalProcedureIdentifier" : {
						"SV201_ProductOrServiceIDQualifier" : it.productOrService.coding[0].system,
						"SV202_ProcedureCode" : it.productOrService.coding[0].code,
						"SV203_ProcedureModifier" : it.modifier[0].coding[0].code,
						"SV204_ProcedureModifier" : it.modifier[1].coding[0].code,
						"SV205_ProcedureModifier" : it.modifier[2].coding[0].code,
						"SV206_ProcedureModifier" : it.modifier[3].coding[0].code,
						"SV207_ProcedureCodeDescription" : it.productOrServiceCode.text,
						"SV208_ProcedureCode" : extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.productOrServiceCodeEnd)
				},
				"SV203_ServiceLineAmount" : it.unitPrice.value,
				"SV204_UnitOrBasisForMeasurementCode" : it.quantity.unit,
				"SV205_ServiceUnitCount" : it.quantity.value,
				"SV206_ServiceLineRate" : extensionLookUp(it.extension,"valueDecimal",fhirConstantsObj.Submit.extension.revenueUnitRateLimit),
				"SV209_NursingHomeResidentialStatusCode" : extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.nursingHomeResidentialStatus),
				"SV210_NursingHomeLevelOfCare" : extensionLookUp(it.extension,"valueCodeableConcept",fhirConstantsObj.Submit.extension.nursingHomeLevelOfCare)
			}
			)if(claimResource."type".coding[0].code == "institutional"),
		       	
	    }	
	}
)

/**
 * Creates a HCR segment with provided arguments.
 * @param hcr01 is a string with the action code for HCR.
 * @return X12 formatted HCR segment.
 */
fun createHCR(hcr01) = {
	"HCR01_ActionCode" : hcr01
}
