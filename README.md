# hls-fhir-to-x12-sys-api

This asset is a component of MuleSoft Accelerator for Healthcare

## Overview

This integration template implements the [FHIR R4 - X12 System API](https://anypoint.mulesoft.com/exchange/org.mule.examples/hls-fhir-r4-to-x12-sys-api-spec) specification.

It supports the below listed messages:

- `FHIR to X12` - Health Care Claim FHIR Bundle to EDI X12 837 with Version/Release 005010 transaction.
- `FHIR to X12` - Eligibility, Coverage or Benefit Inquiry FHIR Bundle to EDI X12 270 with Version/Release 005010 transaction.
- `FHIR to X12` - Prior Authorization Submission FHIR Bundle to EDI X12 278 and 275 (attachments) with Version/Release 005010 transaction.
- `FHIR to X12` - Prior Authorization Inquiry FHIR Bundle to EDI X12 278I with Version/Release 005010X215 transaction.
- `X12 to FHIR` - EDI X12 278 with Version/Release 005010 transaction to Prior Authorization Submission Response FHIR Bundle.
- `X12 to FHIR` - EDI X12 278I with Version/Release 005010 transaction to Prior Authorization Inquiry Response FHIR Bundle.
- `X12 to FHIR` - EDI X12 271 with Version/Release 005010 transaction to Eligibility, Coverage, or Benefit Information FHIR Bundle.


# Setup guide

## Importing Templates into Anypoint Studio

1. In Studio, click the Exchange **X** icon in the upper left of the taskbar.
2. Log in with your Anypoint Platform credentials.
3. Search for the template.
4. Click **Open**.

## Running Templates in Anypoint Studio

After you import your template into Studio, follow these configuration steps to run it.

### FHIR to X12 Converter Application Configuration

The application requires a few things to be configured, mainly the system API connection
information. Configure them in the properties file located in the `config/properties` folder.

- `mule.env` is the environment where the application is to be deployed. For a studio deployment, the recommended mule.env value is `local`.
- `mule.key` is the encryption key for securing sensitive properties.
- `transaction.identifiers.*` are the values that can be customized based on your organizations requirements. See the config file for details.


Please refer to the attached [link](https://docs.mulesoft.com/mule-runtime/4.4/secure-configuration-properties) on how to secure the configuration properties.

### API Manager Configuration - Optional
If there is a need to enforce certain policies i.e. security/usage/service, manage the API from API Manager to enable policies for the API. To support this, an entry in the property file is required to bind API Manager proxy with the  Mule Runtime deployment using an API ID.
Refer to instructions from [link](https://docs.mulesoft.com/api-manager/2.x/using-policies) for guidance on applying policies.

- `api.autodiscoveryId` - sets the API ID from API Manager to bind proxy to runtime.

### HTTPS Configuration

- `https.host` — sets the service host interface. It should be configured in `config-<mule.env>.yaml` file. (Defaults to 0.0.0.0 for all interfaces)
- `https.port` — sets the HTTPS service port number. It should be configured in `config-<mule.env>.yaml` file. (Default 8082)
- TLS Configuration - Keystore properties setup:
    - `keystore.alias` - sets the alias to the keystore. It should be configured in `config-<mule.env>.yaml` file.
    - `keystore.path` - sets the path to the key file. Key should be available in /src/main/resources/keystore. It should be configured in `config-<mule.env>.yaml` file.
    - `keystore.keypass` — sets keystore keypass to support HTTPS operation. It should be encrypted and configured in `config-secured-<mule.env>.yaml` file.
    - `keystore.password`— sets keystore password to support HTTPS operation. It should be encrypted and configured in `config-secured-<mule.env>.yaml` file.

Please refer to the attached [link](https://docs.mulesoft.com/mule-runtime/4.4/tls-configuration) on how to generate the Keystore.

## Tested and verified
This solution was developed and tested on Anypoint Studio 7.13.0 and Mule Runtime 4.4.0. The X12 connector (v 2.9.0) was used for message parsing
Schemas used for genrating the X12 transaction sets are available within the connector's jar file (x12-schemas- 2.8.8.jar's hipaa folder)
Refer to the documentation [here](https://docs.mulesoft.com/x12-edi-connector/2.7/x12-edi-connector-hipaa) for a complete list of supported versions and transactions

## Assumptions and Constraints
Working with manufactured data sets results in us imposing a few constraints and making certain assumptions on a few segments/objects. Details of the constraints are mentioned below.
 1. FHIR Coverage Eligibility Request to X12 270
	- HI Segment - Mapped first two diagnosis codes from the first iteration of CoverageEligibilityRequest's item array. Please extend this to cover more diagnosis codes if the data is available and if dictated by the circumstances.
    - EQ Segment - Mapped EQ01 to "30", which implies the inquiry is to Health Benefit Plan Coverage more generally, instead of specific type of care inquiry.
    - EQ Segment - EQ05 Diagnosis Pointer, following the constraint for HI segment, only one instance of the pointer is set to identify the diagnosis from the first occurrence of an item.
2. X12 271 to FHIR Coverage Eligibility Response
    - For each of the 2000 Loops, we are mapping the first occurrence due to the availability of data. Code can be extended to call the same function within a map operator, to create multiple Organization/Practitioners as needed.
    - Identifiers for each FHIR resource are created using a generic prefix and uuid(). Replace with identifiers more appropriate for the use case as required.
    - Coverage Eligibility Response insurance  - Only one insurance is assumed in the X12 271 segment and mapped as an array of one.
    - Coverage Eligibility Response item - Mapped EB segment without the instance for EB01=="L", as it is not supported in X12. Refer to comments in provided mapping spec for details.
    - Coverage Eligibility Response benefit - Mapped copay as a percentage due to limited data availability. If copay amount is available, code needs to be updated to use allowedMoney too.
3. FHIR Coverage Eligibility Request to X12 837
    - BH Segment - Mapped BHT06 to 'CH' (Chargeable) - Use CH when the transaction contains only fee for service claims or claims with at least one chargeable line item. If it is not clear whether a transaction contains claims or capitated encounters, or if the transaction contains a mix of claims and capitated encounters, use CH.
    - SBR Segment inside the 2000B Loop - Mapped SBR09 to "ZZ" (Mutually Defined) - Use Code ZZ when Type of Insurance is not known.
    - PAT Segment - Ignored the PAT06 - It implies the X12 result doesn't contain deceased datetime.
    - PAT Segment - Ignored the PAT07 and PAT08 - It implies the X12 result doesn't contain patient weight.
    - PAT Segment - Ignored the PAT09 - It implies the X12 result doesn't contain pregnancy indicator.

### Running it

1. Right-click the template project folder.
2. Hover your mouse over 'Run as'.
3. Click **Mule Application** (configure).
4. Inside the dialog, select Environment and set the variable mule.env to the appropriate value (e.g., dev or local).
5. Inside the dialog, select Environment and set the variable mule.key to the property encryption key that you used to encrypt your secure properties.
6. Inside the dialog, go to 'Clear Application Data' select 'always' radio button.
7. In the Arguments tab in VM arguments text area, disable the gatekeeper to test locally using the arguments `-Danypoint.platform.gatekeeper=disabled`. When API Autodiscovery/API Manager configuration are used, gatekeeper needs to be disabled to run the API locally. Refer to documentation [here](https://help.mulesoft.com/s/article/API-returns-503-Service-Unavailable-error-to-clients) for details.
8. Click **Run**.

## Deployment instructions for CloudHub using provided scripts

Ensure the Maven profile `CloudHub-DEV` has been properly configured in your `settings.xml` file. Reference can be found by downloading the [Accelerator Common Resources](https://anypoint.mulesoft.com/exchange/org.mule.examples/accelerator-common-resources-src/) asset. Additional instructions are available in the [Getting Started with MuleSoft Accelerators - Build Environment](https://docs.mulesoft.com/accelerators-home/build-environment) guide.

Update the config-<env>.yaml properties appropriately and then use one of the following scripts to deploy the application to CloudHub:

- packageDeploy.sh or deployOnly.sh (Mac/Linux)
- packageDeploy.cmd or deployOnly.cmd (Windows)

## Test the template

- Use [Advanced Rest Client](https://install.advancedrestclient.com/install) or [Postman](https://www.postman.com/) to send a request over HTTPS. The template includes a Postman collection in the `src/test/resources` folder. Update the collection variable(s) after successful import.
