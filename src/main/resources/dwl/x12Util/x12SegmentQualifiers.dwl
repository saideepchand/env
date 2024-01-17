/**
 * This module implements X12 segment qualifier functions.
 */
 %dw 2.0

 /**
  * Gets the segment qualifiers for the 270, 278Submit, 278Inquiry, 275Submit and 837 transactions.
  * @return A map of segment qualifiers.
  */
  
 fun getSegmentQualifiers() = 
 {
 	"270" : {
 		"BHT" : {
 			"BHT_BeginningOfHierarchicalTransaction" : {
 				"bht01" : "0022",
 				"bht02" : "13",
 			}
 		},
 		"NM1" : {
 			"NM1_InformationSourceName" : {
 				"nm101" : "PR",
 				"nm102" : "2",
 				"nm108" : "PI"
 			},
 			"NM1_InformationReceiverName" : {
 				"nm101" : "1P",
 				"nm102" : "2",
 				"nm108" : "SV"
 			},
 			"NM1_SubscriberName" : {
 				"nm101" : "IL",
 				"nm102" : "1",
 				"nm108" : "II"
 			},
 			"NM1_DependentName" : {
 				"nm101" : "03",
 				"nm102" : "1",
 			}
 		},
 		"REF" : {
 			"REF_SubscriberAdditionalIdentification" : {
 				"ref01" : "1L"
 			}
 		},
 		"DMG" : {
 			"DMG_SubscriberDemographicInformation" : {
 				"dmg01" : "D8"
 			}
 		},
 		"INS" : {
 			"INS_DependentRelationship" : {
 				"ins01" : "N"
 			}
 		},
 		"HI" : {
 			"HI_SubscriberHealthCareDiagnosisCode" : {
 				"hi101" : "ABK",
 				"hi201" : "ABF"
 			}
 		},
 		"EQ" : {
 			"EQ_SubscriberEligibilityOrBenefitInquiry" : {
 				"eq01" : "30"
 				
 			}
 		} 
	
 	},
 	"837" : {
     "BHT" : {
       "BHT_BeginningOfHierarchicalTransaction" : {
         "bht01" : "0019",
         "bht02" : "00",
       }
     },
     "NM1" : {
       "NM1_SenderInformation" : {
         "nm101" : "41",
         "nm108" : "46" 
       },
       "NM1_ReceiverInformation" : {
         "nm101" : "40",
         "nm102" : "2",
         "nm108" : "46"
       },
       "NM1_BillingProviderInformation" : {
         "nm101" : "85",
         "nm108" : "XX"			
       },
       "NM1_SubscriberName" : {
         "nm101" : "IL",
         "nm102" : "1",
         "nm108" : "MI"	
       },
       "NM1_PayerInformation" : {
         "nm101" : "PR",
         "nm102" : "2"	
       },
       "NM1_PatientName" : {
         "nm101" : "QC",
         "nm102" : "1"	
       }       
     },

     "PER" : {
       "PER_SenderContactInformation" : {
         "per01" : "IC"
       },
       "PER_Billing ProviderContactInformation" : {
         "per01" : "IC"
       }
     },
     
     "SBR" : {
       "SBR_SubscriberInformation" : {
         "SBR02" : "18"
       }
     },     
     "PAT" : {
       "PAT_PatientInformation" : {
         "PAT05" : "D8",
         "PAT07" : "01"
       }
     },   
     
     "DMG" : {
       "DMG_SubscriberDemographicInformation" : {
         "dmg01" : "D8"
       },
       "DMG_PatientDemographicInformation" : {
         "dmg01" : "D8"
       }       
     }
   },
   
   "278Submit" : {
     "BHT" : {
       "BHT_BeginningOfHierarchicalTransaction" : {
         "bht01" : "0007",
         "bht02" : "13",
       }
     },
     "NM1" : {
       "NM1_UtlizationManagementOrganziation" : {
         "nm101" : "PR",
         "nm102" : "2",
         "nm108" : "PI" 
       },
       "NM1_RequesterName" : {
         "nm101" : "1P",
         "nm102" : "2",
         "nm108" : "XX"
       },
       "NM1_SubscriberName" : {
         "nm101" : "IL",
         "nm102" : "1",
         "nm108" : "MI"			
       },
       "NM1_DependentName" : {
         "nm101" : "QC",
         "nm102" : "1"
       }
     },
     "DTP" : {
       "DTP_EventDate" : {
         "dtp01" : "AAH"
       },
       "DTP_AdmissionDate" : {
         "dtp01" : "435"
       },
       "DTP_AccidentDate" : {
         "dtp01" : "439",
         "dtp02" : "D8"
       },
       "DTP_ServiceDate" : {
         "dtp01" : "472"
       },
       "DTP_DischargeDate" : {
         "dtp01" : "096"
       }			
     },
     "TRN" : {
       "TRN_PatientEventTrackingNumber" : {
         "trn01" : "1",
         "trn03" : "9"
       },
       "TRN_ServiceTraceNumber" : {
       	"trn01" : "1"
       }	
     },
     "UM" : {
       "UM_HealthCareServicesReviewInformation1" : {
         "um01" : "HS",
         "um02" : "I",
         "um0401" : "11",
         "um0402" : "A"
       }
     },
     "PER" : {
       "PER_RequesterContactInformation" : {
         "per01" : "IC",
         "per03" : "TE",
         "per05" : "TE",
         "per07" : "TE"
       }
     },
     "DMG" : {
       "DMG_SubscriberDemographicInformation" : {
         "dmg01" : "D8"
       },
       "DMG_DependentDemographicInformation" : {
         "dmg01" : "D8"
       }
     },
     "INS" : {
       "INS_SubscriberRelationship" : {
         "ins01" : "Y",
         "ins02" : "18"
       },
       "INS_DependentRelationship" : {
         "ins01" : "N"
       }
     },
     "SV1" : {
       "SV1_ProfessionalService" : {
         "sv101" : "HC",
         "sv111" : "Y"
       }
     },
     "SV2" : {
       "SV2_InstitutionalServiceLine" : {
         "sv209": "8",
         "sv210": "8"
       }
       
     },
     "REF" : {
       "REF_PreviousReviewAuthorizationNumber" : {
         "ref01" : "BB"
       },
       "REF_PreviousReviewAdministrativeReferenceNumber" : {
         "ref01" : "NT"
       }
     },
     "PRV" : {
       "PRV_PatientEventProviderInformation" : {
         "prv02" : "PXC"
       }
     },
     "PWK" : {
       "PWK_AdditionalPatientInformation" : {
         "pwk01" : "77",
         "pwk02" : "EL",
         "pwk05" : "AC"
       }
     }
   },
   "275Submit" : {
     "NM1" : {
       "NM1_PayerName" : {
         "nm101" : "PR",
         "nm102" : "2",
         "nm108" : "PI"			
       },
       "NM1_SubmitterInformation" : {
         "nm101" : "41",
         "nm102" : "2",
         "nm108" : "46"						
       },
       "NM1_ProviderNameInformation" : {
         "nm101" : "1P",
         "nm102" : "1",
         "nm108" : "XX"									
       },
       "NM1_PatientName" : {
         "nm101" : "QC",
         "nm102" : "1",
         "nm108" : "MI"												
       }			
     },
     "BGN" : {
       "BGN_BeginningSegment" : {
         "bgn01" : "02"
       }
     },
     "PRV" : {
       "PRV_ProviderTaxonomyInformation" : {
       "prv01" : "BI",
       "prv02" : "PXC"
       }
     },
     "NX1" : {
       "NX1_ProviderIdentification" : {
         "nx101" : "1P"
       }
     },
     "REF" : {
       "REF_PatientControlNumber" : {
         "ref01" : "EJ"
       },
       "REF_MedicalRecordIdentificationNumber" : {
         "ref01" : "EA"
       },
       "REF_ClaimIdentificationNumberFor" : {
         "ref01" : "D9"
       }
     },
     "DTP" : {
       "DTP_ClaimServiceDate" : {
         "dtp01" : "472",
         "dtp02-RD8" : "RD8",
         "dtp02-D8" : "D8"
       },
       "DTP_ServiceLineDateOfService" : {
         "dtp01" : "472",
         "dtp02-RD8" : "RD8",
         "dtp02-D8" : "D8"
       },
       "DTP_AdditionalInformationSubmissionDate" : {
         "dtp01" : "368",
         "dtp02" : "D8"
       }
     },
     "CAT" : {
       "CAT_CategoryOfPatientInformationService" : {
         "cat01" : "AE",
         "cat02" : "TX"
       }
     },
     "LX" : {
       "LX_AssignedNumber" : {
         lx01: 1
       }
     },
     "TRN" : {
       "TRN_PayerClaimControlNumberProviderAttachmentControlNumber" : {
         "trn01": "1"
       }
     },
     "EFI" : {
       "EFI_ElectronicFormatIdentification" : {
         "efi01" : "05"
       }
     }
   },
   "278Inquiry" : {
		"BHT" : {
			"BHT_BeginningOfHierarchicalTransaction" : {
				"bht01" : "0007",
				"bht02" : "28",
			}
		},
		"NM1" : {
			"NM1_UtlizationManagementOrganziation" : {
				"nm101" : "X3",
				"nm102" : "2",
                "nm108" : "XX"
			},
			"NM1_RequesterName" : {
				"nm101" : "1P",
				"nm102" : "2",
				"nm108" : "XX"
			},
			"NM1_SubscriberName" : {
				"nm101" : "IL",
				"nm102" : "1",
				"nm108" : "MI"			
			},
			"NM1_DependentName" : {
				"nm101" : "QC",
				"nm102" : "1"
			}
		},
		"DTP" : {
			"DTP_EventDate" : {
				"dtp01" : "AAH",
				"dtp02" : "RD8"
			},
			"DTP_AdmissionDate" : {
				"dtp01" : "435",
				"dtp02" : "D8"
			},
			"DTP_AccidentDate" : {
				"dtp01" : "439",
				"dtp02" : "D8"
			},
			"DTP_ServiceDate" : {
				"dtp01" : "472",
				"dtp02" : "D8"
			},
            "DTP_CertificationIssueDate1": {
                "dtp01" : "102",
				"dtp02" : "D8"
            },
            "DTP_CertificationExpirationDate": {
                "dtp01" : "036",
				"dtp02" : "D8"
            },
            "DTP_CertificationEffectiveDate" : {
            	"dtp01" : "007",
            	"dtp02" : "D8"
            }
		},
		"DMG" : {
			"DMG_SubscriberDemographicInformation" : {
				"dmg01" : "D8"
			},
			"DMG_DependentDemographicInformation" : {
				"dmg01" : "D8"
			}
		},
		"SV1" : {
			"SV1_ProfessionalService" : {
				"sv111" : "Y",
				"SV101_CompositeMedicalProcedureIdentifier" : {
					"sv101" : "WK"
				}
			}
		},
	    "PRV" : {
		    "PRV_PatientEventProviderInformation": {
		        "prv02" : "PXC"
		    },
		    "PRV_ServiceProviderInformation": {
		        "prv02": "PXC"
		    }
    	},
    	"TRN" : {
    		"TRN_SubscriberTraceNumber" : {
    			"trn01" : "1"
    		},
    		"TRN_PayerClaimControlNumberProviderAttachmentControlNumber" : {
    			"trn01" : "1"
    		}
    	},
    	"REF" : {
    		"REF_PreviousReviewAuthorizationNumber" : {
    			"ref01" : "BB"
    		},
    		"REF_PreviousReviewAdministrativeReferenceNumber" : {
    			"ref01" : "NT"
    		}
    	} 
	}
   
   
 }