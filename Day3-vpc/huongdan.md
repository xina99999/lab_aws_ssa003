
---

# 📘 Ngày 3 – VPC cơ bản: Subnets, Route Tables, Internet Gateway, NAT Gateway, Security Groups, Network ACLs

## 🎯 Mục tiêu

* Xây dựng và cấu hình một **Virtual Private Cloud (VPC)** cơ bản với các thành phần: Subnets, Route Tables, Internet Gateway, NAT Gateway, Security Groups, và Network ACLs.
* Thực hành cấu hình **Public và Private Subnets**, **NAT Gateway**, và kiểm tra kết nối giữa EC2 instances trong Private Subnet và Internet.
* Hiểu cách áp dụng **Well-Architected Framework** trong thiết kế kiến trúc mạng.

---

## 📚 Nội dung học

### 1. Giới thiệu về VPC

* **Virtual Private Cloud (VPC)** là một mạng ảo trong AWS, cho phép bạn triển khai các tài nguyên AWS như EC2 instances trong một môi trường mạng được kiểm soát hoàn toàn.
* VPC cung cấp sự tách biệt logic giữa các tài nguyên trong **Cloud** và môi trường mạng của bạn.
* Các thành phần quan trọng trong VPC:

  * **Subnets**: Phân chia VPC thành các phân đoạn mạng.
  * **Route Tables**: Điều phối lưu lượng mạng giữa các subnet và ngoài Internet.
  * **Internet Gateway**: Cung cấp kết nối Internet cho các EC2 instances trong **Public Subnet**.
  * **NAT Gateway**: Cho phép các EC2 instances trong **Private Subnet** kết nối ra Internet mà không bị truy cập trực tiếp từ Internet.
  * **Security Groups** và **Network ACLs**: Kiểm soát quyền truy cập mạng vào và ra các EC2 instances.

### 2. Các thành phần trong VPC

#### **Subnets**

* **Public Subnet**: Có thể kết nối với Internet thông qua **Internet Gateway**.
* **Private Subnet**: Không thể kết nối trực tiếp với Internet, nhưng có thể kết nối ra ngoài qua **NAT Gateway**.

#### **Route Tables**

* **Route Tables** là bộ quy tắc chỉ đường (routing) giúp điều hướng lưu lượng mạng giữa các Subnet trong VPC và Internet.
* Mỗi subnet phải liên kết với một Route Table.

#### **Internet Gateway (IGW)**

* Cung cấp khả năng kết nối Internet cho các EC2 instances trong **Public Subnet**.
* Một IGW phải được gắn với VPC để kết nối các tài nguyên trong VPC với thế giới bên ngoài.

#### **NAT Gateway**

* Cung cấp khả năng kết nối Internet cho **Private Subnet**.
* Tạo ra một **NAT Gateway** trong **Public Subnet** để cho phép EC2 instances trong Private Subnet có thể truy cập Internet (ví dụ: tải về bản cập nhật hoặc kết nối với các dịch vụ bên ngoài).

#### **Security Groups (SG)**

* Là bộ tường lửa ảo để kiểm soát kết nối vào và ra EC2 instances.
* Mỗi SG có thể có nhiều quy tắc inbound và outbound, nhưng mỗi instance chỉ có thể gắn một SG duy nhất.

#### **Network ACLs (NACLs)**

* Là bộ lọc lưu lượng mạng được áp dụng cho **subnet** thay vì **instance**.
* NACLs có thể được cấu hình với các quy tắc inbound và outbound, nhưng khác với Security Groups ở chỗ NACLs có thể áp dụng cho nhiều instances trong cùng một subnet.

### 3. AWS Well-Architected Framework

* **Operational Excellence**: Vận hành, giám sát, cải tiến.
* **Security**: Bảo mật với IAM, Encryption, Logging.
* **Reliability**: Hệ thống ổn định và có thể khôi phục nhanh chóng.
* **Performance Efficiency**: Dùng tài nguyên hiệu quả với Auto Scaling.
* **Cost Optimization**: Tối ưu chi phí, tránh lãng phí.

### 4. Thực hành

#### **Bước 1: Tạo VPC**

1. Vào **VPC Dashboard**.
2. Nhấn **Create VPC**.
3. Nhập thông tin cho VPC:

   * **IPv4 CIDR block**: `10.0.0.0/16`.
   * **VPC Name**: `MyVPC`.
   * Chọn **Default Tenancy**.
4. Nhấn **Create VPC**.

#### **Bước 2: Tạo Public Subnet**

1. Trong **VPC Dashboard**, chọn **Subnets** > **Create Subnet**.
2. Chọn VPC đã tạo và nhập thông tin:

   * **Subnet Name**: `PublicSubnet`.
   * **Availability Zone**: `us-east-1a`.
   * **IPv4 CIDR block**: `10.0.1.0/24`.
3. Nhấn **Create**.

#### **Bước 3: Tạo Private Subnet**

1. Tạo một subnet khác cho **Private Subnet** với CIDR block `10.0.2.0/24`.
2. Chọn **us-east-1b** làm Availability Zone.
3. Nhấn **Create**.

#### **Bước 4: Tạo Internet Gateway**

1. Vào **Internet Gateways** > **Create Internet Gateway**.
2. Nhập tên cho IGW (ví dụ: `MyIGW`).
3. Sau khi tạo IGW, chọn **Actions** > **Attach to VPC** và chọn VPC bạn đã tạo.
4. Nhấn **Attach**.

#### **Bước 5: Thiết lập Route Table cho Public Subnet**

1. Tạo **Route Table** mới cho **Public Subnet**.
2. Trong phần **Routes**, thêm route:

   * **Destination**: `0.0.0.0/0`.
   * **Target**: Chọn **Internet Gateway**.
3. Liên kết Route Table với **Public Subnet**.

#### **Bước 6: Tạo NAT Gateway**

1. Tạo **Elastic IP** trong **Elastic IPs**.
2. Vào **NAT Gateways** và nhấn **Create NAT Gateway**.
3. Chọn **Public Subnet**, gắn Elastic IP, và nhấn **Create**.

#### **Bước 7: Cập nhật Route Table cho Private Subnet**

1. Vào **Route Tables**, chọn Route Table cho **Private Subnet**.
2. Thêm route:

   * **Destination**: `0.0.0.0/0`.
   * **Target**: Chọn **NAT Gateway**.
3. Nhấn **Save routes**.

#### **Bước 8: Cấu hình Security Groups**

1. Vào **Security Groups** > **Create Security Group**.
2. Chọn VPC và nhập tên cho Security Group.
3. Thêm các inbound và outbound rules:

   * Inbound: Cho phép SSH (port 22) từ địa chỉ IP của bạn.
   * Outbound: Cho phép tất cả lưu lượng đi ra ngoài (0.0.0.0/0).

#### **Bước 9: Tạo EC2 Instance**

1. Tạo 2 EC2 instances: một trong **Public Subnet** và một trong **Private Subnet**.
2. Gắn Security Group đã tạo cho EC2 instances.
3. Chọn **t2.micro** (Free Tier), chọn AMI **Amazon Linux 2** hoặc **Ubuntu**.

#### **Bước 10: Kiểm tra kết nối**

1. SSH vào **EC2 instance** trong **Private Subnet** và kiểm tra kết nối Internet bằng lệnh `ping google.com`.
2. SSH vào **EC2 instance** trong **Public Subnet** và kiểm tra từ bên ngoài (sử dụng Public IP).

---

## 📝 Ghi chú

* **VPC** là nền tảng quan trọng cho mọi kiến trúc AWS, nên việc hiểu cách xây dựng và cấu hình một VPC là bước cơ bản rất quan trọng.
* **NAT Gateway** chỉ có thể kết nối Internet cho **Private Subnet**, trong khi **Internet Gateway** phục vụ cho **Public Subnet**.
* **Security Groups** kiểm soát truy cập tới EC2 instances trong khi **Network ACLs** kiểm soát lưu lượng đi qua subnet.
* Hãy đảm bảo rằng bạn chọn đúng **Region** khi triển khai các tài nguyên, để đảm bảo độ trễ thấp và tuân thủ quy định pháp lý.

---

