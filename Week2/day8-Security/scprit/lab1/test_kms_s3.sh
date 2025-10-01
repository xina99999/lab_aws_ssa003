#!/bin/bash
set -e  # dừng script nếu có lệnh nào lỗi

echo "============================"
echo "🚀 Bắt đầu cài đặt môi trường"
echo "============================"

## Cập nhật gói
echo "[1/6] 🔄 Cập nhật apt..."
sudo apt update -y

## Cài unzip nếu chưa có
echo "[2/6] 📦 Kiểm tra unzip..."
if ! command -v unzip &> /dev/null; then
    echo "👉 unzip chưa có, tiến hành cài đặt..."
    sudo apt install -y unzip
else
    echo "✅ unzip đã được cài sẵn"
fi

## Kiểm tra AWS CLI
echo "[3/6] 🔍 Kiểm tra AWS CLI..."
if command -v aws &> /dev/null; then
    echo "✅ AWS CLI đã có sẵn: $(aws --version)"
else
    echo "👉 AWS CLI chưa có, tiến hành cài đặt..."
    curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    echo "✅ AWS CLI cài xong: $(aws --version)"
fi

## Hàm kiểm tra profile
check_profile() {
    PROFILE=$1
    if aws configure list --profile "$PROFILE" &>/dev/null; then
        echo "✅ Profile [$PROFILE] đã tồn tại"
    else
        echo "⚠️ Profile [$PROFILE] chưa cấu hình, tiến hành nhập thông tin..."
        aws configure --profile "$PROFILE"
    fi
}

## Kiểm tra UserA, UserB
echo "[4/6] 👤 Kiểm tra UserA và UserB"
check_profile "userA"
check_profile "userB"

## Thông tin bucket & file
echo "[5/6] 🧾 Chuẩn bị thông tin S3"
BUCKET="secure-bucket-demo-<your-name>"
FILE="<your-file>"

## Test download file
echo "[6/6] 🧪 Bắt đầu kiểm tra S3 download"

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
    echo "❌ UserB thất bại (thiếu quyền KMS Decrypt hoặc S3)"
fi

echo ""
echo "🎉 Script hoàn tất!"
