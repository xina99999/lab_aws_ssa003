
---

## **Lab 1: Tạo và Cấu hình một VPC Cơ Bản**

### **Mục tiêu:**

* Tạo một **VPC cơ bản** với một **Public Subnet**.
* Cấu hình **Internet Gateway** và **Route Table** cho Public Subnet.
* Tạo một **EC2 instance** trong Public Subnet và kết nối qua SSH.

### **Hướng dẫn:**

1. **Tạo VPC:**

   * Vào **VPC Dashboard** trong AWS Console.
   * Nhấn **Create VPC** và chọn các thông số sau:

     * **IPv4 CIDR block**: `10.0.0.0/16`.
     * **VPC Name**: `MyVPC`.
     * **Tenancy**: Chọn **Default**.
   * Nhấn **Create**.

2. **Tạo Public Subnet:**

   * Vào **Subnets** và nhấn **Create Subnet**.
   * Chọn VPC bạn đã tạo và nhập thông tin:

     * **Subnet Name**: `PublicSubnet`.
     * **Availability Zone**: Chọn một AZ (ví dụ: `us-east-1a`).
     * **IPv4 CIDR block**: `10.0.1.0/24`.
   * Nhấn **Create**.

3. **Tạo Internet Gateway (IGW):**

   * Vào **Internet Gateways** và nhấn **Create Internet Gateway**.
   * Nhập tên cho IGW (ví dụ: `MyIGW`).
   * Nhấn **Create**.
   * Sau khi tạo, chọn **Actions** > **Attach to VPC** và chọn VPC bạn đã tạo.

4. **Cấu hình Route Table cho Public Subnet:**

   * Vào **Route Tables** và nhấn **Create Route Table**.
   * Chọn VPC bạn đã tạo và nhập tên cho Route Table (ví dụ: `PublicRouteTable`).
   * Sau khi tạo, chọn Route Table và nhấn **Edit routes**.
   * Thêm route:

     * **Destination**: `0.0.0.0/0`.
     * **Target**: Chọn **Internet Gateway** (`MyIGW`).
   * Nhấn **Save routes**.
   * Liên kết Route Table với **Public Subnet** trong tab **Subnet Associations**.

5. **Tạo EC2 Instance:**

   * Vào **EC2 Dashboard** và nhấn **Launch Instance**.
   * Chọn AMI là **Amazon Linux 2** hoặc **Ubuntu**.
   * Chọn **Instance Type** là `t2.micro` (Free Tier).
   * Tạo **Key Pair** mới để SSH vào instance.
   * Chọn **Default VPC** và **Public Subnet** cho Network.
   * Gắn **Security Group** cho phép SSH (Port 22).
   * Nhấn **Launch**.

6. **Kết nối với EC2 qua SSH:**

   * Sau khi EC2 instance đã được tạo, sao chép **Public IP** của instance.
   * SSH vào EC2 instance từ terminal (Linux/Mac):

     ```bash
     ssh -i your-key.pem ec2-user@<Public_IP>
     ```

     * Với Windows, bạn có thể dùng PuTTY hoặc PowerShell.

---
