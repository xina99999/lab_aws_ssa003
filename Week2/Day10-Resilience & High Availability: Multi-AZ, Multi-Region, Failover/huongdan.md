
---

# 🌐 Ngày 10 – Resilience & High Availability: Multi-AZ, Multi-Region, Failover

## 🎯 Mục tiêu

* Hiểu khái niệm và tầm quan trọng của **Resilience** và **High Availability (HA)** trong kiến trúc AWS.
* Phân biệt **Multi-AZ** và **Multi-Region**.
* Biết cách cấu hình **RDS Multi-AZ** và **Cross-Region Replication**.
* Thực hành **failover và recovery** để đảm bảo hệ thống luôn sẵn sàng.
* Ứng dụng trong các **domain quan trọng về resilience** (Database, Application Layer, Storage).

---

## 📚 Nội dung học

### 1. Khái niệm Resilience & High Availability

* **Resilience**: khả năng hệ thống **chịu lỗi và phục hồi** khi có sự cố (ví dụ: instance, AZ, hoặc region bị down).
* **High Availability (HA)**: đảm bảo hệ thống **luôn sẵn sàng phục vụ** — thường đạt bằng cách nhân bản và phân tán tài nguyên.
* AWS cung cấp hạ tầng nhiều tầng để tăng resilience:

  * **Multi-AZ** → chịu lỗi trong cùng 1 region.
  * **Multi-Region** → đảm bảo dịch vụ vẫn chạy dù 1 region mất kết nối hoàn toàn.

---

### 2. Multi-AZ (Availability Zone)

* Áp dụng chủ yếu cho dịch vụ **RDS, ElastiCache, EFS, EC2 Auto Scaling**.
* Dữ liệu **được đồng bộ (synchronous)** giữa AZ chính và AZ standby.
* Khi AZ chính bị lỗi, AWS **tự động failover** sang AZ standby.
* Không cần thay đổi endpoint — ứng dụng tiếp tục hoạt động bình thường.

📌 Ví dụ:
`RDS Multi-AZ` → có **Primary DB** ở `ap-southeast-1a`, **Standby DB** ở `ap-southeast-1b`.
Khi AZ 1a lỗi, traffic tự động chuyển sang 1b.

---

### 3. Multi-Region Deployment

* Dùng khi muốn bảo vệ hệ thống khỏi lỗi **mất toàn bộ region**.
* Triển khai ứng dụng, database và dữ liệu trên **từ 2 region trở lên**.
* Mục tiêu: **Disaster Recovery (DR)** & **Global Latency Optimization**.

📘 Các mô hình phổ biến:

| Kiểu DR          | Mô tả                                    | RTO  | RPO  |
| ---------------- | ---------------------------------------- | ---- | ---- |
| Backup & Restore | Lưu dữ liệu backup sang region khác      | Cao  | Cao  |
| Pilot Light      | Chạy core service nhỏ, kích hoạt khi lỗi | TB   | TB   |
| Warm Standby     | Có bản thu nhỏ standby                   | TB   | TB   |
| Active-Active    | 2 region chạy song song                  | Thấp | Thấp |

---

### 4. Cross-Region Replication

* **S3 Cross-Region Replication (CRR)** → sao chép dữ liệu tự động giữa 2 bucket khác region.
* **RDS Read Replica Cross-Region** → tạo bản sao đọc dữ liệu ở region khác.
* Dùng để:

  * Giảm latency cho user ở khu vực khác.
  * Phục hồi nhanh nếu region chính lỗi.

---

### 5. Failover & Recovery

* **Failover**: chuyển sang hệ thống dự phòng khi có sự cố.

  * AWS RDS: tự động failover khi primary DB lỗi.
  * Route 53: có thể cấu hình **Health Check + Failover Routing Policy**.
* **Recovery**: quá trình khôi phục hệ thống sau khi lỗi được xử lý.

  * Dùng **backup snapshot, replication data** để phục hồi.

---

## 🛠️ Thực hành

1. **Triển khai RDS Multi-AZ**

   * Tạo RDS mới → chọn **Multi-AZ deployment: Yes**.
   * Kiểm tra endpoint (chỉ có 1, failover tự động).
   * Dừng AZ chính (bằng simulate hoặc maintenance) → quan sát failover.

2. **Thiết lập RDS Read Replica (Cross-Region)**

   * Chọn RDS instance → **Create read replica** → chọn region khác.
   * Test đọc dữ liệu từ region phụ.

3. **S3 Cross-Region Replication**

   * Tạo 2 bucket ở 2 region khác nhau.
   * Bật **Versioning** cho cả hai.
   * Cấu hình **Replication Rule** từ bucket A → B.
   * Upload file → kiểm tra bản sao tự động sang region B.

4. **Route 53 Failover**

   * Tạo 2 record: **Primary (active)** và **Secondary (standby)**.
   * Gắn **Health Check** để tự động chuyển hướng khi Primary down.

---

## 📝 Ghi chú

* **Multi-AZ ≠ Multi-Region**: Multi-AZ tăng HA, Multi-Region phục vụ DR & global users.
* **Chi phí Multi-Region cao** → chỉ dùng khi ứng dụng yêu cầu uptime rất cao (financial, healthcare, global SaaS).
* **Test failover định kỳ** để đảm bảo hệ thống hoạt động đúng như thiết kế.
* **S3 CRR và RDS Replication** không tự động failback → cần xử lý thủ công hoặc script.
* **Route 53 health check** là giải pháp đơn giản nhưng hiệu quả để tự động chuyển hướng traffic khi xảy ra lỗi.

---


