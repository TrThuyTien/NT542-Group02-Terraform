#!/bin/bash
set -e

BUCKET_NAME="nt542-group02-terraform"
DYNAMODB_TABLE="terraform-locks"
REGION="us-east-1"

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

echo -e "${GREEN}=== Creating Terraform Backend ===${NC}\n"

# 1. Create S3 bucket (fix us-east-1)
echo -e "${YELLOW}[1/4] Creating S3 bucket...${NC}"

if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
  echo -e "${GREEN}  ✓ Bucket already exists${NC}\n"
else
  if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket --bucket "$BUCKET_NAME"
  else
    aws s3api create-bucket \
      --bucket "$BUCKET_NAME" \
      --region "$REGION" \
      --create-bucket-configuration LocationConstraint="$REGION"
  fi
  echo -e "${GREEN}  ✓ Bucket created${NC}\n"
fi

# 2. Enable versioning
echo -e "${YELLOW}[2/4] Enabling versioning...${NC}"
aws s3api put-bucket-versioning \
  --bucket "$BUCKET_NAME" \
  --versioning-configuration Status=Enabled
echo -e "${GREEN}  ✓ Done${NC}\n"

# 3. Enable encryption
echo -e "${YELLOW}[3/4] Enabling encryption...${NC}"
aws s3api put-bucket-encryption \
  --bucket "$BUCKET_NAME" \
  --server-side-encryption-configuration '{
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "AES256"
      }
    }]
  }'
echo -e "${GREEN}  ✓ Done${NC}\n"

# 4. Create DynamoDB
echo -e "${YELLOW}[4/4] Creating DynamoDB table...${NC}"

if aws dynamodb describe-table \
  --table-name "$DYNAMODB_TABLE" \
  --region "$REGION" 2>/dev/null; then
  echo -e "${GREEN}  ✓ DynamoDB already exists${NC}\n"
else
  aws dynamodb create-table \
    --table-name "$DYNAMODB_TABLE" \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region "$REGION"
  echo -e "${GREEN}  ✓ DynamoDB created${NC}\n"
fi

echo -e "${GREEN}=== Backend Ready ===${NC}"
