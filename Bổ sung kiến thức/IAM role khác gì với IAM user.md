

---

## 🔬 **LAB: Phân biệt IAM User và IAM Role + AssumeRole bằng STS**

---

### 🎯 Mục tiêu lab:

1. Tạo một IAM User và thử sử dụng nó với Access Key.
2. Tạo một IAM Role cho phép người khác "AssumeRole".
3. Từ IAM User → dùng **AWS STS AssumeRole** để tạm thời lấy quyền từ IAM Role.
4. So sánh kết quả giữa dùng User trực tiếp và dùng Role qua AssumeRole.

---

## 🧱 Phần chuẩn bị:

Bạn cần:

* Tài khoản AWS (hoặc quyền admin trong tài khoản).
* AWS CLI (đã cài đặt và cấu hình).
* Một trình soạn thảo văn bản (VS Code, Notepad++...).
* Thời gian: ~30 phút.

---

## 🧪 Bắt đầu Lab:

---

### ✅ Bước 1: Tạo IAM User (ví dụ: `LabUser`)

1. Vào [AWS IAM Console](https://console.aws.amazon.com/iam/)
2. Chọn **Users** > **Add users**
3. Tên user: `LabUser`
4. Chọn **Access key - Programmatic access**
5. Next → Attach existing policies → Chọn: `AmazonS3ReadOnlyAccess`
6. Tạo user, **ghi lại Access Key và Secret Key**

👉 **Đây là user có quyền đọc S3 bằng key cố định**

---

### ✅ Bước 2: Cấu hình AWS CLI cho LabUser

Mở terminal và nhập:

```bash
aws configure --profile labuser
```

Nhập:

* Access Key ID
* Secret Access Key
* Region: `us-east-1` (hoặc theo bạn)
* Output format: `json`

Kiểm tra hoạt động:

```bash
aws s3 ls --profile labuser
```

---

### ✅ Bước 3: Tạo IAM Role (ví dụ: `LabRole`)

1. Vào IAM Console → Roles → Create role
2. Chọn **Trusted entity** là: `Another AWS account`
3. Nhập **Account ID** của tài khoản bạn đang dùng (bạn sẽ cho `LabUser` assume role này)
4. Attach policy: `AmazonEC2ReadOnlyAccess`
5. Tên role: `LabRole`
6. Tạo xong, ghi lại **ARN của role**, ví dụ:
   `arn:aws:iam::111122223333:role/LabRole`

---

### ✅ Bước 4: Cấp quyền cho `LabUser` được **AssumeRole**

1. Vào IAM Console → Policies → Create policy
2. JSON policy như sau:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "arn:aws:iam::111122223333:role/LabRole"
    }
  ]
}
```

3. Save & attach policy này vào `LabUser`

---

### ✅ Bước 5: Sử dụng `LabUser` để AssumeRole

Tạo file shell/script hoặc chạy lệnh CLI:

```bash
aws sts assume-role \
    --role-arn "arn:aws:iam::111122223333:role/LabRole" \
    --role-session-name "LabSession" \
    --profile labuser
```

👉 Kết quả trả về gồm:

* AccessKeyId
* SecretAccessKey
* SessionToken

Copy 3 thông tin này và **tạm thời cấu hình profile mới**:

```bash
aws configure --profile labrole
```

* Nhập thông tin credentials tạm thời.
* Dùng profile `labrole` để thử truy cập EC2:

```bash
aws ec2 describe-instances --profile labrole
```

---

### ✅ Bước 6: So sánh kết quả

| Hành động            | Dùng `labuser` (IAM User) | Dùng `labrole` (IAM Role qua STS) |
| -------------------- | ------------------------- | --------------------------------- |
| Truy cập S3          | ✅ Thành công              | ❌ Không có quyền                  |
| Truy cập EC2         | ❌ Không được phép         | ✅ Thành công                      |
| Access Key vĩnh viễn | ✅                         | ❌ (tạm thời, có thời hạn)         |
| Bảo mật              | Trung bình                | Cao hơn (tạm thời)                |

---

## 📘 Kết luận sau Lab:

* **IAM User**: tiện, nhưng ít an toàn nếu chia sẻ key.
* **IAM Role** + STS: giải pháp linh hoạt, bảo mật cao, dùng cho **bên thứ ba** hoặc **dịch vụ AWS**.

---


