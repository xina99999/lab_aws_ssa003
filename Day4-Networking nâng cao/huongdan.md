

---

# 📘 Ngày 4 – AWS Networking nâng cao: Load Balancer, Auto Scaling, VPC Peering, VPN, Transit Gateway, Direct Connect

---

## 🎯 Mục tiêu

* Hiểu rõ các dịch vụ **networking nâng cao** của AWS.
* Biết cách thiết lập hệ thống **cân bằng tải (ELB)** và **Auto Scaling**.
* Làm quen với mô hình kết nối **VPC Peering**, **Site-to-Site VPN**.
* Hiểu khái niệm và vai trò của **Transit Gateway** và **Direct Connect**.
* Thực hành thiết lập hạ tầng mạng linh hoạt, có tính mở rộng cao.

---

## 📚 Nội dung học

### 1. Elastic Load Balancing (ELB)

* Dịch vụ cân bằng tải traffic đến nhiều EC2 instance.
* Có 3 loại chính:

  * **Application Load Balancer (ALB)** – Layer 7 (HTTP/HTTPS), hỗ trợ host/path-based routing.
  * **Network Load Balancer (NLB)** – Layer 4 (TCP/UDP), hiệu suất cao, độ trễ thấp.
  * **Gateway Load Balancer (GWLB)** – Kết hợp firewall appliance, dùng trong bảo mật.

🔑 Ghi nhớ:

> ALB dùng phổ biến nhất trong web app vì hỗ trợ routing thông minh (host, path, header).

---

### 2. Auto Scaling Group (ASG)

* Tự động thêm hoặc bớt EC2 instance dựa trên:

  * CPU Utilization
  * Network traffic
  * Lịch định sẵn (Scheduled)
* Gồm các thành phần:

  * **Launch Template** hoặc Launch Configuration
  * **Scaling Policies** (manual, target tracking, step scaling)
  * **Health Checks** – tự động thay thế instance lỗi.

---

### 3. VPC Peering

* Kết nối **2 VPC** để trao đổi traffic nội bộ qua private IP.
* Hạn chế: **Không hỗ trợ routing chuyển tiếp (transitive routing)**.
* Cần cập nhật **Route Table** + **Security Group** cho cả 2 VPC.

---

### 4. Site-to-Site VPN

* Kết nối hạ tầng on-premises đến AWS VPC qua mạng Internet (IPsec VPN).
* Cần 2 thành phần:

  * **Customer Gateway (CGW)** – đại diện phía on-prem.
  * **Virtual Private Gateway (VGW)** – phía AWS.
* Có thể sử dụng **EC2 chạy OpenVPN** để giả lập phía on-prem (trong lab).

---

### 5. AWS Transit Gateway (TGW)

* Là **hub mạng trung tâm**, kết nối nhiều VPC, VPN, Direct Connect.
* Hỗ trợ routing dạng transit – khắc phục điểm yếu của VPC Peering.
* Quản lý routing tập trung, dễ mở rộng.

---

### 6. AWS Direct Connect

* Kết nối vật lý chuyên dụng từ on-premises đến AWS.
* Ưu điểm:

  * **Không qua Internet**, bảo mật và ổn định hơn VPN.
  * **Độ trễ thấp**, băng thông cao (1 Gbps, 10 Gbps,...).
* Thường dùng trong các hệ thống lớn, cần đảm bảo hiệu suất cao.

---

## 🛠️ Thực hành

### 🔬 Lab 1: Thiết lập Application Load Balancer + Auto Scaling Group

#### ✅ Mục tiêu:

Tự động scale EC2 instance và cân bằng tải qua ALB.

#### Các bước:

1. **Tạo VPC** và 2 Subnet ở 2 AZ khác nhau.

2. Tạo **Security Group**:

   * Cho phép cổng **22 (SSH)** và **80 (HTTP)**.

3. Tạo **Launch Template**:

   * AMI: Amazon Linux 2
   * Dùng UserData để cài web server:

     ```bash
     #!/bin/bash
     yum install -y httpd
     systemctl start httpd
     echo "Hello from $(hostname)" > /var/www/html/index.html
     ```

4. Tạo **Auto Scaling Group (ASG)**:

   * Gắn Launch Template
   * Min: 2, Max: 4
   * Subnet: chọn cả 2 AZ

5. Tạo **Application Load Balancer**:

   * Internet-facing
   * Gắn 2 Subnet
   * Target Group: kiểu EC2, health check trên port 80
   * Listener: port 80 → forward đến target group

6. **Test**:

   * Truy cập ALB DNS → refresh nhiều lần để thấy round-robin

---

### 🔬 Lab 2: Thiết lập VPC Peering giữa 2 VPC

#### ✅ Mục tiêu:

Kết nối 2 VPC và test ping giữa 2 EC2 instance.

#### Các bước:

1. Tạo 2 VPC:

   * VPC A: `10.0.0.0/16`
   * VPC B: `10.1.0.0/16`
2. Tạo 1 EC2 ở mỗi VPC.
3. Tạo **VPC Peering Connection** → accept.
4. Cập nhật **Route Table**:

   * VPC A → 10.1.0.0/16 → Peering
   * VPC B → 10.0.0.0/16 → Peering
5. Sửa **Security Group** cho phép ICMP hoặc SSH giữa 2 subnet.
6. SSH vào EC2 → thử **ping IP riêng** của EC2 bên kia.

---

### 🔬 Lab 3: Cấu hình Site-to-Site VPN Lab (giả lập)

#### ✅ Mục tiêu:

Tạo VPN giữa AWS và EC2 giả lập on-prem.

#### Các bước:

1. Khởi tạo EC2 chạy **StrongSwan/OpenVPN** (EC2 đóng vai on-prem).
2. Tạo **Customer Gateway** với IP public của EC2 trên.
3. Tạo **Virtual Private Gateway**, gắn vào VPC chính.
4. Tạo **VPN Connection**.
5. Tải về file cấu hình IPsec từ AWS → thiết lập trên EC2 on-prem.
6. Kiểm tra routing và thử ping giữa EC2 ở AWS và on-prem giả lập.

---

## 📝 Ghi chú

* **ELB + Auto Scaling** giúp hệ thống linh hoạt, chịu tải cao, tự healing.
* **VPC Peering** chỉ phù hợp kết nối đơn giản, không dùng cho mesh topology lớn.
* **VPN** có thể lab được nhưng **Direct Connect** chỉ có thật trong môi trường doanh nghiệp.
* **Transit Gateway** nên dùng khi có từ 3+ VPC kết nối chéo nhau.
* Kiểm soát kỹ **Route Table + Security Group**, rất dễ quên và khiến traffic không đi được.
* Nắm vững networking sẽ giúp bạn tư duy kiến trúc AWS sâu sắc hơn.

---

## 📌 Tips thi SAA-C03

* Câu hỏi networking thường yêu cầu bạn chọn **giải pháp routing đúng + secure**.
* Hãy nhớ: **Peering không hỗ trợ transitive routing**, còn **Transit Gateway thì có**.
* Nếu đề hỏi: “Kết nối nhiều VPC với nhau và mở rộng dễ dàng” → chọn **Transit Gateway**.
* Nếu đề hỏi: “Tăng hiệu suất mạng kết nối on-premises → AWS” → chọn **Direct Connect**.

---

