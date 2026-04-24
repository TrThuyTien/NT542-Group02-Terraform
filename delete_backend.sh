#!/bin/bash

set -e

BUCKET_NAME="nt542-group02-terraform"
DYNAMODB_TABLE="terraform-locks"
REGION="us-east-1"

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

echo -e "${RED}⚠️  Cảnh báo: Xóa toàn bộ backend (S3 + DynamoDB)!${NC}"
read -r -p "Bạn chắc chắn? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
  echo "Đã hủy."
  exit 0
fi

echo -e "\n${RED}=== XÓA TERRAFORM BACKEND ===${NC}\n"

# ========================
# 1. S3
# ========================

echo -e "${YELLOW}[1/2] S3 Bucket${NC}"

if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then

  # check jq
  if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️ jq chưa cài → dùng cách đơn giản${NC}"

    aws s3 rm s3://$BUCKET_NAME --recursive || true

  else
    echo -e "${YELLOW}→ Xóa version objects...${NC}"

    aws s3api list-object-versions \
      --bucket "$BUCKET_NAME" \
      --query '{Objects: Versions[].{Key:Key,VersionId:VersionId}}' \
      --output json | \
    jq -c '.' | \
    aws s3api delete-objects \
      --bucket "$BUCKET_NAME" \
      --delete file:///dev/stdin 2>/dev/null || true

    aws s3api list-object-versions \
      --bucket "$BUCKET_NAME" \
      --query '{Objects: DeleteMarkers[].{Key:Key,VersionId:VersionId}}' \
      --output json | \
    jq -c '.' | \
    aws s3api delete-objects \
      --bucket "$BUCKET_NAME" \
      --delete file:///dev/stdin 2>/dev/null || true
  fi

  echo -e "${YELLOW}→ Xóa bucket...${NC}"
  aws s3api delete-bucket \
    --bucket "$BUCKET_NAME" \
    --region "$REGION"

  echo -e "${GREEN}✓ S3 deleted${NC}\n"

else
  echo -e "${YELLOW}✓ Bucket không tồn tại${NC}\n"
fi

# ========================
# 2. DynamoDB
# ========================

echo -e "${YELLOW}[2/2] DynamoDB${NC}"

if aws dynamodb list-tables \
  --region "$REGION" \
  --query "TableNames[]" \
  --output text | grep -qw "$DYNAMODB_TABLE"; then

  aws dynamodb delete-table \
    --table-name "$DYNAMODB_TABLE" \
    --region "$REGION"

  echo -e "${GREEN}✓ DynamoDB deleted${NC}\n"

else
  echo -e "${YELLOW}✓ DynamoDB không tồn tại${NC}\n"
fi

echo -e "${GREEN}=== DONE ===${NC}"
