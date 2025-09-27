## Lab1: Deploy EC2 với Auto Scaling

### **Bước 1: Tạo EC2 Launch Template**

1. **Vào EC2 Dashboard:**

   * Đăng nhập vào AWS Management Console.
   * Tìm và chọn **EC2** trong dịch vụ.

2. **Tạo Launch Template:**

   * Chọn **Launch Templates** ở mục **Instances** bên menu trái.
   * Nhấn **Create Launch Template**.

3. **Cấu hình Launch Template:**

   * **Name**: Đặt tên cho template (ví dụ: `auto-scaling-template`).
   * **Template Version Description**: Mô tả (ví dụ: `v1 - Initial Template`).
   * **AMI**: Chọn **Amazon Linux 2 AMI**.
   * **Instance Type**: Chọn **t2.micro** (hoàn toàn miễn phí trong Free Tier nếu bạn sử dụng đúng cấu hình này).
   * **Key Pair**: Chọn một key pair đã có hoặc tạo mới nếu bạn chưa có.
   * **Security Group**: Chọn **Create new security group**, sau đó mở các cổng sau:

     * Cổng **22 (SSH)** để truy cập vào instance qua SSH.
     * Cổng **80 (HTTP)** để truy cập ứng dụng Apache từ trình duyệt.
   * **User Data**: Dán đoạn mã sau vào ô User Data để tự động cài Apache trên EC2 khi instance khởi động.

     ```bash
     #!/bin/bash
     yum update -y
     yum install -y httpd
     systemctl start httpd
     echo "Auto Scaling EC2 - $(hostname)" > /var/www/html/index.html
     ```

     * Đoạn mã này sẽ tự động cài đặt Apache, khởi động dịch vụ và tạo một trang web đơn giản hiển thị hostname của instance.
<img width="1316" height="609" alt="image" src="https://github.com/user-attachments/assets/15b705d1-d621-489e-8be7-37f333f96ac2" />
<img width="1569" height="106" alt="image" src="https://github.com/user-attachments/assets/b2ce87cc-a04a-4afd-8307-1cd9a2685f71" />


4. **Lưu Launch Template**:

   * Nhấn **Create launch template** để lưu lại.


---

### **Bước 2: Tạo Auto Scaling Group**

1. **Vào Auto Scaling Groups**:

   * Trong EC2 Dashboard, tìm và chọn **Auto Scaling Groups** ở mục **Auto Scaling** trong menu bên trái.



2. **Tạo Auto Scaling Group**:

   * Nhấn **Create Auto Scaling group**.

3. **Cấu hình Auto Scaling Group**:

   * **Group Name**: Đặt tên cho nhóm Auto Scaling (ví dụ: `auto-scaling-group`).
   * **Launch Template**: Chọn Launch Template mà bạn vừa tạo từ menu dropdown.
   * **VPC**: Chọn **Default VPC**.
   * **Subnet**: Chọn ít nhất hai Subnet thuộc hai Availability Zones (AZ) khác nhau trong VPC (ví dụ: `subnet-1`, `subnet-2`).
<img width="1562" height="639" alt="image" src="https://github.com/user-attachments/assets/75435762-4f41-45d3-9748-4f54a0ab46c4" />
<img width="1209" height="369" alt="image" src="https://github.com/user-attachments/assets/57e0d88b-8383-47ef-82b3-ff5c33adacf5" />

4. **Cấu hình Capacity**:

   * **Desired capacity**: Đặt thành **1** (số lượng instance bạn muốn khởi tạo ngay khi Auto Scaling Group bắt đầu).
   * **Minimum size**: Đặt là **1** (giới hạn thấp nhất của số lượng instance).
   * **Maximum size**: Đặt là **2** (giới hạn cao nhất của số lượng instance mà Auto Scaling Group có thể tạo ra).
<img width="1203" height="432" alt="image" src="https://github.com/user-attachments/assets/9646c66d-f97c-4b68-a1a1-733411eb34b0" />

5. **Cấu hình Scaling Policy**:

   * **Scaling Policy**: Chọn **Target Tracking**.
   * **Policy type**: Chọn **Target value**.
   * **Target value**: Chọn **50%** cho **CPU Utilization** (điều này có nghĩa là nếu CPU của instance đạt trên 50%, Auto Scaling sẽ tự động scale-out, tạo thêm instance).
<img width="1224" height="585" alt="image" src="https://github.com/user-attachments/assets/89afab78-7964-44be-8175-741c6880ecd7" />

6. **Tạo Auto Scaling Group**:

   * Sau khi hoàn thành, nhấn **Create Auto Scaling group** để tạo nhóm.
<img width="1562" height="226" alt="image" src="https://github.com/user-attachments/assets/72e71964-f11f-4535-87c1-0ac16f851521" />

---

### **Bước 3: Kiểm tra Auto Scaling**

1. **SSH vào Instance**:

   * SSH vào instance EC2 trong nhóm Auto Scaling để kiểm tra và chạy thử nghiệm. Sử dụng lệnh sau (thay `your-key.pem` và `your-instance-ip` bằng thông tin của bạn):

     ```bash
     ssh -i your-key.pem ec2-user@your-instance-ip
     ```

2. **Cài đặt và chạy ứng dụng stress test**:

   * Cài đặt công cụ **stress** để tạo tải CPU:

     ```bash
     sudo yum install -y stress
     ```

   * Chạy lệnh **stress** để tạo tải CPU:

     ```bash
     stress --cpu 2 --timeout 300
     ```

   * Lệnh này sẽ tạo tải cho 2 CPU trong vòng 5 phút, làm tăng CPU lên trên 50%.

3. **Kiểm tra Auto Scaling**:

   * Sau khoảng 1-2 phút, Auto Scaling Group sẽ tự động phát hiện việc sử dụng CPU cao và tạo thêm một EC2 instance mới để giảm tải.
   * Bạn có thể kiểm tra số lượng instance trong **Auto Scaling Group** hoặc vào phần **Instances** trong EC2 Dashboard để xác nhận.
<img width="1346" height="297" alt="image" src="https://github.com/user-attachments/assets/75931f6d-d36e-4106-be67-b00efe5eff0c" />

---

### **Bước 4: Kiểm tra Instance và Scaling**

* **Instances**: Vào **Instances** trong EC2 Dashboard để kiểm tra số lượng instances.
* Khi CPU sử dụng vượt quá mức 50%, một instance mới sẽ được tạo ra, điều này giúp bạn duy trì khả năng phục vụ khi tải tăng lên.

---




