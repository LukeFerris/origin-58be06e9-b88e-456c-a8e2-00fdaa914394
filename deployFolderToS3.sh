#!/bin/bash

# Get stack_name from samconfig.toml file
STACK_NAME=$(grep "^\\[origin-58be06e9-b88e-456c-a8e2-00fdaa914394\\]" -A 11 samconfig.toml | grep '^stack_name' | cut -d '=' -f 2 | sed s/\"//g | xargs)
REGION=$(grep "^\\[origin-58be06e9-b88e-456c-a8e2-00fdaa914394\\]" -A 11 samconfig.toml | grep '^region' | cut -d '=' -f 2 | sed s/\"//g | xargs)
PROFILE=$(grep "^\\[origin-58be06e9-b88e-456c-a8e2-00fdaa914394\\]" -A 11 samconfig.toml | grep '^profile' | cut -d '=' -f 2 | sed s/\"//g | xargs)
AWS_ACCOUNT_NUMBER=$(grep "^\\[origin-58be06e9-b88e-456c-a8e2-00fdaa914394\\]" -A 11 samconfig.toml | grep '^aws_account_number' | cut -d '=' -f 2 | sed s/\"//g | xargs)

# Get cloudfront distribution id from AWS
CLOUDFRONT_DISTRIBUTION_ID=$(aws cloudformation describe-stack-resource --region=$REGION --stack-name=$STACK_NAME --logical-resource-id=SiteCdn --output=text --query=StackResourceDetail.PhysicalResourceId)

echo $CLOUDFRONT_DISTRIBUTION_ID

aws s3 sync . s3://$STACK_NAME-site/
aws cloudfront create-invalidation --distribution-id=$CLOUDFRONT_DISTRIBUTION_ID --paths="/"