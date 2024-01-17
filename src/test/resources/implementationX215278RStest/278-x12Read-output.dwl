{
  "Errors": [
    
  ],
  "Delimiters": "*:^~",
  "TransactionSets": {
    "v005010X215": {
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
            "GS08": "005010X215",
            "GS01": "HI",
            "GS03": "RECEIVER CODE",
            "GS02": "SENDER CODE"
          },
          "Heading": {
            "BHT_BeginningOfHierarchicalTransaction": {
              "BHT02_TransactionSetPurposeCode": "49",
              "BHT04_TransactionSetCreationDate": "2005-08-09T00:00:00-04:00",
              "BHT06_TransactionTypeCode": "RD",
              "BHT01_HierarchicalStructureCode": "0007",
              "BHT03_SubmitterTransactionIdentifier": "B67890",
              "BHT05_TransactionSetCreationTime": 40320000
            }
          },
          "SetTrailer": {
            "SE02": "0001",
            "SE01": 27
          },
          "Summary": {
            
          },
          "Id": "278",
          "SetHeader": {
            "ST03": "005010X215",
            "ST01": "278",
            "ST02": "0001"
          },
          "Detail": {
            "2000A_Loop": {
              "2000B_Loop": {
                "2000C_Loop": [
                  {
                    "2000E_Loop": [
                      {
                        "HSD_HealthCareServicesDelivery1": {
                          "HSD02_ServiceUnitCount": 1,
                          "HSD01_QuantityQualifier": "VS"
                        },
                        "UM_HealthCareServicesReviewInformation1": {
                          "UM03_ServiceTypeCode": "3",
                          "UM04_HealthCareServiceLocationInformation": {
                            "UM01_FacilityTypeCode": "11",
                            "UM02_FacilityCodeQualifier": "B"
                          },
                          "UM01_RequestCategoryCode": "SC"
                        },
                        "TRN_PatientEventTrackingNumber": [
                          {
                            "TRN03_TraceAssigningEntityIdentifier": "9012345678",
                            "TRN01_TraceTypeCode": "1",
                            "TRN02_PatientEventTraceNumber": "20050809"
                          },
                          {
                            "TRN03_TraceAssigningEntityIdentifier": "9012345678",
                            "TRN01_TraceTypeCode": "2",
                            "TRN02_PatientEventTraceNumber": "20050809"
                          }
                        ],
                        "DTP_EventDate": {
                          "DTP01_DateTimeQualifier": "AAH",
                          "DTP03_ProposedOrActualEventDate": "20050901-20050930",
                          "DTP02_DateTimePeriodFormatQualifier": "RD8"
                        },
                        "2010EA_Loop": [
                          {
                            "NM1_PatientEventProviderName": {
                              "NM101_EntityIdentifierCode": "SJ",
                              "NM102_EntityTypeQualifier": "1",
                              "NM108_IdentificationCodeQualifier": "34",
                              "NM104_PatientEventProviderFirstName": "SUSAN",
                              "NM103_PatientEventProviderLastOrOrganizationName": "WATSON",
                              "NM109_PatientEventProviderIdentifier": "987654321"
                            }
                          }
                        ],
                        "HCR_HealthCareServicesReview1": {
                          "HCR01_ActionCode": "A1",
                          "HCR02_ReviewIdentificationNumber": "AUTH0001"
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
                              "HCR02_ReviewIdentificationNumber": "AUTH0003"
                            },
                            "DTP_CertificationExpirationDate": {
                              "DTP01_DateTimeQualifier": "036",
                              "DTP03_CertificationExpirationDate": "20050523",
                              "DTP02_DateTimePeriodFormatQualifier": "D8"
                            },
                            "TRN_ServiceTraceNumber": [
                              {
                                "TRN03_TraceAssigningEntityIdentifier": "9012345678",
                                "TRN02_ServiceTraceNumber": "20050809",
                                "TRN01_TraceTypeCode": "1"
                              }
                            ],
                            "SV2_InstitutionalServiceLine": {
                              "SV202_CompositeMedicalProcedureIdentifier": {
                                "SV202_ProcedureCode": "97111",
                                "SV201_ProductOrServiceIDQualifier": "HC"
                              },
                              "SV205_ServiceUnitCount": 1,
                              "SV201_ServiceLineRevenueCode": "300",
                              "SV203_ServiceLineAmount": 73.42,
                              "SV204_UnitOrBasisForMeasurementCode": "UN"
                            },
                            "DTP_CertificationIssueDate": {
                              "DTP03_CertificationIssueDate": "20050516",
                              "DTP01_DateTimeQualifier": "102",
                              "DTP02_DateTimePeriodFormatQualifier": "D8"
                            }
                          }
                        ]
                      }
                    ],
                    "2010C_Loop": {
                      "NM1_SubscriberName": {
                        "NM109_SubscriberPrimaryIdentifier": "12345678901",
                        "NM101_EntityIdentifierCode": "IL",
                        "NM102_EntityTypeQualifier": "1",
                        "NM108_IdentificationCodeQualifier": "MI",
                        "NM104_SubscriberFirstName": "JOE",
                        "NM103_SubscriberLastName": "SMITH"
                      }
                    }
                  }
                ],
                "2010B_Loop": [
                  {
                    "NM1_RequesterName": {
                      "NM101_EntityIdentifierCode": "1P",
                      "NM102_EntityTypeQualifier": "1",
                      "NM108_IdentificationCodeQualifier": "34",
                      "NM103_RequesterLastOrOrganizationName": "WATSON",
                      "NM104_RequesterFirstName": "SUSAN",
                      "NM109_RequesterIdentifier": "987654321"
                    }
                  }
                ]
              },
              "2010A_Loop": {
                "NM1_UtilizationManagementOrganizationUMOName": {
                  "NM109_UtilizationManagementOrganizationUMOIdentifier": "789312",
                  "NM101_EntityIdentifierCode": "X3",
                  "NM102_EntityTypeQualifier": "2",
                  "NM108_IdentificationCodeQualifier": "46",
                  "NM103_UtilizationManagementOrganizationUMOLastOrOrganizationName": "MARYLAND CAPITAL INSURANCE COMPANY"
                }
              }
            }
          },
          "Name": "Health Care Services Review Information - Response"
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
        "ISA10": 63060000
      },
      "Group": {
        "GS05": 63060000,
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
          "AK103": "005010X215",
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
        "ISA10": 63060000
      },
      "TA104": "A",
      "TA105": "000",
      "TA102": "2022-03-08",
      "TA103": 63060000,
      "TA101": 905
    }
  ]
}