

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


