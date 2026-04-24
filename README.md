# NT542-Group02-Terraform

## 📂 Cấu trúc thư mục

```bash
├── main.tf              # File chính: gọi tất cả modules (mọi member thêm code ở đây)
├── variables.tf         # Khai báo biến dùng chung toàn project
├── outputs.tf           # Output dùng chung giữa các module
├── provider.tf          # Cấu hình AWS provider (region, profile)
├── backend.tf           # Cấu hình remote state (S3 + DynamoDB)
├── create_backend.sh    # Script tạo S3 + DynamoDB (chạy trước terraform init)
├── delete_backend.sh    # Script xóa backend (chạy sau terraform destroy)
│
├── modules/
│   │
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── bastion/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── security-groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── rds-aurora/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── efs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── elasticache-redis/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2-web/
│   │   ├── main.tf
│   │   ├── user_data.sh
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── autoscaling/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── cloudfront/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf

```

## Deploy Hạ tầng

### 1. Cấp quyền thực thi cho script
Chạy lệnh sau để cấp quyền cho các file shell script:

```bash
chmod +x create_backend.sh
chmod +x delete_backend.sh
```

### 2. Khởi tạo backend
Chạy script tạo backend:

```bash
bash create_backend.sh
```

### 3. Khởi tạo Terraform
Sau khi backend đã được tạo, khởi tạo Terraform:

```bash
terraform init
```

### 4. Triển khai hạ tầng 
Áp dụng cấu hình Terraform để tạo hạ tầng gồm những thành phần trong hệ thống:

```bash
terraform apply
```

### 5. Destroy hạ tầng và xóa backend

Xóa hạ tầng khi xong, tránh mất tiền:

```bash
terraform destroy
bash delete_backend.sh
```
