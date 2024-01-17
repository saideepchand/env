{
  "Errors": [
    
  ],
  "Delimiters": "*:^~",
  "TransactionSets": {
    "v005010X279A1": {
      "271": [
        {
          "Interchange": {
            "ISA09": "2003-01-01T00:00:00-06:00",
            "ISA04": "",
            "ISA15": "T",
            "ISA03": "01",
            "ISA14": "1",
            "ISA02": "",
            "ISA13": 905,
            "ISA01": "00",
            "ISA12": "00501",
            "ISA08": "HCRCV",
            "ISA07": "ZZ",
            "ISA06": "HCACC",
            "ISA05": "ZZ",
            "ISA16": ":",
            "ISA11": "^",
            "ISA10": 46380000
          },
          "Group": {
            "GS05": 28920000,
            "GS04": "1999-12-31T00:00:00-06:00",
            "GS07": "X",
            "GS06": 1,
            "GS08": "005010X279A1",
            "GS01": "HB",
            "GS03": "HCRCV",
            "GS02": "HCACC"
          },
          "Heading": {
            "BHT_BeginningOfHierarchicalTransaction": {
              "BHT02_TransactionSetPurposeCode": "11",
              "BHT04_TransactionSetCreationDate": "2006-05-01T00:00:00-05:00",
              "BHT01_HierarchicalStructureCode": "0022",
              "BHT03_SubmitterTransactionIdentifier": "10001234",
              "BHT05_TransactionSetCreationTime": 47940000
            }
          },
          "SetTrailer": {
            "SE02": "4321",
            "SE01": 28
          },
          "Summary": {
            
          },
          "Id": "271",
          "SetHeader": {
            "ST03": "005010X279A1",
            "ST01": "271",
            "ST02": "4321"
          },
          "Detail": {
            "2000A_Loop": [
              {
                "2000B_Loop": [
                  {
                    "2100B_Loop": {
                      "N3_InformationReceiverAddress": {
                        "N301_InformationReceiverAddressLine": "1200 TEST LANE"
                      },
                      "NM1_InformationReceiverName": {
                        "NM109_InformationReceiverIdentificationNumber": "2000035",
                        "NM101_EntityIdentifierCode": "1P",
                        "NM103_InformationReceiverLastOrOrganizationName": "BONE AND JOINT CLINIC",
                        "NM102_EntityTypeQualifier": "2",
                        "NM108_IdentificationCodeQualifier": "SV"
                      },
                      "N4_InformationReceiverCityStateZIPCode": {
                        "N401_InformationReceiverCityName": "PLEASENTON",
                        "N402_InformationReceiverStateCode": "CA",
                        "N404_CountryCode": "US",
                        "N403_InformationReceiverPostalZoneOrZIPCode": "94568"
                      }
                    },
                    "2000C_Loop": [
                      {
                        "TRN_SubscriberTraceNumber": [
                          {
                            "TRN03_TraceAssigningEntityIdentifier": "9877281234",
                            "TRN01_TraceTypeCode": "2",
                            "TRN02_TraceNumber": "93175-012547"
                          }
                        ],
                        "2100C_Loop": {
                          "DMG_SubscriberDemographicInformation": {
                            "DMG02_SubscriberBirthDate": "19630519",
                            "DMG03_SubscriberGenderCode": "M",
                            "DMG01_DateTimePeriodFormatQualifier": "D8"
                          },
                          "DTP_SubscriberDate": [
                            {
                              "DTP01_DateTimeQualifier": "346",
                              "DTP03_DateTimePeriod": "20220101",
                              "DTP02_DateTimePeriodFormatQualifier": "D8"
                            },
                            {
                              "DTP01_DateTimeQualifier": "347",
                              "DTP03_DateTimePeriod": "20221231",
                              "DTP02_DateTimePeriodFormatQualifier": "D8"
                            }
                          ],
                          "INS_SubscriberRelationship": {
                            "INS02_IndividualRelationshipCode": "18",
                            "INS01_InsuredIndicator": "Y"
                          },
                          "2110C_Loop": [
                            {
                              "EB_SubscriberEligibilityOrBenefitInformation": {
                                "EB03_ServiceTypeCode": [
                                  "30"
                                ],
                                "EB02_BenefitCoverageLevelCode": "IND",
                                "EB01_EligibilityOrBenefitInformation": "1"
                              }
                            },
                            {
                              "2120_Loop": [
                                {
                                  "NM1_SubscriberBenefitRelatedEntityName": {
                                    "NM104_BenefitRelatedEntityFirstName": "MARCUS",
                                    "NM101_EntityIdentifierCode": "P3",
                                    "NM109_BenefitRelatedEntityIdentifier": "0202034",
                                    "NM102_EntityTypeQualifier": "1",
                                    "NM108_IdentificationCodeQualifier": "SV",
                                    "NM103_BenefitRelatedEntityLastOrOrganizationName": "JONES"
                                  }
                                }
                              ],
                              "EB_SubscriberEligibilityOrBenefitInformation": {
                                "EB01_EligibilityOrBenefitInformation": "L"
                              }
                            },
                            {
                              "EB_SubscriberEligibilityOrBenefitInformation": {
                                "EB03_ServiceTypeCode": [
                                  "1",
                                  "33",
                                  "35",
                                  "47",
                                  "86",
                                  "88",
                                  "98",
                                  "AL",
                                  "MH",
                                  "UC"
                                ],
                                "EB02_BenefitCoverageLevelCode": "FAM",
                                "EB01_EligibilityOrBenefitInformation": "1"
                              }
                            },
                            {
                              "EB_SubscriberEligibilityOrBenefitInformation": {
                                "EB04_InsuranceTypeCode": "HM",
                                "EB07_BenefitAmount": 10,
                                "EB12_InPlanNetworkIndicator": "Y",
                                "EB03_ServiceTypeCode": [
                                  "1",
                                  "33",
                                  "35",
                                  "47",
                                  "86",
                                  "88",
                                  "98",
                                  "AL",
                                  "MH",
                                  "UC"
                                ],
                                "EB05_PlanCoverageDescription": "GOLD 123 PLAN",
                                "EB06_TimePeriodQualifier": "27",
                                "EB01_EligibilityOrBenefitInformation": "B"
                              }
                            },
                            {
                              "EB_SubscriberEligibilityOrBenefitInformation": {
                                "EB04_InsuranceTypeCode": "HM",
                                "EB07_BenefitAmount": 30,
                                "EB12_InPlanNetworkIndicator": "N",
                                "EB03_ServiceTypeCode": [
                                  "1",
                                  "33",
                                  "35",
                                  "47",
                                  "86",
                                  "88",
                                  "98",
                                  "AL",
                                  "MH",
                                  "UC"
                                ],
                                "EB05_PlanCoverageDescription": "GOLD 123 PLAN",
                                "EB06_TimePeriodQualifier": "27",
                                "EB01_EligibilityOrBenefitInformation": "B"
                              },
                              "REF_SubscriberAdditionalIdentification": [
                                {
                                  "REF02_SubscriberEligibilityOrBenefitIdentifier": "123456789",
                                  "REF01_ReferenceIdentificationQualifier": "IG"
                                }
                              ]
                            }
                          ],
                          "N3_SubscriberAddress": {
                            "N301_SubscriberAddressLine": "15197 BROADWAY AVENUE",
                            "N302_SubscriberAddressLine": "APT 215"
                          },
                          "NM1_SubscriberName": {
                            "NM109_SubscriberPrimaryIdentifier": "123456789",
                            "NM101_EntityIdentifierCode": "IL",
                            "NM102_EntityTypeQualifier": "1",
                            "NM108_IdentificationCodeQualifier": "MI",
                            "NM104_SubscriberFirstName": "JOHN",
                            "NM103_SubscriberLastName": "SMITH"
                          },
                          "N4_SubscriberCityStateZIPCode": {
                            "N401_SubscriberCityName": "KANSAS CITY",
                            "N402_SubscriberStateCode": "MO",
                            "N403_SubscriberPostalZoneOrZIPCode": "64108"
                          }
                        }
                      }
                    ]
                  }
                ],
                "2100A_Loop": {
                  "NM1_InformationSourceName": {
                    "NM101_EntityIdentifierCode": "PR",
                    "NM103_InformationSourceLastOrOrganizationName": "ABC COMPANY",
                    "NM109_InformationSourcePrimaryIdentifier": "842610001",
                    "NM102_EntityTypeQualifier": "2",
                    "NM108_IdentificationCodeQualifier": "PI"
                  },
                  "PER_InformationSourceContactInformation": [
                    {
                      "PER04_InformationSourceCommunicationNumber": "1112223344",
                      "PER01_ContactFunctionCode": "IC",
                      "PER05_CommunicationNumberQualifier": "EM",
                      "PER03_CommunicationNumberQualifier": "TE",
                      "PER06_InformationSourceCommunicationNumber": "test@payer.com",
                      "PER08_InformationSourceCommunicationNumber": "1234567890",
                      "PER07_CommunicationNumberQualifier": "FX"
                    }
                  ]
                }
              }
            ]
          },
          "Name": "Health Care Eligibility Benefit Response"
        }
      ]
    }
  },
  "FunctionalAcksGenerated": [
    {
      "Interchange": {
        "ISA09": "2022-02-13",
        "ISA04": "",
        "ISA15": "T",
        "ISA03": "01",
        "ISA14": "1",
        "ISA02": "",
        "ISA13": 905,
        "ISA01": "00",
        "ISA12": "00501",
        "ISA08": "HCACC",
        "ISA07": "ZZ",
        "ISA06": "HCRCV",
        "ISA05": "ZZ",
        "ISA16": ":",
        "ISA11": "^",
        "ISA10": 80040000
      },
      "Group": {
        "GS05": 80040000,
        "GS04": "2022-02-13",
        "GS07": "X",
        "GS06": 1,
        "GS08": "005010",
        "GS01": "HB",
        "GS03": "HCACC",
        "GS02": "HCRCV"
      },
      "Heading": {
        "0200_AK1": {
          "AK103": "005010X279A1",
          "AK101": "HB",
          "AK102": 1
        },
        "0700_AK9": {
          "AK903": 1,
          "AK904": 1,
          "AK901": "A",
          "AK902": 1
        }
      },
      "Id": "997",
      "Name": "Functional Acknowledgment"
    }
  ],
  "InterchangeAcksGenerated": [
    {
      "Interchange": {
        "ISA09": "2022-02-13",
        "ISA04": "",
        "ISA15": "T",
        "ISA03": "01",
        "ISA14": "1",
        "ISA02": "",
        "ISA13": 905,
        "ISA01": "00",
        "ISA12": "00501",
        "ISA08": "HCACC",
        "ISA07": "ZZ",
        "ISA06": "HCRCV",
        "ISA05": "ZZ",
        "ISA16": ":",
        "ISA11": "^",
        "ISA10": 80040000
      },
      "TA104": "A",
      "TA105": "000",
      "TA102": "2022-02-13",
      "TA103": 80040000,
      "TA101": 905
    }
  ]
}