{
  "resourceType": "Bundle",
  "id": "PASClaimInquiryBundleExample",
  "meta": {
    "profile": [
      "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-pas-inquiry-request-bundle"
    ]
  },
  "identifier": {
    "system": "http://example.org/SUBMITTER_TRANSACTION_IDENTIFIER",
    "value": "5269367"
  },
  "type": "collection",
  "timestamp": "2005-05-02T11:01:00+05:00",
  "entry": [
    {
      "fullUrl": "http://example.org/fhir/Claim/PASClaimInquiryExample",
      "resource": {
        "resourceType": "Claim",
        "id": "PASClaimInquiryExample",
        "meta": {
          "profile": [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-claim-inquiry"
          ]
        },
        "text": {
          "status": "extensions",
          "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 111099</p><p><b>status</b>: active</p><p><b>type</b>: <span title=\"Codes: {http://terminology.hl7.org/CodeSystem/claim-type professional}\">Professional</span></p><p><b>use</b>: preauthorization</p><p><b>patient</b>: <a href=\"#Patient_SubscriberExample\">See above (Patient/SubscriberExample)</a></p><p><b>created</b>: Jul 20, 2019, 6:01:00 AM</p><p><b>insurer</b>: <a href=\"#Organization_InsurerExample\">See above (Organization/InsurerExample)</a></p><p><b>provider</b>: <a href=\"#Organization_UMOExample\">See above (Organization/UMOExample)</a></p><p><b>priority</b>: <span title=\"Codes: {http://terminology.hl7.org/CodeSystem/processpriority normal}\">Normal</span></p><h3>Insurances</h3><table class=\"grid\"><tr><td>-</td><td><b>Sequence</b></td><td><b>Focal</b></td><td><b>Coverage</b></td></tr><tr><td>*</td><td>1</td><td>true</td><td><a href=\"#Coverage_InsuranceExample\">See above (Coverage/InsuranceExample)</a></td></tr></table><blockquote><p><b>item</b></p><p><b>ServiceItemRequestType</b>: <span title=\"Codes: {http://codesystem.x12.org/005010/1525 HS}\">Health Services Review</span></p><p><b>CertificationType</b>: <span title=\"Codes: {http://codesystem.x12.org/005010/1322 I}\">Initial</span></p><p><b>sequence</b>: 1</p><p><b>productOrService</b>: <span title=\"Codes: {http://www.ama-assn.org/go/cpt G0154}\">G0154</span></p></blockquote><blockquote><p><b>item</b></p><p><b>ServiceItemRequestType</b>: <span title=\"Codes: {http://codesystem.x12.org/005010/1525 HS}\">Health Services Review</span></p><p><b>CertificationType</b>: <span title=\"Codes: {http://codesystem.x12.org/005010/1322 I}\">Initial</span></p><p><b>sequence</b>: 2</p><p><b>productOrService</b>: <span title=\"Codes: {http://www.ama-assn.org/go/cpt B4184}\">B4184</span></p></blockquote></div>"
        },
        "identifier": [
          {
            "system": "http://example.org/PATIENT_EVENT_TRACE_NUMBER",
            "value": "111099",
            "assigner": {
              "identifier": {
                "system": "http://example.org/USER_ASSIGNED",
                "value": "9012345678"
              }
            }
          }
        ],
        "status": "active",
        "type": {
          "coding": [
            {
              "system": "http://terminology.hl7.org/CodeSystem/claim-type",
              "code": "professional"
            }
          ]
        },
        "use": "preauthorization",
        "patient": {
          "reference": "Patient/SubscriberExample"
        },
        "created": "2019-07-20T11:01:00+05:00",
        "insurer": {
          "reference": "Organization/InsurerExample"
        },
        "provider": {
          "reference": "Organization/UMOExample"
        },
        "priority": {
          "coding": [
            {
              "system": "http://terminology.hl7.org/CodeSystem/processpriority",
              "code": "normal"
            }
          ]
        },
        "insurance": [
          {
            "sequence": 1,
            "focal": true,
            "coverage": {
              "reference": "Coverage/InsuranceExample"
            }
          }
        ],
        "item": [
          {
            "extension": [
              {
                "url": "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-serviceItemRequestType",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://codesystem.x12.org/005010/1525",
                      "code": "HS",
                      "display": "Health Services Review"
                    }
                  ]
                }
              },
              {
                "url": "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-certificationType",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://codesystem.x12.org/005010/1322",
                      "code": "I",
                      "display": "Initial"
                    }
                  ]
                }
              }
            ],
            "sequence": 1,
            "productOrService": {
              "coding": [
                {
                  "system": "http://www.ama-assn.org/go/cpt",
                  "code": "G0154"
                }
              ]
            }
          },
          {
            "extension": [
              {
                "url": "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-serviceItemRequestType",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://codesystem.x12.org/005010/1525",
                      "code": "HS",
                      "display": "Health Services Review"
                    }
                  ]
                }
              },
              {
                "url": "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-certificationType",
                "valueCodeableConcept": {
                  "coding": [
                    {
                      "system": "http://codesystem.x12.org/005010/1322",
                      "code": "I",
                      "display": "Initial"
                    }
                  ]
                }
              }
            ],
            "sequence": 2,
            "productOrService": {
              "coding": [
                {
                  "system": "http://www.ama-assn.org/go/cpt",
                  "code": "B4184"
                }
              ]
            }
          }
        ]
      }
    },
    {
      "fullUrl": "http://example.org/fhir/Organization/UMOExample",
      "resource": {
        "resourceType": "Organization",
        "id": "UMOExample",
        "meta": {
          "profile": [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-requestor"
          ]
        },
        "text": {
          "status": "generated",
          "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 8189991234</p><p><b>active</b>: true</p><p><b>type</b>: <span title=\"Codes: {https://codesystem.x12.org/005010/98 X3}\">X3</span></p><p><b>name</b>: DR. JOE SMITH CORPORATION</p><p><b>address</b>: 111 1ST STREET SAN DIEGO CA 92101 US </p></div>"
        },
        "identifier": [
          {
            "system": "http://hl7.org/fhir/sid/us-npi",
            "value": "8189991234"
          }
        ],
        "active": true,
        "type": [
          {
            "coding": [
              {
                "system": "https://codesystem.x12.org/005010/98",
                "code": "X3"
              }
            ]
          }
        ],
        "name": "DR. JOE SMITH CORPORATION",
        "address": [
          {
            "line": [
              "111 1ST STREET"
            ],
            "city": "SAN DIEGO",
            "state": "CA",
            "postalCode": "92101",
            "country": "US"
          }
        ]
      }
    },
    {
      "fullUrl": "http://example.org/fhir/Organization/InsurerExample",
      "resource": {
        "resourceType": "Organization",
        "id": "InsurerExample",
        "meta": {
          "profile": [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-insurer"
          ]
        },
        "text": {
          "status": "generated",
          "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>identifier</b>: id: 789312</p><p><b>active</b>: true</p><p><b>type</b>: <span title=\"Codes: {https://codesystem.x12.org/005010/98 PR}\">PR</span></p><p><b>name</b>: MARYLAND CAPITAL INSURANCE COMPANY</p></div>"
        },
        "identifier": [
          {
            "system": "http://hl7.org/fhir/sid/us-npi",
            "value": "789312"
          }
        ],
        "active": true,
        "type": [
          {
            "coding": [
              {
                "system": "https://codesystem.x12.org/005010/98",
                "code": "PR"
              }
            ]
          }
        ],
        "name": "MARYLAND CAPITAL INSURANCE COMPANY"
      }
    },
    {
      "fullUrl": "http://example.org/fhir/Coverage/InsuranceExample",
      "resource": {
        "resourceType": "Coverage",
        "id": "InsuranceExample",
        "meta": {
          "profile": [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-coverage"
          ]
        },
        "text": {
          "status": "generated",
          "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>status</b>: active</p><p><b>beneficiary</b>: <a href=\"#Patient_SubscriberExample\">See above (Patient/SubscriberExample)</a></p><p><b>payor</b>: <a href=\"#Organization_InsurerExample\">See above (Organization/InsurerExample)</a></p></div>"
        },
        "status": "active",
        "beneficiary": {
          "reference": "Patient/SubscriberExample"
        },
        "payor": [
          {
            "reference": "Organization/InsurerExample"
          }
        ]
      }
    },
    {
      "fullUrl": "http://example.org/fhir/Patient/SubscriberExample",
      "resource": {
        "resourceType": "Patient",
        "id": "SubscriberExample",
        "meta": {
          "profile": [
            "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/profile-subscriber"
          ]
        },
        "text": {
          "status": "extensions",
          "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p><b>Generated Narrative</b></p><p><b>MilitaryStatus</b>: <span title=\"Codes: {https://codesystem.x12.org/005010/584 RU}\">RU</span></p><p><b>identifier</b>: id: 12345678901</p><p><b>name</b>: JOE SMITH </p><p><b>gender</b>: male</p></div>"
        },
        "extension": [
          {
            "url": "http://hl7.org/fhir/us/davinci-pas/StructureDefinition/extension-militaryStatus",
            "valueCodeableConcept": {
              "coding": [
                {
                  "system": "https://codesystem.x12.org/005010/584",
                  "code": "RU"
                }
              ]
            }
          }
        ],
        "identifier": [
          {
            "system": "http://example.org/MIN",
            "value": "12345678901"
          }
        ],
        "name": [
          {
            "family": "SMITH",
            "given": [
              "JOE"
            ]
          }
        ],
        "gender": "male"
      }
    }
  ]
}