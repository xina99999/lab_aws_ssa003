
---

# 💰 Ngày 13 – Cost Optimization: Cost Explorer, Spot, Reserved, Rightsizing

## 🎯 Mục tiêu

* Hiểu nguyên tắc **Tối ưu chi phí (Cost Optimization)** trong AWS.
* Biết cách sử dụng **Cost Explorer** để phân tích chi phí.
* Nắm rõ sự khác biệt giữa **On-Demand, Reserved, và Spot Instance**.
* Thiết lập **Billing Alerts** để cảnh báo vượt ngân sách.
* Thực hành **Rightsizing** – chọn tài nguyên phù hợp với nhu cầu thật.
* Tư duy **trade-offs giữa cost – performance – availability**.

---

## 📚 Nội dung học

### 1. Tổng quan về Cost Optimization

AWS đề xuất **5 trụ cột (pillars)** trong Well-Architected Framework, trong đó **Cost Optimization** giúp bạn:

* Tránh chi tiêu dư thừa.
* Tối đa hóa hiệu năng với chi phí thấp nhất.
* Theo dõi và tối ưu liên tục.

📘 Các nguyên tắc chính:

| Nguyên tắc    | Mô tả                                          |
| ------------- | ---------------------------------------------- |
| **Measure**   | Theo dõi chi phí bằng Cost Explorer & Budgets  |
| **Analyze**   | Xác định dịch vụ nào chiếm phần lớn ngân sách  |
| **Optimize**  | Dùng Spot, Reserved, Savings Plans             |
| **Eliminate** | Gỡ tài nguyên không còn dùng                   |
| **Automate**  | Tự động scale down hoặc stop resource khi idle |

---

### 2. Cost Explorer – Phân tích chi phí

**Cost Explorer** là công cụ trực quan giúp xem:

* Chi phí theo **dịch vụ, tài khoản, vùng (region)**.
* Xu hướng chi tiêu (theo ngày / tháng).
* Dự báo chi phí (forecast).

📘 **Cách bật Cost Explorer:**

1. Mở **Billing Console** → chọn **Cost Explorer**.
2. Nhấn **Enable Cost Explorer** (nếu chưa bật).
3. Sau vài giờ, AWS sẽ hiển thị dữ liệu chi tiêu.

📊 **Các biểu đồ quan trọng:**

* “Monthly costs by service” – chi phí theo dịch vụ.
* “Usage type” – loại tài nguyên chiếm nhiều nhất.
* “Forecast” – dự đoán chi phí 3 tháng tới.

📸 Ảnh minh họa: <img width="1450" alt="image" src="https://github.com/user-attachments/assets/a74e88c4-20c3-4685-81a7-8e79d4d69e5d" />

---

### 3. Billing Alerts – Cảnh báo chi phí

Để tránh vượt ngân sách bất ngờ, bạn nên tạo **AWS Budgets** và **Billing Alerts**.

📘 **Cách làm:**

1. Mở **Billing → Budgets → Create Budget**.
2. Chọn loại **Cost Budget**.
3. Đặt giới hạn (ví dụ: `$10` / tháng).
4. Chọn **Email alert** khi vượt 80%, 100%.

💡 *Tip:*
Dùng **SNS Topic** để gửi cảnh báo đến nhiều người (Dev, QA, Finance...).

📸 Ảnh minh họa: <img width="1350" alt="image" src="https://github.com/user-attachments/assets/f6f1e63e-96a9-4d8a-8883-73b84f09b414" />

---

### 4. Spot Instance – Tiết kiệm đến 90%

**Spot Instance** tận dụng **EC2 dư thừa** trong AWS, giá rẻ hơn **On-Demand** tới 90%.

📘 **Đặc điểm:**

| Thuộc tính   | Spot Instance                                         |
| ------------ | ----------------------------------------------------- |
| Giá          | Rẻ hơn đến 90%                                        |
| Tính ổn định | Có thể bị AWS thu hồi bất kỳ lúc nào (2 phút notice)  |
| Dùng cho     | Batch job, data processing, CI/CD runner, training ML |

💡 **Trade-off:**
Giá cực rẻ ↔ Không đảm bảo chạy liên tục.

🧩 **Thực hành:**

1. Mở **EC2 Console** → Launch Instance.
2. Chọn tab **Advanced Details** → bật **Request Spot Instance**.
3. Chọn “Terminate when interrupted”.
4. Deploy workload → theo dõi qua **EC2 → Spot Requests**.

📸 Ảnh minh họa: <img width="1425" alt="image" src="https://github.com/user-attachments/assets/3b02aaf5-9c37-4a3e-99b0-3d0270f9a5b7" />

---

### 5. Reserved Instance & Savings Plan

Đối với workload chạy lâu dài và ổn định, nên dùng **Reserved Instance (RI)** hoặc **Savings Plan** để tiết kiệm.

📘 **So sánh:**

| Loại                  | Giảm giá | Cam kết           | Linh hoạt                       |
| --------------------- | -------- | ----------------- | ------------------------------- |
| **On-Demand**         | 0%       | Không cần cam kết | Cao                             |
| **Reserved Instance** | 40–75%   | 1 hoặc 3 năm      | Cố định instance type           |
| **Savings Plan**      | 40–70%   | 1 hoặc 3 năm      | Linh hoạt theo instance, region |

📊 **Khi nào nên dùng:**

* Dịch vụ chạy **liên tục (24/7)** → Reserved.
* Dịch vụ **chạy linh hoạt (auto-scale)** → Savings Plan.
* Dịch vụ **chạy ngắt quãng / batch job** → Spot.

---

### 6. Rightsizing – Chọn kích thước tài nguyên tối ưu

**Rightsizing** là quá trình điều chỉnh tài nguyên (EC2, RDS...) sao cho **vừa đủ** dùng:

* Không thừa → tránh lãng phí.
* Không thiếu → tránh bottleneck hiệu năng.

📘 **Cách thực hiện:**

1. Mở **AWS Compute Optimizer** hoặc **Trusted Advisor**.
2. Kiểm tra đề xuất “Underutilized EC2”.
3. Giảm instance type hoặc tắt khi idle.

💡 *Ví dụ:*
Bạn có EC2 `t3.large` (2vCPU, 8GB) nhưng CPU chỉ dùng 10% → có thể hạ xuống `t3.micro` tiết kiệm ~80%.

---

## 🛠️ Thực hành

### 1. Bật Cost Explorer và phân tích chi phí

1. Mở **Billing Console → Cost Explorer**.
2. Chọn khoảng thời gian 1 tháng gần nhất.
3. Xem “Cost by Service” → ghi lại top 3 dịch vụ tốn nhất.
4. Chọn “Forecast” để xem dự đoán chi phí.

---

### 2. Tạo Billing Alerts qua Budgets

1. Mở **Budgets → Create a budget**.
2. Chọn **Cost budget** và đặt ngưỡng `$10`.
3. Chọn **SNS Topic** hoặc email nhận cảnh báo.
4. Test bằng cách khởi chạy 1 EC2 instance vài giờ.

---

### 3. Thử tạo Spot Instance

1. EC2 Console → **Launch Instance**.
2. Trong “Advanced settings” → bật **Request Spot Instance**.
3. Chạy workload (ví dụ: `stress-ng` để test CPU).
4. Quan sát khi AWS reclaim → instance tự động terminate.

---

### 4. Thử Reserved Instance (mô phỏng)

1. EC2 Console → **Reserved Instances → Purchase Reserved Instances**.
2. Chọn region và instance type bạn thường dùng (ví dụ `t3.micro`).
3. So sánh giá On-Demand vs Reserved.
4. Ghi nhận mức tiết kiệm %.

---

## 🧩 Kiến trúc & Trade-offs

```
         +-------------------+
         |   Cost Explorer   |
         +---------+---------+
                   |
          +--------v--------+
          |  AWS Budgets    |
          +--------+--------+
                   |
   +---------------+---------------+
   | Spot | Reserved | On-Demand   |
   +---------------+---------------+
                   |
             Workload/Apps
```

💡 **Trade-offs:**

| Giải pháp             | Ưu điểm                  | Nhược điểm        |
| --------------------- | ------------------------ | ----------------- |
| **Spot Instance**     | Giá rẻ 90%               | Có thể bị thu hồi |
| **Reserved Instance** | Ổn định, tiết kiệm 60%   | Ít linh hoạt      |
| **Savings Plan**      | Linh hoạt hơn RI         | Cần dự đoán usage |
| **On-Demand**         | Dễ dùng, không ràng buộc | Giá cao nhất      |

---

## 📝 Ghi chú

* Dùng **Tags** (`Project`, `Owner`, `Env`) để theo dõi chi phí từng nhóm.
* **CloudWatch + Lambda** có thể tự động stop instance ban đêm.
* **Compute Optimizer** gợi ý instance “over-provisioned”.
* **S3 Lifecycle Policies** tự động chuyển dữ liệu sang lớp rẻ hơn (IA, Glacier).
* Luôn định kỳ review chi phí hàng tháng (Cost Review Meeting).

---

## 🧠 Tổng kết

| Công cụ / Khái niệm          | Mục đích                       | Lợi ích                |
| ---------------------------- | ------------------------------ | ---------------------- |
| **Cost Explorer**            | Phân tích chi phí              | Dễ theo dõi và dự báo  |
| **Budgets / Alerts**         | Cảnh báo vượt chi phí          | Kiểm soát ngân sách    |
| **Spot Instances**           | Giảm chi phí tính toán         | Rẻ nhưng không ổn định |
| **Reserved / Savings Plans** | Tiết kiệm cho workload cố định | Giảm 40–70%            |
| **Rightsizing**              | Tối ưu tài nguyên              | Giảm lãng phí          |

---


