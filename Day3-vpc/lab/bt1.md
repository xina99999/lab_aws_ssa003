
---

## **Lab 1: Tạo và Cấu hình một VPC Cơ Bản**

### **Mục tiêu:**

* Tạo một **VPC cơ bản** với một **Public Subnet**.
* Cấu hình **Internet Gateway** và **Route Table** cho Public Subnet.
* Tạo một **EC2 instance** trong Public Subnet và kết nối qua SSH.

### **Hướng dẫn:**

1. **Tạo VPC:**

   * Vào **VPC Dashboard** trong AWS Console.
   * <img width="1590" height="705" alt="image" src="https://github.com/user-attachments/assets/d3be8ffa-ae4c-4cf8-8ed4-5cbf1bfa2141" />
   * Nhấn **Create VPC** và chọn các thông số sau:

     * **IPv4 CIDR block**: `10.0.0.0/16`.
     * **VPC Name**: `MyVPC`.
     * **Tenancy**: Chọn **Default**.
   * Nhấn **Create**.
   * <img width="1367" height="600" alt="image" src="https://github.com/user-attachments/assets/bb40452c-81d2-4514-8070-266c13531001" />


2. **Tạo Public Subnet:**

   * Vào **Subnets** và nhấn **Create Subnet**.
   * Chọn VPC bạn đã tạo và nhập thông tin:

     * **Subnet Name**: `PublicSubnet`.
     * **Availability Zone**: Chọn một AZ (ví dụ: `us-east-1a`).
     * **IPv4 CIDR block**: `10.0.1.0/24`.
   * Nhấn **Create**.
<img width="1457" height="559" alt="image" src="https://github.com/user-attachments/assets/9a885b61-3725-4863-bc59-5cb4a18cecd0" />

3. **Tạo Internet Gateway (IGW):**

   * Vào **Internet Gateways** và nhấn **Create Internet Gateway**.
   * Nhập tên cho IGW (ví dụ: `MyIGW`).
   * <img width="1496" height="500" alt="image" src="https://github.com/user-attachments/assets/49b83129-585d-4e41-9c4b-3f66bccf2a3d" />
   * Nhấn **Create**.
   * Sau khi tạo, chọn **Actions** > **Attach to VPC** và chọn VPC bạn đã tạo.
   * <img width="1330" height="205" alt="image" src="https://github.com/user-attachments/assets/045950fb-2388-48e5-b87f-7451ad474460" />
   *  <img width="1581" height="353" alt="image" src="https://github.com/user-attachments/assets/b29e2d4d-6ac4-4fb5-840b-84003ed29934" />


4. **Cấu hình Route Table cho Public Subnet:**

   * Vào **Route Tables** và nhấn **Create Route Table**.
   * Chọn VPC bạn đã tạo và nhập tên cho Route Table (ví dụ: `PublicRouteTable`).
   * <img width="1460" height="486" alt="image" src="https://github.com/user-attachments/assets/f8eb4af9-fbe8-4f97-8071-e298293d23c3" />
   * Sau khi tạo, chọn Route Table và nhấn **Edit routes**.
   * <img width="1333" height="210" alt="image" src="https://github.com/user-attachments/assets/7faa06d2-7901-4e8d-b6fb-7b28be42e002" />
   * Thêm route:

     * **Destination**: `0.0.0.0/0`.
     * **Target**: Chọn **Internet Gateway** (`MyIGW`).
     * <img width="1599" height="418" alt="image" src="https://github.com/user-attachments/assets/27272ec9-6ad0-4bf1-842e-b13f033df670" />
   * Nhấn **Save routes**.
   * Liên kết Route Table với **Public Subnet** trong tab **Subnet Associations**.
   * <img width="1599" height="498" alt="image" src="https://github.com/user-attachments/assets/0d98a70d-0669-4cb1-acc1-83ad8b0bb37d" />
   *  <img width="1333" height="569" alt="image" src="https://github.com/user-attachments/assets/b7724774-3c6b-445b-b1a5-0c693063a3ef" />


5. **Tạo EC2 Instance:**

   * Vào **EC2 Dashboard** và nhấn **Launch Instance**.
   * Chọn AMI là **Amazon Linux 2** hoặc **Ubuntu**.
   * Chọn **Instance Type** là `t2.micro` (Free Tier).
   * <img width="1393" height="669" alt="image" src="https://github.com/user-attachments/assets/a2c84dcb-f41a-411f-b758-22c33239197b" />
   * Tạo **Key Pair** mới để SSH vào instance.
   * <img width="918" height="669" alt="image" src="https://github.com/user-attachments/assets/1b99b1bd-d81e-42f2-af83-a3709431e60f" />
   * Chọn **MyVPC** và **Public Subnet** cho Network.
   * <img width="1242" height="569" alt="image" src="https://github.com/user-attachments/assets/9fb8b7ea-c933-4733-942f-08a61055f979" />
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
