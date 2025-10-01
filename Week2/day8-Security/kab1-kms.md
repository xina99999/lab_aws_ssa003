
---

# 🧪 Lab: Dùng AWS KMS để mã hóa dữ liệu trong S3

## 🎯 Mục tiêu

* Tạo **KMS key** để mã hóa dữ liệu.
* Upload file lên **S3 bucket** với mã hóa **SSE-KMS**.
* Thử nghiệm quyền truy cập với IAM user khác (có/không có quyền `kms:Decrypt`).

---

## 🛠️ Các bước thực hiện

### **Bước 1: Tạo Customer Managed KMS Key**

1. Vào **AWS Management Console** → tìm **KMS**.
2. Chọn **Customer managed keys** → **Create key**.
3. Chọn loại key: **Symmetric** (dùng phổ biến với S3, EBS, RDS).
4. Nhập tên key: `my-s3-kms-key`.
5. Trong mục **Key administrators**: chọn user/role của bạn (ví dụ `AdminUser`).
6. Trong mục **Key users**: chọn user/role nào được phép dùng key này để mã hóa/giải mã.

   * Ví dụ: chọn `Alice` để thử nghiệm.
7. Tạo key.

---

### **Bước 2: Tạo S3 Bucket**

1. Vào **S3 console** → **Create bucket**.
2. Đặt tên: `secure-bucket-demo-<yourname>`.
3. Chọn region giống với KMS key.
4. Trong phần **Default encryption**: chọn **AWS KMS key** → chọn key vừa tạo (`my-s3-kms-key`).
5. Tạo bucket.

---

### **Bước 3: Upload File vào S3**

1. Vào bucket vừa tạo.
2. Upload file ví dụ `customer-data.txt`.
3. Kiểm tra **Properties → Server-side encryption**: thấy `aws:kms` và `my-s3-kms-key`.

---

### **Bước 4: Test với IAM Policy**

1. Tạo 2 IAM user: `UserA` và `UserB`.

   * `UserA`: có quyền `s3:GetObject` **và** `kms:Decrypt`.
   * `UserB`: chỉ có quyền `s3:GetObject`, **không có `kms:Decrypt`**.

#### IAM Policy cho **UserA** (đọc được file)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::secure-bucket-demo-<yourname>/*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": "arn:aws:kms:us-east-1:123456789012:key/<your-key-id>"
    }
  ]
}
```

#### IAM Policy cho **UserB** (sẽ bị lỗi)

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::secure-bucket-demo-<yourname>/*"
    }
  ]
}
```

---

### **Bước 5: Thử nghiệm tải file**

* Đăng nhập AWS CLI bằng `UserA`:

  ```bash
  aws s3 cp s3://secure-bucket-demo-<yourname>/customer-data.txt .
  ```

  ✅ Thành công (UserA có `s3:GetObject` + `kms:Decrypt`).

* Đăng nhập bằng `UserB`:

  ```bash
  aws s3 cp s3://secure-bucket-demo-<yourname>/customer-data.txt .
  ```

  ❌ Thất bại, lỗi `AccessDenied` vì không có quyền `kms:Decrypt`.

---

## 📌 Kết quả mong đợi

* UserA đọc được file (vì có quyền cả **S3** + **KMS**).
* UserB **không đọc được**, dù có quyền `s3:GetObject`, nhưng thiếu quyền `kms:Decrypt`.

👉 Đây là minh chứng thực tế cho việc **IAM policy + KMS policy phải phối hợp với nhau**.

---
