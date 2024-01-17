:: This script packages and deploys an API
@echo off
set ENV_PROFILE=CloudHub-DEV

echo Cleaning and building deployment package...
call mvn clean package -DskipTests

echo Deploying to %ENV_PROFILE%...
call mvn mule:deploy -P%ENV_PROFILE% -DmuleDeploy -Dcloudhub.applicationName=hls-fhir-to-x12-sys-api

echo Done.
