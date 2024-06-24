#!/bin/bash

set -e  # Exit immediately if any command fails

echo "Lambda files update process started..."

# Ensure lambda_code directory exists
mkdir -p lambda_code

# Fetch parameters from AWS SSM Parameter Store
echo "Fetching parameters from AWS SSM Parameter Store"
aws ssm get-parameters-by-path --path /Test-LAMBDA --region us-east-1 | \
  jq -r '.Parameters | map(.Name+"="+.Value) | join("\n") | sub("/Test-LAMBDA/"; ""; "g")' > .env

# Create temporary directory and copy files
mkdir -p /tmp/lambda/Test
echo "Copying files to temporary folder"
rsync -a lambda_code/ /tmp/lambda/Test/
cp .env /tmp/lambda/Test/.env

# Zip files
cd /tmp/lambda/Test/
zip -rq ../Test.zip .

# Upload ZIP file to S3
echo "Uploading ZIP file to S3"
aws s3 cp /tmp/Test.zip s3://b-amorserv-s3-codepipeline/lambda_functions/my_lambda_function/Test.zip

# Update Lambda function code
echo "Updating Lambda function code"
aws lambda update-function-code --function-name my_lambda_function \
  --s3-bucket b-amorserv-s3-codepipeline \
  --s3-key lambda_functions/my_lambda_function/Test.zip \
  --region us-east-1

echo "Lambda function code updated successfully"
