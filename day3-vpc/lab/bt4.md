
## **Lab 4: Tối ưu hóa chi phí và hiệu suất với Auto Scaling**

### **Mục tiêu:**

* Tạo một **Auto Scaling Group** để tự động tăng/giảm số lượng EC2 instances trong VPC.
* Cấu hình **CloudWatch Alarms** để theo dõi và kích hoạt Auto Scaling.

### **Hướng dẫn:**

1. **Tạo Launch Configuration:**

   * Vào **Auto Scaling Groups** và nhấn **Create Auto Scaling Group**.
   * Tạo **Launch Configuration** với các thông số:

     * **AMI**: Amazon Linux 2.
     * **Instance Type**: `t2.micro` (Free Tier).
     * **Security Group**: Chọn Security Group đã tạo từ Lab 3.
     * **Key Pair**: Chọn hoặc tạo Key Pair mới.

2. **Cấu hình Auto Scaling Group:**

   * Chọn **VPC** và **Public Subnet**.
   * Thiết lập **Minimum**, **Desired** và **Maximum** instances cho Auto Scaling Group (ví dụ: 1 - 3 instances).

3. **Cấu hình CloudWatch Alarm:**

   * Vào **CloudWatch** và tạo **Alarm** cho việc theo dõi CPU utilization.
   * Kích hoạt
