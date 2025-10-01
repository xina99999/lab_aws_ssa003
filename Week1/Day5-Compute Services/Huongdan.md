
---

# 📘 Ngày 5 – Compute Services: EC2, Lambda, Auto Scaling, Container Basics (ECS, Fargate)

## 🎯 Mục tiêu

* Hiểu các dịch vụ Compute chính trong AWS: **EC2, Lambda, Auto Scaling, ECS, Fargate**.
* Tự triển khai một **EC2 instance có Auto Scaling** dựa trên CPU.
* Viết thử một **Lambda function đơn giản**.
* Làm quen với khái niệm container và **chạy thử ECS/Fargate** nếu còn thời gian.

---

## 📚 Nội dung học

### 1. Amazon EC2 (Elastic Compute Cloud)

* Dịch vụ **máy chủ ảo (virtual server)** chạy trên AWS.
* Có thể cấu hình linh hoạt: OS, vCPU, RAM, EBS storage, Security Group, v.v.
* EC2 dùng cho các workload cần **toàn quyền kiểm soát** và **luôn chạy 24/7**.
* Có nhiều loại instance: General Purpose, Compute Optimized, Memory Optimized, v.v.

### 2. Auto Scaling Group (ASG)

* Cho phép **tự động thêm hoặc giảm số lượng EC2 instance** theo tiêu chí (CPU, thời gian, v.v.).
* **Tăng độ sẵn sàng** và **tối ưu chi phí**.
* Bao gồm các thành phần:

  * **Launch Template** hoặc Launch Configuration.
  * **ASG Group**: chỉ định số lượng min/max/desired instance.
  * **Scaling Policy**: định nghĩa khi nào scale in/out.

### 3. AWS Lambda

* **Serverless compute**: chạy mã không cần quản lý server.

* Tính phí theo **số lần gọi** và **thời gian chạy**.

* Dùng tốt cho:

  * Xử lý sự kiện (S3, DynamoDB, API Gateway).
  * Cron job.
  * Các tác vụ nhỏ, ngắn gọn, không cần chạy thường xuyên.

* Viết code bằng Node.js, Python, Java, Go, v.v.

### 4. Amazon ECS (Elastic Container Service)

* Dịch vụ chạy container có kiểm soát cao.
* 2 launch types:

  * **EC2**: bạn quản lý EC2 host.
  * **Fargate**: serverless, AWS quản lý hạ tầng → bạn chỉ cần khai báo container image.

### 5. AWS Fargate

* Là **serverless container runtime** cho ECS/EKS.
* Không cần tạo EC2 → bạn chỉ cần container image, CPU, RAM, và networking.
* Tốt cho microservices, event-driven apps.

---

## 🛠️ Thực hành

### ✅ Phần 1 – Deploy EC2 với Auto Scaling

1. **Tạo EC2 Launch Template**:

   * Vào **EC2 Dashboard** → **Launch Templates** → Create.
   * OS: Amazon Linux 2.
   * Instance type: `t2.micro`.
   * Key Pair: chọn hoặc tạo mới.
   * Security Group: mở cổng **22 (SSH)** và **80 (HTTP)**.
   * User Data (tự cài Apache):

     ```bash
     #!/bin/bash
     yum update -y
     yum install -y httpd
     systemctl start httpd
     echo "Auto Scaling EC2 - $(hostname)" > /var/www/html/index.html
     ```

2. **Tạo Auto Scaling Group**:

   * EC2 → **Auto Scaling Groups** → Create.
   * Chọn launch template đã tạo.
   * VPC: chọn Default VPC.
   * Subnet: chọn 2 AZ khác nhau.
   * Load Balancer: tạo mới hoặc bỏ qua.
   * Desired capacity: 1.
   * Min: 1, Max: 2.
   * Scaling Policy: chọn Target Tracking.

     * Ví dụ: CPU > 50% thì scale out.

3. **Test Auto Scaling**:

   * SSH vào instance → chạy stress:

     ```bash
     sudo yum install -y stress
     stress --cpu 2 --timeout 300
     ```

   * Sau 1–2 phút, nếu CPU > 50%, sẽ tự tạo thêm EC2.

   * Xem thêm ở mục **Instances**.

---

### ✅ Phần 2 – Viết hàm Lambda đầu tiên

1. **Vào Lambda Console** → **Create Function**:

   * Chọn "Author from scratch".
   * Function name: `helloLambda`.
   * Runtime: Python 3.12 (hoặc Node.js).
   * Role: tạo mới với basic Lambda permissions.

2. **Viết mã đơn giản** (Python):

   ```python
   def lambda_handler(event, context):
       return {
           'statusCode': 200,
           'body': 'Hello from Lambda!'
       }
   ```

3. **Test function** → chọn "Test" → tạo event mặc định và Run.

---

### ✅ Phần 3 – Thử nghiệm ECS + Fargate (Optional nếu còn thời gian)

1. **Chuẩn bị image container** (nếu chưa có, dùng public image như `nginx`).

2. ECS Console → **Clusters** → Create Cluster:

   * Chọn "Networking only (Fargate)".

3. **Tạo Task Definition**:

   * Launch type: Fargate.
   * Container: `nginx` hoặc image bất kỳ từ Docker Hub.
   * CPU: 0.25 vCPU, Memory: 0.5 GB.

4. **Chạy Task**:

   * Vào Cluster → Run new task.
   * Chọn subnet và gán Security Group mở cổng 80.

5. **Lấy IP của ENI (Elastic Network Interface)** để truy cập web.

---

## 📝 Ghi chú

* EC2 cho phép **quản lý chi tiết máy chủ**, nhưng yêu cầu **tự quản lý nhiều**.
* Auto Scaling giúp **giảm chi phí và tăng độ sẵn sàng**.
* Lambda giúp **xử lý công việc đơn giản nhanh gọn**, nhưng **không phù hợp với các workload lâu dài hoặc yêu cầu về CPU cao**.
* ECS & Fargate giúp bạn chạy **container không cần lo hạ tầng**, phù hợp cho microservices.
* Dễ bị tính phí nếu **quên tắt Auto Scaling hoặc Lambda test nhiều lần** → kiểm tra Billing.

---


