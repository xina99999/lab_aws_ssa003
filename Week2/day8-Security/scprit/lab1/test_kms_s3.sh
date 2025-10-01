#!/bin/bash
## Cài dặt các tài nguyên cần thiết
sudo apt update
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install


## Cấu hình CLI UserA, UserB
aws configure --profile userA
aws configure --profile userB




# Tên bucket và file bạn muốn test
BUCKET="secure-bucket-demo-<your-name>"
FILE="<your-file>"

echo "============================"
echo "🔐 Test download with UserA"
echo "============================"
aws s3 cp s3://$BUCKET/$FILE ./userA_$FILE --profile userA

if [ $? -eq 0 ]; then
    echo "✅ UserA đã tải file thành công (có quyền S3 + KMS)"
else
    echo "❌ UserA thất bại"
fi

echo ""
echo "============================"
echo "🔐 Test download with UserB"
echo "============================"
aws s3 cp s3://$BUCKET/$FILE ./userB_$FILE --profile userB

if [ $? -eq 0 ]; then
    echo "✅ UserB đã tải file thành công (có quyền S3 + KMS)"
else
    echo "❌ UserB thất bại (thiếu quyền KMS Decrypt)"
fi
