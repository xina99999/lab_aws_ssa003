

---

# 📘 Ngày 1 – Giới thiệu AWS & SAA-C03, Well-Architected Framework, Global Infrastructure

## 🎯 Mục tiêu

* Hiểu được tổng quan về chứng chỉ **AWS Certified Solutions Architect – Associate (SAA-C03)**.
* Nắm được **AWS Global Infrastructure**: Regions, Availability Zones (AZs), Edge Locations.
* Làm quen với **AWS Management Console**.
* Thực hành cơ bản: Tạo 1 **EC2 instance** trong 1 Region.
* Viết ghi chú để hình thành tư duy kiến trúc dựa trên **Well-Architected Framework**.

---

## 📚 Nội dung học

### 1. Giới thiệu về chứng chỉ AWS SAA-C03

* Đây là chứng chỉ **tầm trung** (Associate level), tập trung vào **thiết kế hệ thống trên AWS** có:

  * Độ sẵn sàng cao (High Availability).
  * Khả năng chịu lỗi (Fault Tolerance).
  * Tối ưu chi phí (Cost Optimization).
  * Bảo mật (Security).
* Cấu trúc đề thi:

  * Thời gian: 130 phút.
  * 65 câu hỏi (trắc nghiệm 1 hoặc nhiều đáp án).
  * Chủ đề chính: Compute, Storage, Networking, Databases, Security, Monitoring, Architecture.

### 2. AWS Well-Architected Framework (5 Pillars)

* **Operational Excellence** – Vận hành, giám sát, cải tiến.
* **Security** – Bảo mật lớp nhiều tầng (IAM, Encryption, Logging).
* **Reliability** – Hệ thống ổn định, tự động khôi phục.
* **Performance Efficiency** – Dùng tài nguyên hiệu quả, auto scaling.
* **Cost Optimization** – Tối ưu chi phí, tránh lãng phí.

### 3. AWS Global Infrastructure

* **Region**: Vùng địa lý (ví dụ: `us-east-1`, `ap-southeast-1`).
* **Availability Zone (AZ)**: Một vùng sẵn sàng độc lập trong Region (thường có 3+ AZ/Region).
* **Edge Location**: Điểm CDN (CloudFront, Route 53).
* **Cách chọn Region**:

  * Gần người dùng.
  * Yêu cầu compliance (quy định pháp lý).
  * Dịch vụ có sẵn tại Region đó.
  * Chi phí.

---

## 🛠️ Thực hành

1. **Tạo tài khoản AWS Free Tier** (nếu chưa có).
2. **Khám phá AWS Management Console**:

   * Vào **Services** → xem danh sách Compute, Storage, Networking.
   * Xem **Global dropdown** → thay đổi Region.
3. **Khởi tạo 1 EC2 Instance cơ bản**:

   * Vào **EC2 Dashboard** → chọn **Launch Instance**.
   * AMI: Amazon Linux 2 hoặc Ubuntu.
   * Instance type: `t2.micro` (Free Tier).
   * Key Pair: Tạo mới để SSH.
   * Network: chọn **Default VPC**.
   * Storage: 8GB EBS (gp2).
   * Security Group: mở cổng **22 (SSH)** và **80 (HTTP)**.
   * Launch.
4. **Kết nối SSH** vào EC2 từ terminal.

   * Linux/Mac:

     ```bash
     ssh -i your-key.pem ec2-user@<Public_IP>
     ```
   * Windows: dùng PuTTY hoặc PowerShell.
5. **Test web server đơn giản**:

   ```bash
   sudo yum install httpd -y
   sudo systemctl start httpd
   echo "Hello AWS" | sudo tee /var/www/html/index.html
   ```

   * Mở trình duyệt → dán **Public IP** → thấy "Hello AWS".

---

## 📝 Ghi chú

* AWS có **mô hình Shared Responsibility**:

  * AWS: bảo mật hạ tầng (datacenter, hardware).
  * Khách hàng: bảo mật cấu hình, dữ liệu, network.
* Hãy chú ý sự khác biệt **Region vs AZ vs Edge Location** (thi hay hỏi bẫy).
* Luôn chọn **Free Tier** để tránh phát sinh phí.
* Đây mới chỉ là bước khởi đầu, mục tiêu là **làm quen console và hạ tầng cơ bản**.

---


