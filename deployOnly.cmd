@echo off
set ENV_PROFILE=CloudHub-DEV

echo Deploying to %ENV_PROFILE%...
call mvn mule:deploy -P%ENV_PROFILE% -DmuleDeploy -Dcloudhub.applicationName=hls-fhir-to-x12-sys-api

echo Done.