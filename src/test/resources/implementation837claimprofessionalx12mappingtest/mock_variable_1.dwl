{
  "TransactionSets": {
    "v005010X222A1": {
      "837": [
        {
          "Heading": {
            "BHT_BeginningOfHierarchicalTransaction": {
              "BHT01_HierarchicalStructureCode": "0019",
              "BHT02_TransactionSetPurposeCode": "00",
              "BHT03_OriginatorApplicationTransactionIdentifier": "5269367",
              "BHT04_TransactionSetCreationDate": "2005-05-02",
              "BHT05_TransactionSetCreationTime": 110100,
              "BHT06_ClaimOrEncounterIdentifier": "CH"
            },
            "1000A_Loop": {
              "NM1_SubmitterName": {
                "NM101_EntityIdentifierCode": "41",
                "NM102_EntityTypeQualifier": "2",
                "NM103_SubmitterLastOrOrganizationName": "DR. JOE SMITH CORPORATION",
                "NM104_SubmitterFirstName": "",
                "NM105_SubmitterMiddleNameorInitial": "",
                "NM106_NamePrefix": "",
                "NM107_NameSuffix": "",
                "NM108_IdentificationCodeQualifier": "46",
                "NM109_SubmitterIdentifier": "UMOExample"
              },
              "PER_SubmitterEDIContactInformation": [
                {
                  "PER01_ContactFunctionCode": "IC",
                  "PER02_SubmitterContactName": "",
                  "PER03_CommunicationNumberQualifier": "TE",
                  "PER04_CommunicationNumber": "(+1) 734-677-5555",
                  "PER05_CommunicationNumberQualifier": "EM",
                  "PER06_CommunicationNumber": "customer-service@acme-clinic.org",
                  "PER07_CommunicationNumberQualifier": "",
                  "PER08_CommunicationNumber": ""
                }
              ]
            },
            "1000B_Loop": {
              "NM1_ReceiverName": {
                "NM101_EntityIdentifierCode": "40",
                "NM102_EntityTypeQualifier": "2",
                "NM103_ReceiverName": "MARYLAND CAPITAL INSURANCE COMPANY",
                "NM104_NameFirst": "",
                "NM105_NameMiddle": "",
                "NM106_NamePrefix": "",
                "NM107_NameSuffix": "",
                "NM108_IdentificationCodeQualifier": "46",
                "NM109_ReceiverPrimaryIdentifier": "InsurerExample"
              }
            }
          },
          "Detail": {
            "2000A_Loop": [
              {
                "2010AA_Loop": {
                  "NM1_BillingProviderName": {
                    "NM101_EntityIdentifierCode": "85",
                    "NM102_EntityTypeQualifier": "2",
                    "NM103_BillingProviderLastOrOrganizationalName": "DR. JOE SMITH CORPORATION",
                    "NM104_BillingProviderFirstName": "",
                    "NM105_BillingProviderMiddleNameorInitial": "",
                    "NM106_NamePrefix": "",
                    "NM107_BillingProviderNameSuffix": "",
                    "NM108_IdentificationCodeQualifier": "XX",
                    "NM109_BillingProviderIdentifier": "UMOExample"
                  },
                  "N3_BillingProviderAddress": {
                    "N301_BillingProviderAddressLine": "111 1ST STREET",
                    "N302_BillingProviderAddressLine": ""
                  },
                  "N4_BillingProviderCityStateZIPCode": {
                    "N401_BillingProviderCityName": "SAN DIEGO",
                    "N402_BillingProviderStateorProvinceCode": "CA",
                    "N403_BillingProviderPostalZoneOrZIPCode": "92101",
                    "N404_CountryCode": "US"
                  },
                  "REF_BillingProviderTaxIdentification": {
                    "REF01_ReferenceIdentificationQualifier": "EI",
                    "REF02_BillingProviderTaxIdentificationNumber": "8189991234"
                  },
                  "PER_BillingProviderContactInformation": [
                    {
                      "PER01_ContactFunctionCode": "IC",
                      "PER02_BillingProviderContactName": "",
                      "PER03_CommunicationNumberQualifier": "TE",
                      "PER04_CommunicationNumber": "(+1) 734-677-5555",
                      "PER05_CommunicationNumberQualifier": "EM",
                      "PER06_CommunicationNumber": "customer-service@acme-clinic.org",
                      "PER07_CommunicationNumberQualifier": "",
                      "PER08_CommunicationNumber": ""
                    }
                  ]
                },
                "2000B_Loop": [
                  {
                    "SBR_SubscriberInformation": {
                      "SBR01_PayerResponsibilitySequenceNumberCode": "P",
                      "SBR02_IndividualRelationshipCode": "18",
                      "SBR03_SubscriberGrouporPolicyNumber": "CoverageIdentifier",
                      "SBR04_SubscriberGroupName": "",
                      "SBR05_InsuranceTypeCode": "",
                      "SBR09_ClaimFilingIndicatorCode": "12"
                    },
                    "2010BA_Loop": {
                      "NM1_SubscriberName": {
                        "NM101_EntityIdentifierCode": "IL",
                        "NM102_EntityTypeQualifier": "1",
                        "NM103_SubscriberLastName": "SMITH",
                        "NM104_SubscriberFirstName": "JOE",
                        "NM105_SubscriberMiddleNameorInitial": "Nathan",
                        "NM106_NamePrefix": "",
                        "NM107_SubscriberNameSuffix": "Kwok",
                        "NM108_IdentificationCodeQualifier": "MI",
                        "NM109_SubscriberPrimaryIdentifier": "UMOExample"
                      },
                      "N3_SubscriberAddress": {
                        "N301_SubscriberAddressLine": "49 Meadow St",
                        "N302_SubscriberAddressLine": "suite 123"
                      },
                      "N4_SubscriberCityStateZIPCode": {
                        "N401_SubscriberCityName": "Mounds",
                        "N402_SubscriberStateCode": "OK",
                        "N403_SubscriberPostalZoneOrZIPCode": "74047",
                        "N404_CountryCode": "US"
                      },
                      "DMG_SubscriberDemographicInformation": {
                        "DMG01_DateTimePeriodFormatQualifier": "D8",
                        "DMG02_SubscriberBirthDate": "19870220",
                        "DMG03_SubscriberGenderCode": "U"
                      }
                    },
                    "2010BB_Loop": {
                      "NM1_PayerName": {
                        "NM101_EntityIdentifierCode": "PR",
                        "NM102_EntityTypeQualifier": "2",
                        "NM103_PayerName": "MARYLAND CAPITAL INSURANCE COMPANY",
                        "NM104_NameFirst": "",
                        "NM105_NameMiddle": "",
                        "NM106_NamePrefix": "",
                        "NM107_NameSuffix": "",
                        "NM108_IdentificationCodeQualifier": "PI",
                        "NM109_PayerIdentifier": "InsurerExample"
                      }
                    },
                    "2000C_Loop": [
                      {
                        "PAT_PatientInformation": {
                          "PAT01_IndividualRelationshipCode": "01"
                        },
                        "2010CA_Loop": {
                          "NM1_PatientName": {
                            "NM101_EntityIdentifierCode": "QC",
                            "NM102_EntityTypeQualifier": "1",
                            "NM103_PatientLastName": "SMITH",
                            "NM104_PatientFirstName": "JOE",
                            "NM105_PatientMiddleNameorInitial": "Nathan",
                            "NM106_NamePrefix": "",
                            "NM107_PatientNameSuffix": "Kwok",
                            "NM108_IdentificationCodeQualifier": "MI",
                            "NM109_IdentificationCode": ""
                          },
                          "N3_PatientAddress": {
                            "N301_PatientAddressLine": "49 Meadow St",
                            "N302_PatientAddressLine": "suite 123"
                          },
                          "N4_PatientCityStateZIPCode": {
                            "N401_PatientCityName": "Mounds",
                            "N402_PatientStateCode": "OK",
                            "N403_PatientPostalZoneOrZIPCode": "74047",
                            "N404_CountryCode": "US"
                          },
                          "DMG_PatientDemographicInformation": {
                            "DMG01_DateTimePeriodFormatQualifier": "D8",
                            "DMG02_PatientBirthDate": "19870220",
                            "DMG03_PatientGenderCode": "U"
                          },
                          "REF_PropertyAndCasualtyPatientIdentifier": {
                            "REF01_ReferenceIdentificationQualifier": "SY",
                            "REF02_PropertyAndCasualtyPatientIdentifier": "3333333333"
                          }
                        }
                      }
                    ]
                  }
                ]
              }
            ]
          },
          "Summary": {}
        }
      ]
    }
  }
}