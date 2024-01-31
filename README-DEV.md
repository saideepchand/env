# FHIR to X12 Developer Guide

FHIR to X12 provides helper functions for mapping FHIR objects to X12 ones and reverse.

| Module | Description |
| :---- | :---- |
| [fhirtoAdditionalInfo275](#fhirtoadditionalinfo275) | Module that provides support for submit 275 request mapping. | 
| [fhirToSubmitRequest278](#fhirtosubmitrequest278) | Module that provides support for submit 278 request mapping. | 
| [submitResponse278toFHIR](#submitresponse278tofhir) | Module that provides support for submit 278 response mapping. | 
| [claimInquiryResponse278toFHIR](#claiminquiryresponse278tofhir) | Module that provides support for inquiry 278 response mapping. | 
| [fhirTo278Inquiry](#fhirto278inquiry) | Module that provides support for inquiry 278 request mapping. | 
| [fhirTo270Inquiry](#fhirto270inquiry) | Module that provides support for FHIR R4 CoverageEligibilityRequest to HIPAA X12 270 transformation. | 
| [fhirTo837Claim](#fhirto837claim) | Module that provides support for claim 837 professional mapping. | 
| [x12271ToFhirResponse](#x12271tofhirresponse) | Module that provides support for HIPAA X12 271 to FHIR R4 Coverage Eligibility Response transformation. | 
| [fhirConstants](#fhirconstants) | This module implements FHIR constants that are used in CoverageEligibilityRequest and Response mapping. | 
| [x12SegmentQualifiers](#x12segmentqualifiers) | This module implements X12 segment qualifier functions. | 
| [x12SegmentTools](#x12segmenttools) | This module implements X12 segment tools needed for * 837, 270 and 271 segments. | 
| [util](#util) | A library with needed DataWeave utility functions. | 

# fhirtoAdditionalInfo275

Module that provides support for submit 275 request mapping.
> Source: `.src/main/resources/dwl/Submit/fhirtoAdditionalInfo275.dwl`

([back to top](#))

# fhirToSubmitRequest278

Module that provides support for submit 278 request mapping.
> Source: `.src/main/resources/dwl/Submit/fhirToSubmitRequest278.dwl`

([back to top](#))

# submitResponse278toFHIR

Module that provides support for submit 278 response mapping.
> Source: `.src/main/resources/dwl/Submit/submitResponse278toFHIR.dwl`

([back to top](#))

# claimInquiryResponse278toFHIR

Module that provides support for inquiry 278 response mapping.
> Source: `.src/main/resources/dwl/Inquiry/claimInquiryResponse278toFHIR.dwl`

([back to top](#))

# fhirTo278Inquiry

Module that provides support for inquiry 278 request mapping.
> Source: `.src/main/resources/dwl/Inquiry/fhirTo278Inquiry.dwl`

([back to top](#))

# fhirTo270Inquiry

Module that provides support for FHIR R4 CoverageEligibilityRequest to HIPAA X12 270 transformation.
> Source: `.src/main/resources/dwl/fhirTo270Inquiry.dwl`

([back to top](#))

# fhirTo837Claim

Module that provides support for claim 837 professional mapping.
> Source: `.src/main/resources/dwl/fhirTo837Claim.dwl`

([back to top](#))

# x12271ToFhirResponse

Module that provides support for HIPAA X12 271 to FHIR R4 Coverage Eligibility Response transformation.
> Source: `.src/main/resources/dwl/x12271ToFhirResponse.dwl`

([back to top](#))

# fhirConstants

This module implements FHIR constants that are used in CoverageEligibilityRequest and Response mapping.
> Source: `.src/main/resources/dwl/x12Util/fhirConstants.dwl`

## Functions

__fun__ `fhirConstants ()`

Gets the constants used in lookup functions. * @return A map of constants used.


([back to top](#))

# x12SegmentQualifiers

This module implements X12 segment qualifier functions.
> Source: `.src/main/resources/dwl/x12Util/x12SegmentQualifiers.dwl`

## Functions

__fun__ `getSegmentQualifiers ()`

Gets the segment qualifiers for the 270, 278Submit, 278Inquiry, 275Submit and 837 transactions. * @return A map of segment qualifiers.


([back to top](#))

# x12SegmentTools

This module implements X12 segment tools needed for 
 * 837, 270 and 271 segments.
> Source: `.src/main/resources/dwl/x12Util/x12SegmentTools.dwl`

## Functions

__fun__ `getResource (resourceBundle, resourceId, resourceType)`

Function to get resource from bundle using either resourceId or resourceType. * @param resourceBundle is the payload bundle to be filtered. * @param resourceId is the ID of the resource to be used for filtering resources. * @param resourceType is the type of resource to be used for filtering resources. * Use either resourceId or resourceType for filtering.


__fun__ `createN3 (n3Type, n301, n302)`

Creates an N3 address object with the provided * arguments. * @param n3Type is a string with the N3 type. * @param n301 is the first address line. * @param n302 is the second address line. * @return A formatted N3 address object.


__fun__ `createN4 (n4Type, n401, n402, n403, n404, n407)`

Creates an N4 address (city, state, zip) object with the provided * arguments. **Limitation:** Doesn't support N407 - Assuming address is within * United States of America, including its territories, or Canada * @param n4Type is a string with the N$ type. * @param n401 is a string with the address city. * @param n402 is a string with the address state. * @param n403 is a string with the address postal code. * @param n404 is a string with the address country. * @param n407 is a string with the address district. * @return A formatted N4 address object.


__fun__ `createDTP (dtpType, dtp01, dtp02, dtp03)`

Creates a DTP (date time period) object with the provided * arguments. * @param dtpType is a string with DTP type. * @param dtp01 is a string with DTP qualifier. * @param dtp02 is a string with DTP format qualifier. * @param dtp03 is a string with DTP value. * @return A formatted DTP object.


__fun__ `createREF (refType, ref01, ref02)`

Creates an REF segment with the provided arguments. * @param refType is a string with the provider code. * @param ref01 is a string with the reference identification qualifier. * @param ref02 is a reference with the ref02 element name being constructed with refType and REF02. * @return X12 formatted REF segment.


__fun__ `getFHIRResource (inRequest, resourceId)`

Function to lookup resource from bundle based on a resource's ID. * Example: Pass in an Organization's ID and * the response would be the Organization object from the bundle. * @param inRequest - Input request to the API. * @param resourceId - ID of resource to be looked up. * @return Resource Object for the matching resource. *


__fun__ `createPER (perType, per01, per02, per03, per04, per05, per06, per07, per08)`

Creates a PER contact information object with the provided * arguments. * @param perType is a string with the PER type. * @param per01 is a string with the function code. * @param per02 is a string with the contact name. * @param per03 is a string with the number qualifier. * @param per04 is a string with the number value. * @param per05 is a string with the second number qualifier. * @param per06 is a string with the second number value. * @param per07 is a string with the third number qualifier. * @param per08 is a string with the third number value. * @return A formatted PER contact information object.


__fun__ `createSV303 (inputData)`

Creates a SV303 oral cavity designation object with the * provided arguments. * @param inputData is a claim resource object. * @return A SV303 oral cavity object.


__fun__ `createSV3 (inputData)`

Creates a SV3 dental service object with the provided * arguments. * @param inputData is a claim resource object. * @return A formatted SV3 dental service object.


__fun__ `createSV1 (sv101_01, sv101_02, sv101_03, sv101_04, sv101_05, sv101_06, sv101_07, sv101_08, sv102, sv103, sv104)`

Creates a SV1 professional service object with the * provided arguments. * @param sv1_1 is a string with the EPSDT indicator. * @param sv1_2 is a string with product or service ID qualifier. * @param sv1_3 is a claim resource object. * @return A formatted SV1 professional service object.


__fun__ `createSBR (perType, per01, per02, per03, per04, per05, per09)`

Creates an SBR contact information object with the provided * arguments. * @param perType is a string with the PER type. * @param per01 is a string with the Contact Function code. * @param per02 is a string with the contact name. * @param per03 is a string with the Communication Number Qualifier. * @param per04 is a string with the Communication Number. * @param per05 is a string with the Communication Number Qualifier. * @param per09 is a string with the Contact Inquiry Reference. * @return A formatted PER contact information object.


__fun__ `genderLookup (gndr)`

Formats the provided gender string into a valid gender. * String that can be cast to the gender value. * @param gndr is the string with gender type. * @return A required gender value.


__fun__ `createDMG (dmgType, dmg01, dmg02, dmg03)`

Creates a DMG demographic information object with the * provided arguments. * @param dmgType is a string with the DMG type. * @param dmg01 is a string with the format qualifier. * @param dmg02 is a patient object. * @return A formatted DMG demographic information object.


__fun__ `payerSequenceNumberPayerLookup (code)`

Formats the provided gender string into a valid gender. * String that can be cast to the gender value. * @param gndr is the string with gender type. * @return A required gender value.


__fun__ `relationCodeX12FHIR (inCode)`

Function to convert X12 relationship code to FHIR format. * @param inCode X12 relationship code. * @return FHIR format relationship code.


__fun__ `genderLookupX12FHIR (inCode)`

Function to convert X12 Gender codes to FHIR format. * @param inCode X12 Gender code. * @return FHIR format Gender code.


__fun__ `telecomTypeX12FHIR (inCode)`

Function to convert X12 telecom codes to FHIR format. * @param inCode X12 relationship code. * @return FHIR format relationship code.


__fun__ `createTelecom (perSegment)`

Function to create a telecom object for the FHIR resource using the X12 PER segment. * @param perSegment PER segment from X12 message. * @return telecom object formatted per FHIR specification.


__fun__ `pluckValuefromSeg (segment, selector)`

Function to fetch element from segment with the key name prefix. * @param segment from which to extract the element value. * @selector is the prefix of the element to be fetched. *


__fun__ `createPWK (pwkType, pwk01, pwk02, pwk05, pwk06)`

Function to create a PWK segment using the provided parameters. * @param pwkType Describes the PWK segment being mapped. * @param pwk01 Report Type code. * @param pwk02 Report Transmission code. * @param pwk05 Attachment control number. * @param pwk06 Attachment description. * @return X12 formatted BIN segment.


__fun__ `createMSG (msgType, msg01)`

Function to create an MSG segment using the provided parameters. * @param msgType Describes the MSG segment being mapped. * @param msg01 Message to be written to MSG segment. * @return X12 formatted MSG segment.


__fun__ `benefitTypeLookup (x12BenefitType)`

Function to translate X12 benefit type to FHIR format. * @param x12BenefitType - X12 benefit type. * @return FHIR benefit format benefit type.


__fun__ `createPRV (prvType, prv01, prv02, prv03)`

Creates a PRV provider information object with the * provided arguments. * @param prvType describes the provider type being mapped. Not in use now, but could be used if multiple PRV segments with varying fields names are required. * @param prv01 is a string with the provider code. * @param prv02 is a string with the reference identification qualifier. * @param prv03 is a string with the provider taxonomy code. * @return X12 formatted PRV segment.


__fun__ `termTypeLookup (x12TermCode)`

Function to convert term type from X12 to FHIR. * @param x12TermCode - X12 term type. * @return FHIR format term type.


__fun__ `createResponseItem (item, fhirConstants)`

Function to create item array within CoverageEligibilityResponse. * @param item - item is the input x12's EB segment. * @param itemCategorySystem - system identifier for item's category. * @return - An array of item with benefit and other details.


__fun__ `fetchBenefitLoop (dependentPatientExists, benefitsLoop)`

Function to fetch the benefits loop based on the patient being a subscriber or a dependent. * @param dependentPatientExists - Boolean indicating if the patient is the subscriber or dependent. * @param benefitsLoop - X12 271's 2100C or 2100D based on the patient being a dependent or subscriber.


__fun__ `createCoverageEligibilityResponse (fhirConstants, covRespId, bhtSegment, patientId, requesterType, requestorId, outcome, payorId, coverageId, benefitPeriod, benefitsLoop, dependentPatientExists)`

Function to create CoverageEligibilityResponse. * @param fhirConstants - List of constants used to for identifiers and system. * @param covRespId - Unique ID for CoverageEligibilityResponse. * @param bhtSegment - BHT segment from X12 271 input. * @param patientId - the patient's ID (either subscriber or dependent) from X12 271 2100C Loop. * @param requesterType - Type of the party sending the CoverageEligibilityRequest can be either Practitioner or Organization. * @param requestorId - ID of the sender of the CoverageEligibilityRequest. * @param outcome - Outcome of the 271 X12 based on AAA segment. * @param payorId - ID of the Information Source, which is the payer in this case. * @param coverageId - ID of the Coverage created as part of the bundle. * @param benefitPeriod - Benefit begin and end date. * @param benefitsLoop - 2110D or 2110C loop of the X12 271 based on the patient. * @param dependentPatientExists - Boolean indicating if the patient is the subscriber or dependent.


__fun__ `RelationshipLookup (relateship)`

Formats the provided coverage relationship string into a valid relationship string that * can be cast to the relationship value. **Limitation:** Only support FHIR relations - Spouse, * Child, and Other Relationship. * **Limitation:** Only support FHIR relations - Spouse, Child, and Other Relationship. * @param relateship is the string with gender type. * @return A required gender value.


__fun__ `createINS (insType, ins01, ins02)`

Function to create an INS segment with the provided input parameters. * @param insType - INS segment for patient(subscriber or dependent). * @param ins01 - insured indicator. * @param ins02 - relationship to insured. * @return An X12 formatted INS segment.


__fun__ `createINS (insType, ins01, ins02, ins08)`

Creates an INS object with the provided * arguments. * @param ins01 is an Insured Indicator value. * @param inso2 is value for Individual Relationship code. * @param ins08 is a string with Employment Status code. * @return X12 formatted INS segment.


__fun__ `insuredRelationLookup (relCode)`

Formats the provided relationship code into a valid * code that can be cast to relationship code. * @param relCode is the code with relationship type. * @return A required relationship code.


__fun__ `createBIN (bin01)`

Creates a BIN object with the provided * arguments. * @param bin01 is a Binary Data value. * @return X12 formatted BIN segment.


__fun__ `createEFI (efi01)`

Creates a EFI (Electronic Format Identification) object with the provided * arguments. * @param efi01 is a Security Level code. * @return X12 formatted EFI segment.


__fun__ `createCAT (cat01, cat02)`

Creates a CAT (Category Of Patient Information Service) object with the provided arguments. * @param cat01 is a Attachment Report Type code. * @param cat02 is a Attachment Information Format code. * @return X12 formatted CAT segment.


__fun__ `createLX (lx01)`

Creates an LX object with the provided arguments. * @param lx01 is a Assigned Number. * @return X12 formatted LX segment.


__fun__ `createNX1 (nx1_01)`

Creates an NX1 object with the provided arguments. * @param nx1_01 is a Entity Identifier code. * @return X12 formatted NX1 segment.


__fun__ `providerTypeLookup (inCode)`

Function to convert provider type from FHIR to X12 format. * @param inCode FHIR format lookup value. * @return X12 format qualifier for provider.


__fun__ `lookupPERCommType (inCode)`

Function to convert PER segments from FHIR format to X12 format. * @param inCode - Telecom system in FHIR. * @return X12 format communication type qualifier.


__fun__ `extensionLookUp (extension, valueType, url)`

Function to lookup extension using URL comparison and return the appropriate code based on type of extension. * @param extension - Array of extensions to be filtered. * @param valueType - Defines whether extension is of valueCodeableConcept or string. * @param url - URL of the extension being filtered identifying MilitaryStatus, leveOfService, and so forth.


__fun__ `fetchSupportingInfo (supportingInfoArray, eventCode, eventSystem)`

Function to fetch claim resource's supporting Info for Patient Event, Admission, Discharge, AdditionalInfo, Message, and so forth. * @param supportingInfoArray - List of supportinginfos from FHIR PAS Claim Resource. * @param eventCode - Codeable concept's code to filter the list. * @param eventSystem - Codeable concept's system to filter the list. * @return - supportingInfo from FHIR Claim that matches the code and system.


__fun__ `formatPeriod (periodObject)`

X12 formats the period range string with the provided * FHIR period object. * @param periodObject is an FHIR-formatted period object. * @return A X12 period range string.


__fun__ `formatDateTime (str)`

Formats the provided date string into a valid datetime * string that can be cast to a date or a time. * @param str is the current datetime string. * @return A datetime formatted string.


__fun__ `createTRN (trnType, trn01, trn02, trn03, trn04)`

Creates a TRN object with the provided arguments. * @param trnType is a string with TRN type. * @param trn01 is value for Trace Type code. * @param trn02 is a string with TRN type Trace Number. * @param trn03 is a string with Trace Assigning Entity Identifier. * @param trn04 is a string with Trace Assigning Entity Additional Identifier. * @return X12 formatted TRN segment


__fun__ `createHI (hi101, hi102, hi201, hi202)`

Function to create HI segment with provided input parameters. * @param hi101 - Diagnosis code classification library identifier. * @param hi102 - Diagnosis code. * @param hi201 - Diagnosis code classification library identifier. * @param hi202 - Diagnosis code. * @return An X12 formatted HI segment.


__fun__ `createHI (hi01, hi02)`

Creates an HI healthcare information object with the * provided arguments. * @param hi01 is a segment qualifier for diagnosys code admitting. * @param hi02 is a segment qualifier for diagnosys code principal. * @param hi03 is a segment qualifier for diagnosys code patientreasonforvisit. * @param hi04 is a string with diagnosys code.


__fun__ `createUM (um01, um02, um03, um0401, um0402, um0501, um0504, um06)`

Creates a UM object with the * provided arguments. * @param um01 is request category code. * @param um02 is certification type code. * @param um03 is service type code. * @param um0401 is a sub element of UM04 for facility code. * @param um0402 is a sub element of UM04 for facility code qualifier. * @param um0501 is a sub element of UM05 for related causes code. * @param um0504 is a sub element of UM05 for state or province code. * @param um0506 is the level of service code. * @return X12 formatted UM segment.


__fun__ `createSubmit2000ELoop (inRequest, claimResource, segmentQualifiers, fhirConstantsObj, patientDates, claimSupportingInfo)`

Function creates 2000E_Loop and its child loops like 2010EA and 2000F; 2000E_Loop includes * TRN, UM, DTP,HI,PWK,MSG, 2010EA_Loop and 2000F_Loop; 2010EA_Loop includes NM1, N3, N4, PER, * PRV; 2000F_Loop includes TRN, REF, UM, DTP, SV1 or SV2. This loop can occur in either 2000C at * the subscriber level, when the subscriber is the patient; or it can occur at 2000D at the * beneficiary level, when a dependent of the subscriber is the patient.


__fun__ `getEventLoop (loop2000E, loop2000FExists)`

Function to get EventLoop from 2000E or 2000F. There are situations where 2000F loops are not * populated in the X12 message. This function looks at both and returns the one that is present. * @param loop2000E is the 2000E_Loop from X12 Response. * @param loop2000FExists is a boolean that identifies the presence of a 2000F_Loop. * @return Loop structure of either 2000E or 2000F.


__fun__ `getExtensionValue (LoopESegName, LoopFSegName, LoopE_Element, LoopF_Element, loop2000FExists, loop2000E)`

Function to get extension values segment from either 2000E or 2000F loops. There are situations where 2000F loops are not populated in the X12 message with parameters LoopESegName,LoopFSegName,LoopE_Element,LoopF_Element,loop2000FExists,loop2000E. * This function looks at both and returns the element from 2000F_Loop if it exists, else from 2000E_Loop. * This function looks at both and returns the element from 2000F_Loop if it exists else from 2000E_Loop. * @param LoopESegName is the segment name from 2000E_Loop of X12 Response. * @param LoopFSegName is the segment name from 2000E_Loop of X12 Response. * @param LoopE_Element is the element name from 2000E_Loop of X12 Response. * @param LoopF_Element is the element name from 2000E_Loop of X12 Response. * @param loop2000FExists is a boolean that identifies the presence of a 2000F_Loop. * @param loop2000E is the 2000E_Loop from X12 Response. * @return Loop structure of either 2000E or 2000F.


__fun__ `createInquiry2000ELoop (inRequest, claimResource, segmentQualifiers, fhirConstantsObj, patientDates, claimSupportingInfo)`

Function creates 2000E_Loop and its child loops like 2010EA and 2000F; * 2000E_Loop includes TRN, DTP, 2010EA_Loop and 2000F_Loop; * 2010EA_Loop includes NM1, N3, N4, PER, PRV; * 2000F_Loop includes TRN, UM, HCR, REF, DTP, SV1 or SV2. * This loop can occur in either 2000C at the subscriber level, when the subscriber is the patient, or * it can occur at 2000D at the beneficiary level, when a dependent of the subscriber is the patient.


__fun__ `createHCR (hcr01)`

Creates a HCR segment with provided arguments. * @param hcr01 is a string with the action code for HCR. * @return X12 formatted HCR segment.


([back to top](#))

# util

A library with needed DataWeave utility functions.
> Source: `.src/main/resources/dwl/util.dwl`

## Functions

__fun__ `mapGuid (InStr: String)`

Generates a GUID with the provided string. This is * helpful because the GUID generated is predictable. * @param InStr is the input string to the hash function. * @return A string with the predictable hashed value.


__fun__ `toString (data)`

Converts anything to a JSON string representation. Note that * if you are serializing an object datetime fields may have local * timezone information so this can cause issues with repeatability * for munit tests. Note that the writeAttributes part is very important * so that the XML attributes will be converted to string as well. * @param data is the data type to convert to JSON. * @return A JSON formatted string of the provided variable.


__fun__ `clean (obj: Object)`

Cleans the provided object of blank strings, null values, * empty objects, and empty arrays. * @param obj is an Object to clean. * @return A cleaned object.


__fun__ `clean (arr: Array)`

Cleans the provided array of blank strings, null values, * empty objects, and empty arrays. * @param arr is an Array to clean. * @return A cleaned Array.


__fun__ `removeNull (arr: Array)`

Removes all null items from an array. * @param arr is an array. * @return An array with null items removed.


__fun__ `removeNull (obj: Object)`

Removes all null values from an object. * @param obj is an object. * @return An object with null values removed.


__fun__ `formatDate (dateStr)`

Formats the provided X12 date (YYYYMMDD) to the * FHIR date format (YYYY-MM-DD). If the provided date * doesn't match the X12 format, it simply returns * what was provided. * @param dateStr is a string with the X12 date to format. * @return A FHIR formatted date or what was passed in * if the X12 format isn't matched.


__fun__ `removeGeneratedIds (data)`

Removed any generated IDs such as GUIDS from the * payload for testing purposes. * @param data is FHIR bundle with the data to remove * IDs from. * @return The FHIR bundle with generated IDs removed.


__fun__ `removeAllInstances (data, fieldNames: Array)`

Recursivly removes all instances of the provided * fieldName within the provided data structure. * @param data is an array or object to remove the * field from. * @param fieldNames is a array of strings with the field * names to remove. * @return The data with the field removed.


__fun__ `getSetHeader (data)`

Gets the first Set Header (ST) line in * the message and returns it. * @param data is a X12 payload. * @return A string with the Set Header line or null.


__fun__ `getXTransactionSetValue (data)`

Gets the x-transaction-set header value to provide * to X12 system API from the provided message. * @param data is a X12 payload. * @return The x-transaction-set header value for * the provided message or an empty string if not * matched.


([back to top](#))

