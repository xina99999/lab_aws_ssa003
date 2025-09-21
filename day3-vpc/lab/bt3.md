

## **Lab 3: Cấu hình Security Groups và Network ACLs**

### **Mục tiêu:**

* Cấu hình **Security Groups** và **Network ACLs** để kiểm soát lưu lượng mạng vào và ra EC2 instances.
* Kiểm tra hiệu quả của việc cấu hình **Security Groups** và **Network ACLs**.

### **Hướng dẫn:**

1. **Tạo Security Group cho EC2 Instances:**

   * Vào **Security Groups** và nhấn **Create Security Group**.
   * Chọn VPC bạn đã tạo và nhập tên cho **Security Group** (ví dụ: `MySG`).
   * <img width="1585" height="526" alt="image" src="https://github.com/user-attachments/assets/3dc7f180-6c30-4400-a300-6ada77c6c91b" />
   * Thêm các **Inbound Rules**:

     * **SSH (Port 22)** từ IP của bạn hoặc Public Subnet.
     * **HTTP (Port 80)** từ mọi địa chỉ IP (`0.0.0.0/0`).
     * <img width="1599" height="371" alt="image" src="https://github.com/user-attachments/assets/b7e40d74-a804-4350-bd49-3ca15e47b0a4" />
   * Thêm các **Outbound Rules**:

     * Cho phép tất cả lưu lượng đi ra ngoài (`0.0.0.0/0`).
      <img width="1577" height="232" alt="image" src="https://github.com/user-attachments/assets/9b09202c-b218-4777-ad5e-69767a7ccdbe" />


2. **Áp dụng Security Group cho EC2 Instance:**

   * Gắn Security Group vừa tạo cho các EC2 instances trong **Public Subnet** và **Private Subnet**.
   * <img width="1210" height="593" alt="image" src="https://github.com/user-attachments/assets/e30309da-8fb2-41e7-ac01-513804b9d59a" />


3. **Cấu hình Network ACLs:**

   * Vào **Network ACLs** và nhấn **Create Network ACL**.
   * Chọn VPC và tạo một NACL cho **Public Subnet** và một cho **Private Subnet**.
   * Cấu hình các quy tắc:

     * **Inbound Rules**: Cho phép HTTP (Port 80) và SSH (Port 22) từ IP của bạn hoặc Public Subnet.
     * <img width="1338" height="286" alt="image" src="https://github.com/user-attachments/assets/730452d0-5993-4e08-b595-5adc0f507d12" />
     *  <img width="1341" height="528" alt="image" src="https://github.com/user-attachments/assets/9f93e870-ee3b-4857-8705-c0539ef5ba69" />
     * **Outbound Rules**: Cho phép tất cả lưu lượng đi ra ngoài (`0.0.0.0/0`).
   * Áp dụng NACL cho **Public Subnet** và **Private Subnet**.
<img width="1316" height="67" alt="image" src="https://github.com/user-attachments/assets/7211de20-069d-48ec-9a94-e093ccc44157" />
<img width="1355" height="399" alt="image" src="https://github.com/user-attachments/assets/775f18c4-403d-4264-9fc2-51f9f3b4ace8" />
<img width="1598" height="689" alt="image" src="https://github.com/user-attachments/assets/0267bb3f-1ed4-4cc4-9741-b3f138b93abe" />
<img width="1594" height="688" alt="image" src="https://github.com/user-attachments/assets/47497801-a5ce-4c99-a0d2-cea70c65d040" />


4. **Kiểm tra kết nối mạng:**

   * **Test từ EC2 trong Public Subnet**: SSH vào EC2 instance trong **Public Subnet** và kiểm tra kết nối Internet.
   * **Test từ EC2 trong Private Subnet**: SSH vào EC2 instance trong **Private Subnet** và kiểm tra kết nối Internet qua NAT Gateway.

---


