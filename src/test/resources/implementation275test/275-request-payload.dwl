{
  "resourceType": "Bundle",
  "type": "collection",
  "entry": [
    {
      "resource" : {
        "resourceType" : "Claim",
        "id" : "MedicalServicesAuthorizationExample",
        "meta" : {
          "profile" : [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-claim"
          ]
        },
        "text" : {
          "status" : "generated",
          "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 111099</p><p><b>status</b>: active</p><p><b>type</b>: <span title=\"Codes: {http://terminology.hl7.org/CodeSystem/claim-type professional}\">Professional</span></p><p><b>use</b>: preauthorization</p><p><b>patient</b>: <a href=\"Patient-SubscriberExample.html\">Generated Summary: id: 12345678901; JOE SMITH ; gender: male</a></p><p><b>created</b>: May 2, 2005, 6:01:00 AM</p><p><b>insurer</b>: <a href=\"Organization-InsurerExample.html\">Generated Summary: id: 789312; active; <span title=\"Codes: {https://codesystem.x12.org/005010/98 PR}\">PR</span>; name: MARYLAND CAPITAL INSURANCE COMPANY</a></p><p><b>provider</b>: <a href=\"Organization-UMOExample.html\">Generated Summary: id: 8189991234; active; <span title=\"Codes: {https://codesystem.x12.org/005010/98 X3}\">X3</span>; name: DR. JOE SMITH CORPORATION</a></p><p><b>priority</b>: <span title=\"Codes: {http://terminology.hl7.org/CodeSystem/processpriority normal}\">Normal</span></p><h3>Insurances</h3><table class=\"grid\"><tr><td>-</td><td><b>Sequence</b></td><td><b>Focal</b></td><td><b>Coverage</b></td></tr><tr><td>*</td><td>1</td><td>true</td><td><a href=\"Coverage-InsuranceExample.html\">Generated Summary: status: active</a></td></tr></table><h3>Items</h3><table class=\"grid\"><tr><td>-</td><td><b>Extension</b></td><td><b>Sequence</b></td><td><b>ProductOrService</b></td><td><b>Serviced[x]</b></td><td><b>Location[x]</b></td></tr><tr><td>*</td><td>, </td><td>1</td><td><span title=\"Codes: {http://www.ama-assn.org/go/cpt 99212}\">Established Office Visit</span></td><td>2005-05-10</td><td><span title=\"Codes: {https://www.cms.gov/Medicare/Coding/place-of-service-codes/Place_of_Service_Code_Set 11}\">11</span></td></tr></table></div>"
        },
        "identifier" : [
          {
            "system" : "http://example.org/PATIENT_EVENT_TRACE_NUMBER",
            "value" : "111099",
            "assigner" : {
              "identifier" : {
                "system" : "http://example.org/USER_ASSIGNED",
                "value" : "9012345678"
              }
            }
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
        "patient" : {
          "reference" : "Patient/pat1111"
        },
        "created" : "2005-05-02T11:01:00+05:00",
        "insurer" : {
          "reference" : "Organization/org1111"
        },
        "provider" : {
          "reference" : "Organization/org2222"
        },
        "priority" : {
          "coding" : [
            {
              "system" : "http://terminology.hl7.org/CodeSystem/processpriority",
              "code" : "normal"
            }
          ]
        },
        "insurance" : [
          {
            "sequence" : 1,
            "focal" : true,
            "coverage" : {
              "reference" : "Coverage/cov1111"
            }
          }
        ],
        "extension" : [
          {
            "url" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-levelOfServiceCode",
            "valueCodeableConcept" : {
              "coding" : [
                {
                  "code" : "E",
                  "system" : "https://valueset.x12.org/x217/005010/request/2000E/UM/1/06/00/1338",
                  "display" : "Emergency"
                }
              ]

            }
          }
        ],
        "item" : [
          {
            "extension" : [
              {
                "url" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-serviceItemRequestType",
                "valueCodeableConcept" : {
                  "coding" : [
                    {
                      "system" : "http://codesystem.x12.org/005010/1525",
                      "code" : "IN",
                      "display" : "Initial Medical Services Reservation"
                    }
                  ]
                }
              },
              {
                "url" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-certificationType",
                "valueCodeableConcept" : {
                  "coding" : [
                    {
                      "system" : "http://codesystem.x12.org/005010/1322",
                      "code" : "I",
                      "display" : "Initial"
                    }
                  ]
                }
              }
            ],
            "sequence" : 1,
            "productOrService" : {
              "coding" : [
                {
                  "system" : "http://www.ama-assn.org/go/cpt",
                  "code" : "99212",
                  "display" : "Established Office Visit"
                }
              ]
            },
            "servicedDate" : "2005-05-10",
            "locationCodeableConcept" : {
              "coding" : [
                {
                  "system" : "https://www.cms.gov/Medicare/Coding/place-of-service-codes/Place_of_Service_Code_Set",
                  "code" : "11"
                }
              ]
            },
            "category" : {
              "coding" : [
                {
                  "code" : "1",
                  "system" : "https://valueset.x12.org/x217/005010/request/2000F/UM/1/03/00/1365"
                }
              ]
            }
          }
        ],
        "supportingInfo" : [
        {
            "sequence": 1,
            "category": {
                "coding": [
                    {
                        "system": "http://terminology.hl7.org/CodeSystem/claiminformationcategory",
                        "version": "1.0",
                        "code": "attachment",
                        "display": "Attachment"
                    }
                  ]           
            },
            "valueAttachment": {
            "contentType": "application/octet-stream",  
            "data": "VGhlIGJhc2tldCBpcyBmdWxsIG9mIGdyYXBlcy4="
            }
        },            
          {
            "category" : {
              "coding" : [
                {
                  "system" : "http://terminology.hl7.org/CodeSystem/claiminformationcategory",
                  "code" : "hospitalized"
                }
              ]
            },
            "timingDate" : "2021-04-21"
          }
        ],
        "careTeam" : [
          {
            "extension" : [
              {
                "url" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-careTeamClaimScope",
                "valueBoolean" : true
              }
            ],
            "sequence" : 1,
            "provider" : {
              "reference" : "Practitioner/prac1212"
            },
            "role" : {
              "coding" : [
                {
                  "code" : "primary",
                  "system" : "http://terminology.hl7.org/CodeSystem/claimcareteamrole",
                  "display" : "Primary provider"
                }
              ]
            }
          },
          {
            "extension" : [
              {
                "url" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-careTeamClaimScope",
                "valueBoolean" : true
              }
            ],
            "sequence" : 2,
            "provider" : {
              "reference" : "Practitioner/prac2232"
            },
            "role" : {
              "coding" : [
                {
                  "code" : "assist",
                  "system" : "http://terminology.hl7.org/CodeSystem/claimcareteamrole",
                  "display" : "Assisting Provider"
                }
              ]
            }
          }          
        ],
        "diagnosis" : [
          {
            "sequence" : 1,
            "diagnosisCodeableConcept" : {
              "coding" : [
                {
                  "system" : "http://hl7.org/fhir/sid/icd-10-cm",
                  "code" : "G89.4"
                }
              ]
            }
          }
        ]
      }
    },
    {
      "resource" : {
        "resourceType" : "Organization",
        "id" : "org1111",
        "meta" : {
          "profile" : [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-insurer"
          ]
        },
        "text" : {
          "status" : "generated",
          "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 789312</p><p><b>active</b>: true</p><p><b>type</b>: <span title=\"Codes: {https://codesystem.x12.org/005010/98 PR}\">PR</span></p><p><b>name</b>: MARYLAND CAPITAL INSURANCE COMPANY</p></div>"
        },
        "identifier" : [
          {
            "system" : "http://hl7.org/fhir/sid/us-npi",
            "value" : "789312",
            "type" : [
              {
                "coding" : [
                  {
                    "system" : "http://example.org/system",
                    "code" : "U"
                  }
                ]
              }
            ]
          }
        ],
        "active" : true,
        "type" : [
          {
            "coding" : [
              {
                "system" : "https://codesystem.x12.org/005010/98",
                "code" : "PR"
              }
            ]
          }
        ],
        "name" : "MARYLAND CAPITAL INSURANCE COMPANY"
      }
    }, 
    {
      "resource" : {
        "resourceType" : "Organization",
        "id" : "org2222",
        "meta" : {
          "profile" : [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-requestor"
          ]
        },
        "text" : {
          "status" : "generated",
          "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 8189991234</p><p><b>active</b>: true</p><p><b>type</b>: <span title=\"Codes: {https://codesystem.x12.org/005010/98 X3}\">X3</span></p><p><b>name</b>: DR. JOE SMITH CORPORATION</p><p><b>address</b>: 111 1ST STREET SAN DIEGO CA 92101 US </p></div>"
        },
        "identifier" : [
          {
            "system" : "http://hl7.org/fhir/sid/us-npi",
            "value" : "8189991234"
          }
        ],
        "active" : true,
        "type" : [
          {
            "coding" : [
              {
                "system" : "https://codesystem.x12.org/005010/98",
                "code" : "1P"
              }
            ]
          }
        ],
        "name" : "DR. JOE SMITH CORPORATION",
        "address" : [
          {
            "line" : [
              "111 1ST STREET"
            ],
            "city" : "SAN DIEGO",
            "state" : "CA",
            "postalCode" : "92101",
            "country" : "US"
          }
        ]
      }
    },
    {
      "resource" : {
        "resourceType" : "Coverage",
        "id" : "cov1111",
        "meta" : {
          "profile" : [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-coverage"
          ]
        },
        "text" : {
          "status" : "generated",
          "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>status</b>: active</p><p><b>beneficiary</b>: <a href=\"Patient-SubscriberExample.html\">Generated Summary: id: 12345678901; JOE SMITH ; gender: male</a></p><p><b>payor</b>: <a href=\"Organization-InsurerExample.html\">Generated Summary: id: 789312; active; <span title=\"Codes: {https://codesystem.x12.org/005010/98 PR}\">PR</span>; name: MARYLAND CAPITAL INSURANCE COMPANY</a></p></div>"
        },
        "status" : "active",
        "beneficiary" : {
          "reference" : "Patient/pat1111"
        },
        "payor" : [
          {
            "reference" : "Organization/org1111"
          }
        ]
      }
    },
    {
      "resource" : {
        "resourceType" : "Patient",
        "id" : "pat1111",
        "meta" : {
          "profile" : [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-subscriber"
          ]
        },
        "text" : {
          "status" : "extensions",
          "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>MilitaryStatus</b>: <span title=\"Codes: {https://codesystem.x12.org/005010/584 RU}\">RU</span></p><p><b>identifier</b>: id: 12345678901</p><p><b>name</b>: JOE SMITH </p><p><b>gender</b>: male</p></div>"
        },
        "extension" : [
          {
            "url" : "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-militaryStatus",
            "valueCodeableConcept" : {
              "coding" : [
                {
                  "system" : "https://codesystem.x12.org/005010/584",
                  "code" : "RU"
                }
              ]
            }
          }
        ],
        "identifier" : [
          {
            "system" : "http://example.org/MIN",
            "value" : "12345678901"
          }
        ],
        "name" : [
          {
            "family" : "SMITH",
            "given" : [
              "JOE"
            ]
          }
        ],
        "gender" : "male"
      }
    },
    {
      "resource" : {
        "resourceType" : "Practitioner",
        "id" : "prac1212",
        "meta" : {
          "profile" : [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-practitioner"
          ]
        },
        "text" : {
          "status" : "generated",
          "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 987654321</p><p><b>name</b>: SUSAN WATSON </p><p><b>telecom</b>: ph: 4029993456</p></div>"
        },
        "identifier" : [
          {
            "system" : "http://hl7.org/fhir/sid/us-npi",
            "value" : "987654321",
            "type" : {
              "coding" : [
                {
                    "code" : "NPI"
                }
              ]
            }
          }
        ],
        "name" : [
          {
            "family" : "WATSON",
            "given" : [
              "SUSAN"
            ]
          }
        ],
        "telecom" : [
          {
            "system" : "phone",
            "value" : "4029993456"
          },
          {
            "system" : "fax",
            "value" : "4029993455"
          }
        ]
      }
    },
    {
      "resource" : {
        "resourceType" : "Practitioner",
        "id" : "prac2232",
        "meta" : {
          "profile" : [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-practitioner"
          ]
        },
        "text" : {
          "status" : "generated",
          "div" : "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 987654321</p><p><b>name</b>: SUSAN WATSON </p><p><b>telecom</b>: ph: 4029993456</p></div>"
        },
        "identifier" : [
          {
            "system" : "http://hl7.org/fhir/sid/us-npi",
            "value" : "987654322",
            "type" : {
              "coding" : [
                {
                    "code" : "NPI"
                }
              ]
            }            
          }
        ],
        "name" : [
          {
            "family" : "Davis",
            "given" : [
              "Daniel"
            ]
          }
        ],
        "telecom" : [
          {
            "system" : "phone",
            "value" : "4224234567"
          },
          {
            "system" : "email",
            "value" : "daniel.davis@mypractice.com"
          }
        ]
      }
    }    
  ]
}