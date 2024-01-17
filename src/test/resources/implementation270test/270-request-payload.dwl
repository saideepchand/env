{
  "resourceType": "Bundle",
  "id": "bundle-batch-create02",
  "type": "batch",
  "entry": [
      {
          "resource": {
              "resourceType": "CoverageEligibilityRequest",
              "id": "52346",
              "text": {
                  "status": "generated",
                  "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">A human-readable rendering of the CoverageEligibilityRequest</div>"
              },
              "identifier": [
                  {
                      "system": "http://happyvalley.com/coverageelegibilityrequest",
                      "value": "52346"
                  }
              ],
              "status": "active",
              "priority": {
                  "coding": [
                      {
                          "code": "normal"
                      }
                  ]
              },
              "purpose": [
                  "validation",
                  "benefits"
              ],
              "patient": {
                  "reference": "Patient/pat1"
              },
              "servicedDate": "2014-09-17",
              "created": "2014-08-16",
              "enterer": {
                  "identifier": {
                      "system": "http://happyvalleyclinic.com/staff",
                      "value": "14"
                  }
              },
              "provider": {
                  "reference": "Organization/1"
              },
              "insurer": {
                  "reference": "Organization/2"
              },
              "facility": {
                  "identifier": {
                      "system": "http://statecliniclicensor.com/clinicid",
                      "value": "G35B9"
                  }
              },
              "insurance": [
                  {
                      "coverage": {
                          "reference": "Coverage/9876B1"
                      },
                      "businessArrangement": "NB8742"
                  }
              ],
              "item": [
                  {
                      "category": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/ex-benefitcategory",
                                  "code": "1",
                                  "display": "Medical Care"
                              }
                          ]
                      },
                      "productOrService": {
                          "coding": [
                              {
                                  "system": "http://www.hl7.org/fhir/codesystem-service-uscls.html",
                                  "code": "1101",
                                  "diplay" : "Exam, comp, primary"
                              }
                          ]
                      },
                      "diagnosis": [
                          {
                              "diagnosisCodeableConcept": {
                                  "coding": [
                                      {
                                          "system": "http://hl7.org/fhir/sid/icd-10",
                                          "code": "J01.0",
                                          "display": "Acute maxillary sinusitis"
                                      }
                                  ],
                                  "text": "Notes for payer 1"
                              }
                          },
                          {
                              "diagnosisCodeableConcept": {
                                  "coding": [
                                      {
                                          "system": "http://hl7.org/fhir/sid/icd-10",
                                          "code": "B95.0",
                                          "display": "Streptococcus, group A, as the cause of diseases classified to other chapters"
                                      }
                                  ]
                              }
                          },
                          {
                              "diagnosisCodeableConcept": {
                                  "coding": [
                                      {
                                          "system": "http://hl7.org/fhir/sid/icd-10",
                                          "code": "B95.2",
                                          "display": "Streptococcus group D and enterococcus as the cause of diseases classified to other chapters"
                                      }
                                  ]
                              }
                          }
                      ]
                  },
                  {
                    "category": {
                        "coding": [
                            {
                                "system": "http://terminology.hl7.org/CodeSystem/ex-benefitcategory",
                                "code": "1",
                                "display": "Medical Care"
                            }
                        ]
                    },
                    "productOrService": {
                        "coding": [
                            {
                                "system": "http://hl7.org/fhir/benefit-category",
                                "code": "medical"
                            }
                        ]
                    },
                    "modifier": [
                        {
                            "coding": [
                                {
                                    "system": "http://hl7.org/fhir/benefit-category",
                                    "code": "medical"
                                }
                            ]
                        }
                    ],
                    "diagnosis": [
                        {
                            "diagnosisCodeableConcept": {
                                "coding": [
                                    {
                                        "system": "http://hl7.org/fhir/sid/icd-10",
                                        "code": "J01.0",
                                        "display": "Acute maxillary sinusitis"
                                    }
                                ],
                                "text": "Negative for pneumonia"
                            }
                        },
                        {
                            "diagnosisCodeableConcept": {
                                "coding": [
                                    {
                                        "system": "http://hl7.org/fhir/sid/icd-10",
                                        "code": "B95.0",
                                        "display": "Streptococcus, group A, as the cause of diseases classified to other chapters"
                                    }
                                ]
                            }
                        },
                        {
                            "diagnosisCodeableConcept": {
                                "coding": [
                                    {
                                        "system": "http://hl7.org/fhir/sid/icd-10",
                                        "code": "B95.2",
                                        "display": "Streptococcus group D and enterococcus as the cause of diseases classified to other chapters"
                                    }
                                ]
                            }
                        }
                    ]
                }                  
              ]
          }
      },
      {
          "resource": {
              "resourceType": "Organization",
              "id": "2",
              "text": {
                  "status": "generated",
                  "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n      \n      <p>XYZ Insurance</p>\n    \n    </div>"
              },
              "identifier": [
                  {
                      "system": "urn:oid:2.16.840.1.113883.3.19.2.3",
                      "value": "666666"
                  }
              ],
              "name": "XYZ Insurance",
              "alias": [
                  "ABC Insurance"
              ]
          }
      },
      {
          "resource": {
              "resourceType": "Organization",
              "id": "1",
              "text": {
                  "status": "generated",
                  "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n      \n      <p>Good Health Clinic</p>\n    \n    </div>"
              },
              "identifier": [
                  {
                      "system": "urn:ietf:rfc:3986",
                      "value": "1234567"
                  }
              ],
              "name": "Good Health Clinic"
          }
      },
      {
          "resource": {
              "resourceType": "Patient",
              "id": "pat1",
              "text": {
                  "status": "generated",
                  "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n      \n      <p>Patient Donald DUCK @ Acme Healthcare, Inc. MR = 654321</p>\n    \n    </div>"
              },
              "identifier": [
                  {
                      "use": "usual",
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203",
                                  "code": "MR"
                              }
                          ]
                      },
                      "system": "urn:oid:0.1.2.3.4.5.6.7",
                      "value": "654321"
                  }
              ],
              "active": true,
              "name": [
                  {
                      "use": "official",
                      "family": "Donald",
                      "given": [
                          "Duck"
                      ]
                  }
              ],
              "gender": "male",
              "birthDate": "1974-12-25",
              "photo": [
                  {
                      "contentType": "image/gif",
                      "data": "R0lGODlhEwARAPcAAAAAAAAA/+9aAO+1AP/WAP/eAP/eCP/eEP/eGP/nAP/nCP/nEP/nIf/nKf/nUv/nWv/vAP/vCP/vEP/vGP/vIf/vKf/vMf/vOf/vWv/vY//va//vjP/3c//3lP/3nP//tf//vf///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////yH5BAEAAAEALAAAAAATABEAAAi+AAMIDDCgYMGBCBMSvMCQ4QCFCQcwDBGCA4cLDyEGECDxAoAQHjxwyKhQAMeGIUOSJJjRpIAGDS5wCDly4AALFlYOgHlBwwOSNydM0AmzwYGjBi8IHWoTgQYORg8QIGDAwAKhESI8HIDgwQaRDI1WXXAhK9MBBzZ8/XDxQoUFZC9IiCBh6wEHGz6IbNuwQoSpWxEgyLCXL8O/gAnylNlW6AUEBRIL7Og3KwQIiCXb9HsZQoIEUzUjNEiaNMKAAAA7"
                  }
              ],
              "contact": [
                  {
                      "relationship": [
                          {
                              "coding": [
                                  {
                                      "system": "http://terminology.hl7.org/CodeSystem/v2-0131",
                                      "code": "E"
                                  }
                              ]
                          }
                      ],
                      "organization": {
                          "reference": "Organization/1",
                          "display": "Walt Disney Corporation"
                      }
                  }
              ],
              "managingOrganization": {
                  "reference": "Organization/1",
                  "display": "ACME Healthcare, Inc"
              },
              "link": [
                  {
                      "other": {
                          "reference": "Patient/pat2"
                      },
                      "type": "seealso"
                  }
              ]
          }
      },
      {
          "resource": {
              "resourceType": "Coverage",
              "id": "9876B1",
              "text": {
                  "status": "generated",
                  "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">A human-readable rendering of the coverage</div>"
              },
              "identifier": [
                  {
                      "system": "http://benefitsinc.com/certificate",
                      "value": "12345"
                  }
              ],
              "status": "active",
              "type": {
                  "coding": [
                      {
                          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode",
                          "code": "EHCPOL",
                          "display": "extended healthcare"
                      }
                  ]
              },
              "policyHolder": {
                  "reference": "http://benefitsinc.com/FHIR/Organization/CBI35"
              },
              "subscriber": {
                  "reference": "Patient/pat1"
              },
              "beneficiary": {
                  "reference": "Patient/pat1"
              },
              "dependent": "0",
              "relationship": {
                  "coding": [
                      {
                          "code": "self"
                      }
                  ]
              },
              "period": {
                  "start": "2011-05-23",
                  "end": "2012-05-23"
              },
              "payor": [
                  {
                      "reference": "Organization/2"
                  }
              ],
              "class": [
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "group"
                              }
                          ]
                      },
                      "value": "CB135",
                      "name": "Corporate Baker's Inc. Local #35"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "subgroup"
                              }
                          ]
                      },
                      "value": "123",
                      "name": "Trainee Part-time Benefits"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "plan"
                              }
                          ]
                      },
                      "value": "B37FC",
                      "name": "Full Coverage: Medical, Dental, Pharmacy, Vision, EHC"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "subplan"
                              }
                          ]
                      },
                      "value": "P7",
                      "name": "Includes afterlife benefits"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "class"
                              }
                          ]
                      },
                      "value": "SILVER",
                      "name": "Silver: Family Plan spouse only"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "subclass"
                              }
                          ]
                      },
                      "value": "Tier2",
                      "name": "Low deductable, max $20 copay"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "sequence"
                              }
                          ]
                      },
                      "value": "9"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "rxid"
                              }
                          ]
                      },
                      "value": "MDF12345"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "rxbin"
                              }
                          ]
                      },
                      "value": "987654"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "rxgroup"
                              }
                          ]
                      },
                      "value": "M35PT"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "rxpcn"
                              }
                          ]
                      },
                      "value": "234516"
                  },
                  {
                      "type": {
                          "coding": [
                              {
                                  "system": "http://terminology.hl7.org/CodeSystem/coverage-class",
                                  "code": "sequence"
                              }
                          ]
                      },
                      "value": "9"
                  }
              ]
          }
      }
  ]
}