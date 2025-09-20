
---

# 🔐 Ngày 2 – IAM: Users, Groups, Roles, Policies, IAM Best Practices, MFA, IAM Federation

## 🎯 Mục tiêu

* Hiểu được vai trò của **IAM (Identity and Access Management)** trong bảo mật hệ thống AWS.
* Thành thạo việc tạo **User, Group, Role** và viết **Policy** theo nhu cầu thực tế.
* Áp dụng **Best Practices** để bảo vệ tài khoản AWS.
* Thực hành **MFA** và thử nghiệm **Cross-account Access / Federation** (nếu có thể).

---

## 📚 Nội dung học

### 1. IAM là gì?

* **IAM (Identity and Access Management)** là dịch vụ giúp bạn quản lý người dùng và quyền truy cập trong AWS.
* Quản lý:

  * **Users** – Người dùng có danh tính cụ thể.
  * **Groups** – Tập hợp user có chung quyền.
  * **Roles** – Danh tính tạm thời, dùng cho dịch vụ AWS hoặc người dùng từ tài khoản khác.
  * **Policies** – Tập hợp các quyền (permissions) dạng JSON.

### 2. Tạo IAM User, Group, Role

#### ✅ IAM Users

* Tạo user mới và cấp quyền sử dụng Console hoặc programmatic access (CLI/SDK).
* Gán user vào Group hoặc gán trực tiếp policy.
* Tạo Access Key nếu dùng CLI/SDK (cẩn thận bảo mật!).

#### ✅ IAM Groups

* Tạo nhóm để dễ quản lý quyền truy cập.
* Gán policies cho nhóm, sau đó thêm user vào nhóm.

#### ✅ IAM Roles

* Dùng cho:

  * EC2, Lambda, S3… cần quyền để thực thi tác vụ.
  * Cross-account access.
* Gồm 2 phần:

  * **Permissions Policy** – xác định quyền.
  * **Trust Policy** – xác định ai/đối tượng nào có thể assume role.

### 3. Viết IAM Policies

* Policies là file JSON xác định cho phép hoặc từ chối các hành động cụ thể.
* Cấu trúc cơ bản:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::your-bucket-name"
    }
  ]
}
```

* Có thể viết **custom policy** hoặc sử dụng **managed policy** có sẵn từ AWS.

### 4. IAM Best Practices

* Không dùng user **root** trừ khi thật sự cần.
* Áp dụng **Principle of Least Privilege** – cấp quyền tối thiểu cần thiết.
* Bật **MFA** cho tất cả các user quan trọng.
* **Không chia sẻ Access Keys**, nên sử dụng roles thay thế nếu có thể.
* **Xoá user/role/policy không dùng** để giảm rủi ro bảo mật.
* **Bật AWS CloudTrail** để ghi lại hành động IAM và giám sát truy cập.

### 5. Cấu hình MFA (Multi-Factor Authentication)

* Bật MFA cho user, đặc biệt là root và các user có quyền cao.
* Các loại MFA:

  * Virtual MFA (Google Authenticator, Authy).
  * Hardware MFA (YubiKey…).
* Cách cấu hình:

  * Vào IAM → Users → chọn user → **Security credentials** → **Assign MFA device**.

### 6. IAM Federation / Cross-Account Access

* **IAM Federation**: Cho phép truy cập vào AWS từ hệ thống xác thực bên ngoài (AD, SSO, Google Workspace…).
* **Cross-account role**:

  * Tạo role trong tài khoản B, cho phép tài khoản A assume role đó.
  * Tài khoản A cần quyền `sts:AssumeRole`.

**Ví dụ trust policy** cho cross-account role:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456789012:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

---

## 🛠️ Thực hành

1. **Tạo 1 IAM User** mới:

   * Chọn programmatic access nếu muốn dùng CLI.
   * Gán vào group `Developers` (tạo mới nếu chưa có).

2. **Tạo Group và gán Policy**:

   * Tạo group `Developers`.
   * Gán policy `AmazonS3ReadOnlyAccess`.

3. **Tạo 1 IAM Role cho EC2**:

   * Role: `EC2-S3-Access`.
   * Trust: EC2.
   * Gán policy `AmazonS3FullAccess`.

4. **Viết 1 custom policy** chỉ cho phép truy cập S3 bucket cụ thể:

   * Gán vào user hoặc group.
   * Test với AWS CLI để xác nhận quyền.

5. **Bật MFA cho IAM User**:

   * Dùng app điện thoại (Google Authenticator).
   * Test login có yêu cầu MFA.

6. **Thử nghiệm Cross-account Role (nếu có nhiều tài khoản)**:

   * Tạo role trong tài khoản B.
   * Test từ tài khoản A với `aws sts assume-role`.

---

## 📝 Ghi chú

* IAM là phần **nền tảng bảo mật** cực kỳ quan trọng trong AWS.
* Luôn bật MFA, dùng **role thay vì Access Key** nếu được.
* Không gán trực tiếp quyền cho user → nên gán qua group.
* Tận dụng các policy có sẵn từ AWS, chỉ custom khi cần đặc biệt.
* Hãy test các chính sách với **IAM Policy Simulator**.
* Quản lý IAM tốt là nền tảng để đạt trụ cột **Security** trong Well-Architected Framework.

---

