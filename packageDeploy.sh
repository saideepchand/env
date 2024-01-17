#!/bin/bash
#This script takes the required parameters to deploy an API
#
###################################
ENV_PROFILE=CloudHub-DEV
echo Cleaning and building deployment package…
#mvn clean package -DskipTests
mvn clean package
echo Deploying to ${ENV_PROFILE}...
mvn mule:deploy -P${ENV_PROFILE} -DmuleDeploy -Dcloudhub.applicationName=hls-fhir-to-x12-sys-api
echo Done.
