
---

# 🔐 Ngày 8 – Security: Encryption (KMS), ACM, Secrets Manager; WAF, Shield, GuardDuty

## 🎯 Mục tiêu

* Hiểu và thực hành các dịch vụ bảo mật quan trọng trong AWS:

  * **KMS (Key Management Service)** – quản lý và sử dụng khóa mã hóa.
  * **ACM (AWS Certificate Manager)** – quản lý chứng chỉ SSL/TLS.
  * **Secrets Manager** – lưu trữ & xoay vòng secret (DB password, API key).
  * **WAF (Web Application Firewall)** – bảo vệ ứng dụng web.
  * **Shield** – chống tấn công DDoS.
  * **GuardDuty** – phát hiện mối đe dọa tự động.
* Biết cách **mã hóa dữ liệu trong S3**.
* Cấu hình **rule cơ bản cho WAF** để chống SQL Injection / XSS.
* Bật **GuardDuty** để giám sát account.

---

## 📚 Nội dung học

### 1. AWS KMS – Key Management Service

* Dùng để tạo và quản lý **Customer Managed Key (CMK)**.
* Tích hợp với nhiều dịch vụ AWS (S3, EBS, RDS, Lambda).
* Có 2 chế độ mã hóa:

  * **Server-Side Encryption (SSE-KMS)**.
  * **Client-Side Encryption**.

### 2. AWS Certificate Manager (ACM)

* Quản lý **SSL/TLS certificate** miễn phí cho dịch vụ như **CloudFront, ELB, API Gateway**.
* Hỗ trợ tự động **gia hạn** chứng chỉ.

### 3. AWS Secrets Manager

* Quản lý secret (mật khẩu DB, API keys).
* Hỗ trợ **automatic rotation** cho RDS, Redshift.
* So với **SSM Parameter Store** → Secrets Manager chuyên cho secret, Parameter Store thiên về config.

### 4. AWS WAF & AWS Shield

* **WAF**: Bảo vệ ứng dụng web chống lại SQL injection, XSS.

  * Tích hợp với **CloudFront, ALB, API Gateway**.
  * Rule: whitelist IP, block patterns.
* **Shield**: Dịch vụ chống DDoS.

  * **Shield Standard**: bật mặc định cho mọi service (miễn phí).
  * **Shield Advanced**: bảo vệ sâu hơn (có phí).

### 5. AWS GuardDuty

* Dịch vụ phát hiện mối đe dọa **dựa trên ML + threat intel**.
* Giám sát **CloudTrail, VPC Flow Logs, DNS logs**.
* Cảnh báo khi có hoạt động bất thường:

  * Login từ IP lạ.
  * Lưu lượng đáng ngờ.
  * API call bất thường.

---

## 🛠️ Thực hành

1. **Tạo KMS Key**

   * Vào **KMS console** → **Customer managed keys** → **Create key**.
   * Chọn **Symmetric**.
   * Gán quyền cho IAM user.

2. **Mã hóa dữ liệu trong S3 bằng KMS**

   * Tạo 1 bucket mới.
   * Upload file → chọn **Properties → Default encryption → SSE-KMS**.
   * Chọn key vừa tạo.

3. **Bật GuardDuty**

   * Vào **GuardDuty console** → **Enable GuardDuty**.
   * Kiểm tra dashboard cảnh báo.

4. **Tạo WAF Rule đơn giản**

   * Vào **WAF & Shield console** → **Web ACL** → **Create**.
   * Scope: chọn **CloudFront** hoặc **ALB**.
   * Add rule → **Managed rule groups** → bật **SQLi/XSS rule**.
   * Deploy rule vào resource.

---

## 📝 Ghi chú

* **Shared Responsibility Model** áp dụng mạnh mẽ ở security:

  * AWS bảo mật hạ tầng.
  * Bạn phải cấu hình encryption, IAM policy, WAF rule.
* **KMS & Secrets Manager** thường đi chung để bảo vệ dữ liệu ở **rest & transit**.
* **ACM certificate** chỉ free nếu dùng với service tích hợp (CloudFront, ELB, API GW). Nếu export thì phải trả phí.
* **GuardDuty không chặn, chỉ cảnh báo** → cần kết hợp với Security Hub / Lambda auto-remediation.
* **Shield Standard** đã đủ cho hầu hết app vừa và nhỏ.

---

