

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

2. **Tạo Elastic IP (EIP):**

   * Vào **Elastic IPs** và nhấn **Allocate New Address**.
   * Ghi lại **Elastic IP** này.

3. **Tạo NAT Gateway:**

   * Vào **NAT Gateways** và nhấn **Create NAT Gateway**.
   * Chọn **Public Subnet** và gắn **Elastic IP** đã tạo.
   * Nhấn **Create NAT Gateway**.

4. **Cập nhật Route Table cho Private Subnet:**

   * Vào **Route Tables** và chọn Route Table cho **Private Subnet**.
   * Nhấn **Edit routes** và thêm một route:

     * **Destination**: `0.0.0.0/0`.
     * **Target**: Chọn **NAT Gateway**.
   * Nhấn **Save routes**.

5. **Tạo EC2 Instance trong Private Subnet:**

   * Tạo một EC2 instance mới trong **Private Subnet**.
   * Gắn **Security Group** cho phép SSH (Port 22) từ **Public Subnet**.
   * Đảm bảo rằng instance này không có **Public IP**.

6. **Kiểm tra kết nối:**

   * SSH vào **EC2 instance** trong **Public Subnet**.
   * Thực hiện `ping` tới một địa chỉ bên ngoài (ví dụ: `ping google.com`) từ EC2 instance trong **Private Subnet**.

---

## **Lab 3: Cấu hình Security Groups và Network ACLs**

### **Mục tiêu:**

* Cấu hình **Security Groups** và **Network ACLs** để kiểm soát lưu lượng mạng vào và ra EC2 instances.
* Kiểm tra hiệu quả của việc cấu hình **Security Groups** và **Network ACLs**.

### **Hướng dẫn:**

1. **Tạo Security Group cho EC2 Instances:**

   * Vào **Security Groups** và nhấn **Create Security Group**.
   * Chọn VPC bạn đã tạo và nhập tên cho **Security Group** (ví dụ: `MySG`).
   * Thêm các **Inbound Rules**:

     * **SSH (Port 22)** từ IP của bạn hoặc Public Subnet.
     * **HTTP (Port 80)** từ mọi địa chỉ IP (`0.0.0.0/0`).
   * Thêm các **Outbound Rules**:

     * Cho phép tất cả lưu lượng đi ra ngoài (`0.0.0.0/0`).

2. **Áp dụng Security Group cho EC2 Instance:**

   * Gắn Security Group vừa tạo cho các EC2 instances trong **Public Subnet** và **Private Subnet**.

3. **Cấu hình Network ACLs:**

   * Vào **Network ACLs** và nhấn **Create Network ACL**.
   * Chọn VPC và tạo một NACL cho **Public Subnet** và một cho **Private Subnet**.
   * Cấu hình các quy tắc:

     * **Inbound Rules**: Cho phép HTTP (Port 80) và SSH (Port 22) từ IP của bạn hoặc Public Subnet.
     * **Outbound Rules**: Cho phép tất cả lưu lượng đi ra ngoài (`0.0.0.0/0`).
   * Áp dụng NACL cho **Public Subnet** và **Private Subnet**.

4. **Kiểm tra kết nối mạng:**

   * **Test từ EC2 trong Public Subnet**: SSH vào EC2 instance trong **Public Subnet** và kiểm tra kết nối Internet.
   * **Test từ EC2 trong Private Subnet**: SSH vào EC2 instance trong **Private Subnet** và kiểm tra kết nối Internet qua NAT Gateway.

---

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
