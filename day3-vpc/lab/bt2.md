
## **Lab 2: Thêm Private Subnet và Cấu hình NAT Gateway**

### **Mục tiêu:**

* Tạo **Private Subnet** trong VPC.
* Cấu hình **NAT Gateway** để EC2 instances trong Private Subnet có thể truy cập Internet.
* Thực hành kiểm tra kết nối từ **Private Subnet**.

### **Hướng dẫn:**

1. **Tạo Private Subnet:**

   * Vào **Subnets** và nhấn **Create Subnet**.
   * Chọn VPC bạn đã tạo và nhập thông tin:

     * **Subnet Name**: `PrivateSubnet`.
     * **Availability Zone**: Chọn một AZ khác với Public Subnet (ví dụ: `us-east-1b`).
     * **IPv4 CIDR block**: `10.0.2.0/24`.
   * Nhấn **Create**.
<img width="1520" height="544" alt="image" src="https://github.com/user-attachments/assets/da7eaf8b-ed5e-4c56-b9e0-26a963780fe6" />

2. **Tạo Elastic IP (EIP):**

   * Vào **Elastic IPs** và nhấn **Allocate New Address**.
   * <img width="1595" height="657" alt="image" src="https://github.com/user-attachments/assets/e4245d52-cd37-49fb-bad2-20d5c446834b" />
   * Ghi lại **Elastic IP** này.

3. **Tạo NAT Gateway:**

   * Vào **NAT Gateways** và nhấn **Create NAT Gateway**.
   * Đặt tên là **Publicgateway**
   * Chọn **Public Subnet** và gắn **Elastic IP** đã tạo.
   * Nhấn **Create NAT Gateway**.
   * <img width="1510" height="539" alt="image" src="https://github.com/user-attachments/assets/012dcdb2-1394-4935-b004-ef4f9d85b910" />


4. **Cập nhật Route Table cho Private Subnet:**

   * Vào **Route Tables** và chọn Route Table cho **Private Subnet**.
   * Nhấn **Edit routes** và thêm một route:

     * **Destination**: `0.0.0.0/0`.
     * **Target**: Chọn **NAT Gateway**.
     * <img width="1599" height="392" alt="image" src="https://github.com/user-attachments/assets/41159141-3c6b-40ae-acee-f195760770f7" />
   * Nhấn **Save routes**.

5. **Tạo EC2 Instance trong Private Subnet(Làm tương tự với lab1):**

   * Tạo một EC2 instance mới trong **Private Subnet**.
   * Gắn **Security Group** cho phép SSH (Port 22) từ **Public Subnet**.
   * Đảm bảo rằng instance này không có **Public IP**.

6. **Kiểm tra kết nối:**

   * SSH vào **EC2 instance** trong **Public Subnet**.
   * Thực hiện `ping` tới một địa chỉ bên ngoài (ví dụ: `ping google.com`) từ EC2 instance trong **Private Subnet**.

---


