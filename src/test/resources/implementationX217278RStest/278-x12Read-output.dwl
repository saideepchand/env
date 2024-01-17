{
  "Errors": [
    
  ],
  "Delimiters": "*:^~",
  "TransactionSets": {
    "v005010X217": {
      "278": [
        {
          "Interchange": {
            "ISA09": "2003-01-01T00:00:00-05:00",
            "ISA04": "",
            "ISA15": "T",
            "ISA03": "01",
            "ISA14": "1",
            "ISA02": "",
            "ISA13": 905,
            "ISA01": "00",
            "ISA12": "00501",
            "ISA08": "RECEIVERSID",
            "ISA07": "ZZ",
            "ISA06": "SUBMITTERSID",
            "ISA05": "ZZ",
            "ISA16": ":",
            "ISA11": "^",
            "ISA10": 46380000
          },
          "Group": {
            "GS05": 28920000,
            "GS04": "1999-12-31T00:00:00-05:00",
            "GS07": "X",
            "GS06": 1,
            "GS08": "005010X217",
            "GS01": "HI",
            "GS03": "RECEIVER CODE",
            "GS02": "SENDER CODE"
          },
          "Heading": {
            "BHT_BeginningOfHierarchicalTransaction": {
              "BHT02_TransactionSetPurposeCode": "11",
              "BHT04_TransactionSetCreationDate": "2005-05-02T00:00:00-04:00",
              "BHT06_TransactionTypeCode": "18",
              "BHT01_HierarchicalStructureCode": "0007",
              "BHT03_SubmitterTransactionIdentifier": "75b9b112-f00e-49f3-bb35-2869d5b73f27",
              "BHT05_TransactionSetCreationTime": 52260000
            }
          },
          "SetTrailer": {
            "SE02": "0001",
            "SE01": 33
          },
          "Summary": {
            
          },
          "Id": "278",
          "SetHeader": {
            "ST03": "005010X217",
            "ST01": "278",
            "ST02": "0001"
          },
          "Detail": {
            "2000A_Loop": {
              "2000B_Loop": {
                "2000C_Loop": {
                  "2000E_Loop": [
                    {
                      "HSD_HealthCareServicesDelivery1": {
                        "HSD02_ServiceUnitCount": 5,
                        "HSD01_QuantityQualifier": "DY"
                      },
                      "UM_HealthCareServicesReviewInformation1": {
                        "UM02_CertificationTypeCode": "I",
                        "UM03_ServiceTypeCode": "2",
                        "UM04_HealthCareServiceLocationInformation": {
                          "UM01_FacilityTypeCode": "21",
                          "UM02_FacilityCodeQualifier": "B"
                        },
                        "UM01_RequestCategoryCode": "AR"
                      },
                      "TRN_PatientEventTrackingNumber": [
                        {
                          "TRN03_TraceAssigningEntityIdentifier": "9012345678",
                          "TRN01_TraceTypeCode": "2",
                          "TRN02_PatientEventTraceNumber": "97021001"
                        }
                      ],
                      "2010EA_Loop": [
                        {
                          "NM1_PatientEventProviderName": {
                            "NM106_PatientEventProviderNamePrefix": "Dr.",
                            "NM101_EntityIdentifierCode": "71",
                            "NM102_EntityTypeQualifier": "1",
                            "NM108_IdentificationCodeQualifier": "XX",
                            "NM104_PatientEventProviderFirstName": "Jane Betty",
                            "NM103_PatientEventProviderLastOrOrganizationName": "Doe",
                            "NM109_PatientEventProviderIdentifier": "1122334455"
                          },
                          "PER_ProviderContactInformation": {
                            "PER01_ContactFunctionCode": "IC",
                            "PER05_CommunicationNumberQualifier": "EM",
                            "PER04_PatientEventProviderContactCommunicationsNumber": "716-873-1557",
                            "PER03_CommunicationNumberQualifier": "TE",
                            "PER06_PatientEventProviderContactCommunicationsNumber": "jane.betty@myhospital.com"
                          },
                          "N3_PatientEventProviderAddress": {
                            "N301_PatientEventProviderAddressLine": "840 Seneca St"
                          },
                          "N4_PatientEventProviderCityStateZIPCode": {
                            "N403_PatientEventProviderPostalZoneOrZIPCode": "14210",
                            "N402_PatientEventProviderStateCode": "NY",
                            "N401_PatientEventProviderCityName": "Buffalo"
                          }
                        }
                      ],
                      "HCR_HealthCareServicesReview1": {
                        "HCR01_ActionCode": "A3",
                        "HCR02_ReviewIdentificationNumber": "AUTH0002"
                      },
                      "DTP_AdmissionDate": {
                        "DTP01_DateTimeQualifier": "435",
                        "DTP03_ProposedOrActualAdmissionDate": "20050516",
                        "DTP02_DateTimePeriodFormatQualifier": "D8"
                      },
                      "CL1_InstitutionalClaimCode": {
                        "CL103_PatientStatusCode": "1",
                        "CL101_AdmissionTypeCode": "3"
                      },
                      "DTP_CertificationEffectiveDate": {
                        "DTP03_CertificationEffectiveDate": "20211101",
                        "DTP01_DateTimeQualifier": "007",
                        "DTP02_DateTimePeriodFormatQualifier": "D8"
                      },
                      "2000F_Loop": [
                        {
                          "HCR_HealthCareServicesReview": {
                            "HCR01_ActionCode": "A1",
                            "HCR02_ReviewIdentificationNumber": "AUTH0002"
                          },
                          "DTP_ServiceDate": {
                            "DTP03_ProposedOrActualServiceDate": "20050516",
                            "DTP01_DateTimeQualifier": "472",
                            "DTP02_DateTimePeriodFormatQualifier": "D8"
                          },
                          "SV2_InstitutionalServiceLine": {
                            "SV202_CompositeMedicalProcedureIdentifier": {
                              "SV202_ProcedureCode": "97111",
                              "SV201_ProductOrServiceIDQualifier": "HC"
                            },
                            "SV205_ServiceUnitCount": 1,
                            "SV201_ServiceLineRevenueCode": "300",
                            "SV203_ServiceLineAmount": 73.42,
                            "SV204_UnitOrBasisForMeasurementCode": "UN"
                          }
                        },
                        {
                          "HCR_HealthCareServicesReview": {
                            "HCR01_ActionCode": "A1",
                            "HCR02_ReviewIdentificationNumber": "AUTH0002"
                          },
                          "DTP_ServiceDate": {
                            "DTP03_ProposedOrActualServiceDate": "20050516",
                            "DTP01_DateTimeQualifier": "472",
                            "DTP02_DateTimePeriodFormatQualifier": "D8"
                          },
                          "SV2_InstitutionalServiceLine": {
                            "SV202_CompositeMedicalProcedureIdentifier": {
                              "SV202_ProcedureCode": "97111",
                              "SV201_ProductOrServiceIDQualifier": "HC"
                            },
                            "SV205_ServiceUnitCount": 1,
                            "SV201_ServiceLineRevenueCode": "300",
                            "SV203_ServiceLineAmount": 73.42,
                            "SV204_UnitOrBasisForMeasurementCode": "UN"
                          }
                        }
                      ],
                      "HI_PatientDiagnosis": {
                        "HI01_HealthCareCodeInformation": {
                          "HI02_DiagnosisCode": "F99",
                          "HI03_DateTimePeriodFormatQualifier": "D8",
                          "HI04_DiagnosisDate": "20050125",
                          "HI01_DiagnosisTypeCode": "BF"
                        }
                      },
                      "DTP_CertificationIssueDate": {
                        "DTP03_CertificationIssueDate": "20211101",
                        "DTP01_DateTimeQualifier": "102",
                        "DTP02_DateTimePeriodFormatQualifier": "D8"
                      }
                    }
                  ],
                  "2010C_Loop": {
                    "N3_SubscriberMailingAddress": {
                      "N301_SubscriberAddressLine": "11951 Freedom Drive Suite 1322"
                    },
                    "NM1_SubscriberName": {
                      "NM109_SubscriberPrimaryIdentifier": "10A3D58WH22",
                      "NM101_EntityIdentifierCode": "IL",
                      "NM102_EntityTypeQualifier": "1",
                      "NM108_IdentificationCodeQualifier": "MI",
                      "NM104_SubscriberFirstName": "Vlad Alan Nestor",
                      "NM103_SubscriberLastName": "Quinton"
                    },
                    "N4_SubscriberCityStateZIPCode": {
                      "N401_SubscriberCityName": "Reston",
                      "N402_SubscriberStateCode": "VA",
                      "N403_SubscriberPostalZoneOrZIPCode": "20190"
                    }
                  }
                },
                "2010B_Loop": [
                  {
                    "NM1_RequesterName": {
                      "NM101_EntityIdentifierCode": "1P",
                      "NM102_EntityTypeQualifier": "1",
                      "NM108_IdentificationCodeQualifier": "XX",
                      "NM103_RequesterLastOrOrganizationName": "WATSON",
                      "NM104_RequesterFirstName": "SUSAN",
                      "NM109_RequesterIdentifier": "1871507863"
                    }
                  }
                ]
              },
              "2010A_Loop": {
                "NM1_UtilizationManagementOrganizationUMOName": {
                  "NM109_UtilizationManagementOrganizationUMOIdentifier": "SCXIX",
                  "NM101_EntityIdentifierCode": "X3",
                  "NM102_EntityTypeQualifier": "2",
                  "NM108_IdentificationCodeQualifier": "46",
                  "NM103_UtilizationManagementOrganizationUMOLastOrOrganizationName": "MARYLAND CAPITAL INSURANCE COMPANY"
                }
              }
            }
          },
          "Name": "Health Care Services Review Information"
        }
      ]
    }
  },
  "FunctionalAcksGenerated": [
    {
      "Interchange": {
        "ISA09": "2022-03-08",
        "ISA04": "",
        "ISA15": "T",
        "ISA03": "01",
        "ISA14": "1",
        "ISA02": "",
        "ISA13": 905,
        "ISA01": "00",
        "ISA12": "00501",
        "ISA08": "SUBMITTERSID",
        "ISA07": "ZZ",
        "ISA06": "RECEIVERSID",
        "ISA05": "ZZ",
        "ISA16": ":",
        "ISA11": "^",
        "ISA10": 49200000
      },
      "Group": {
        "GS05": 49200000,
        "GS04": "2022-03-08",
        "GS07": "X",
        "GS06": 1,
        "GS08": "005010",
        "GS01": "HI",
        "GS03": "SENDER CODE",
        "GS02": "RECEIVER CODE"
      },
      "Heading": {
        "0200_AK1": {
          "AK103": "005010X217",
          "AK101": "HI",
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
        "ISA09": "2022-03-08",
        "ISA04": "",
        "ISA15": "T",
        "ISA03": "01",
        "ISA14": "1",
        "ISA02": "",
        "ISA13": 905,
        "ISA01": "00",
        "ISA12": "00501",
        "ISA08": "SUBMITTERSID",
        "ISA07": "ZZ",
        "ISA06": "RECEIVERSID",
        "ISA05": "ZZ",
        "ISA16": ":",
        "ISA11": "^",
        "ISA10": 49200000
      },
      "TA104": "A",
      "TA105": "000",
      "TA102": "2022-03-08",
      "TA103": 49200000,
      "TA101": 905
    }
  ]
}