#!/bin/bash

echo "Lambda files got changed. Going to update lambda function code"
aws ssm get-parameters-by-path --path /Test-LAMBDA --region us-east-2 | jq -r '.Parameters | map(.Name+"="+.Value)| join("\n") | sub("/Test-LAMBDA/"; ""; "g")  ' > .env

mkdir -p /tmp/lambda/Test
echo "Copying Files from Project to Temp Folder"
rsync -a lambda_code/ /tmp/lambda/Test/
cp .env /tmp/lambda/Test/.env

cd /tmp/lambda/Test/ && zip -rq ../Test.zip .
aws s3 cp /tmp/lambda/Test.zip s3://b-amorserv-s3-codepipeline/lambda_functions/Test-Lambda/Test.zip
aws lambda update-function-code --function-name TestLambda --s3-bucket b-amorserv-s3-codepipeline --s3-key lambda_functions/Test-Lambda/Test.zip
