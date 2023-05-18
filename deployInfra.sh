#!/bin/bash
# AWS credentials file must contain valid credentials or AWS SSO config must have been run

SOLUTION_RUN_ID="58be06e9-b88e-456c-a8e2-00fdaa914394"

sam build
sam deploy --stack-name origin-${SOLUTION_RUN_ID} --resolve-s3 --debug --no-fail-on-empty-changeset