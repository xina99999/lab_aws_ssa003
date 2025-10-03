
---

# 🧪 Labs – Monitoring & Auditing

## **Lab 1 – CloudTrail: Audit API Calls**

**Mục tiêu:** Kiểm tra hoạt động người dùng & API trong AWS account.

### Bước làm:

1. Vào **CloudTrail Console → Create trail**.

   * Trail name: `AuditTrail`
   * Chọn **S3 bucket** để lưu log.
   * Bật **Management Events** + **Data Events** (S3, Lambda).
    <img width="1288" height="577" alt="image" src="https://github.com/user-attachments/assets/70c86252-6967-4d3f-9f8e-4d56df3ef96c" />

2. Dùng CLI/Console thực hiện vài thao tác test (tạo S3 bucket, xóa bucket, start/stop EC2).
3. Vào **CloudTrail → Event history**, tìm log xem:

   * Ai thực hiện?
   * Từ service nào?
   * Thao tác có thành công không?

✅ **Kết quả mong đợi:** Bạn đọc được log chi tiết `CreateBucket`, `TerminateInstances`…


