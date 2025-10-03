

---

# 📊 Ngày 9 – Monitoring: CloudWatch, CloudTrail, AWS Config, X-Ray

## 🎯 Mục tiêu

* Hiểu và thực hành các dịch vụ monitoring & auditing trong AWS:

  * **CloudWatch** – thu thập log, metrics, alarm.
  * **CloudTrail** – ghi lại API calls & hoạt động trong tài khoản.
  * **AWS Config** – theo dõi compliance & thay đổi cấu hình resource.
  * **X-Ray** – tracing ứng dụng, phân tích request flow.
* Biết cách **tạo CloudWatch Alarm** để cảnh báo sự cố.
* Hiểu cách **log & audit** hoạt động của user/service.
* Dùng **X-Ray** để phân tích latency & lỗi trong ứng dụng.

---

## 📚 Nội dung học

### 1. Amazon CloudWatch

* Thu thập **metrics** (CPU, memory, network, custom).
* **Logs**: lưu log từ EC2, Lambda, API Gateway…
* **Alarms**: thiết lập cảnh báo khi vượt threshold.
* **Dashboards**: trực quan hóa tình trạng hệ thống.

### 2. AWS CloudTrail

* Ghi lại toàn bộ **API call** trong account.
* Bao gồm **AWS Console, SDK, CLI, service-to-service**.
* Lưu log vào **S3** + có thể gửi sang **CloudWatch Logs** để phân tích.
* Hữu ích cho **audit & security investigation**.

### 3. AWS Config

* Theo dõi **cấu hình tài nguyên** (S3 bucket, Security Group, IAM…).
* Cho biết **ai thay đổi, thay đổi gì, khi nào**.
* Có thể tạo **Config Rules** để kiểm tra compliance (ví dụ: S3 phải bật encryption).

### 4. AWS X-Ray

* Phân tích **end-to-end request tracing**.
* Giúp debug ứng dụng microservices.
* Hiển thị **latency, bottleneck, error rate**.

---

## 🛠️ Thực hành

1. **Bật CloudTrail**

   * Vào **CloudTrail console** → **Create trail**.
   * Chọn lưu log vào **S3 bucket**.
   * Kích hoạt ghi sự kiện cho **Management Events** & **Data Events**.

2. **Tạo CloudWatch Alarm**

   * Vào **CloudWatch console → Alarms → Create**.
   * Chọn metric (ví dụ: CPUUtilization > 70%).
   * Chọn **SNS topic** để gửi thông báo email.

3. **Cấu hình AWS Config**

   * Vào **AWS Config console → Get started**.
   * Chọn resource muốn track (S3, EC2, IAM…).
   * Tạo rule kiểm tra S3 bucket **phải bật public access block**.

4. **Thử tracing với X-Ray**

   * Bật X-Ray trong Lambda function hoặc EC2 app.
   * Gửi request test → xem **Service map** để phân tích.

---

## 📝 Ghi chú

* **CloudWatch** = monitoring & alert.
* **CloudTrail** = audit & log API calls.
* **AWS Config** = compliance & tracking changes.
* **X-Ray** = request tracing & performance debugging.
* Thường kết hợp:

  * CloudTrail → gửi log vào CloudWatch Logs → tạo Alarm khi có API bất thường.
  * Config + CloudWatch → giám sát compliance + cảnh báo tự động.
* Đây là nền tảng cho **operational excellence** trong AWS Well-Architected Framework.

---


