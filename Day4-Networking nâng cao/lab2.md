### Lab 2: Thiết lập VPC Peering giữa 2 VPC
## ✅ Mục tiêu:
## Kết nối 2 VPC và test ping giữa 2 EC2 instance.
## Chắc chắn rồi! Dưới đây là hướng dẫn chi tiết từng bước để bạn thực hiện **Lab 2: Thiết lập VPC Peering giữa 2 VPC** và kiểm tra kết nối giữa 2 EC2 instance.

---

### **Bước 1: Tạo 2 VPC**

1. **Đăng nhập vào AWS Console**:

   * Truy cập vào [AWS Management Console](https://aws.amazon.com/console/) và đăng nhập vào tài khoản AWS của bạn.

2. **Tạo VPC A (10.0.0.0/16)**:

   * Vào **VPC** trong phần **Networking & Content Delivery**.
   * Chọn **Create VPC**.
   * Nhập tên cho VPC (ví dụ: `VPC-A`).
   * Chọn **IPv4 CIDR block** là `10.0.0.0/16`.
   * Để **Tenancy** là **Default**.
   * Nhấn **Create** để tạo VPC.

3. **Tạo VPC B (10.1.0.0/16)**:

   * Lặp lại các bước trên nhưng thay CIDR block thành `10.1.0.0/16` và đặt tên là `VPC-B`.
<img width="1348" height="153" alt="image" src="https://github.com/user-attachments/assets/61fabf30-4121-406f-bb15-f5cb3f7de559" />

---

### **Bước 2: Tạo 2 EC2 instances**

1. **Tạo EC2 Instance trong VPC A**:

   * Vào **EC2** trong AWS Console.
   * Chọn **Launch Instance**.
   * Chọn **Amazon Linux 2** (hoặc hệ điều hành bạn muốn) và loại instance là **t2.micro** (miễn phí trong Free Tier).
   * Trong **Network**, chọn **VPC-A** và trong **Subnet**, chọn **Default subnet** của VPC A (hoặc tạo một subnet mới nếu cần).
   * Đảm bảo rằng **Auto-assign Public IP** được bật.
   * Tạo **Key Pair** mới (hoặc sử dụng key pair đã có).
   * Nhấn **Launch** để tạo EC2 instance.

2. **Tạo EC2 Instance trong VPC B**:

   * Tương tự như bước trên, tạo một EC2 instance trong **VPC-B**.
   * Chọn **VPC-B** và **Default subnet** của VPC B (hoặc tạo mới subnet).
<img width="1322" height="255" alt="image" src="https://github.com/user-attachments/assets/ee445128-1a0c-4a1d-adf8-5f0d6cbb5fff" />

---

### **Bước 3: Tạo VPC Peering Connection**

1. **Tạo VPC Peering**:

   * Truy cập vào **VPC** > **Peering Connections**.
   * Nhấn **Create Peering Connection**.
   * Đặt tên cho kết nối (ví dụ: `VPC-A-to-VPC-B`).
   * Chọn **Requester VPC** là `VPC-A` và **Accepter VPC** là `VPC-B`.
   * Nhấn **Create Peering Connection** để tạo kết nối.

2. **Chấp nhận Peering Connection**:

   * Sau khi tạo, chọn **Peering Connection** bạn vừa tạo.
   * Chọn **Actions** > **Accept Request** để chấp nhận kết nối.
<img width="1229" height="568" alt="image" src="https://github.com/user-attachments/assets/8a772568-6f4d-425c-8a3f-d6d1233eca59" />
<img width="730" height="282" alt="image" src="https://github.com/user-attachments/assets/69ab2b0a-32b4-4509-bdc4-bf9b3e0c61bd" />

---

### **Bước 4: Cập nhật Route Tables**

1. **Cập nhật Route Table cho VPC A**:

   * Truy cập vào **VPC** > **Route Tables**.
   * Chọn **Route Table** của `VPC-A`.
   * Chọn **Routes** tab, nhấn **Edit routes**.
   * Thêm route:

     * **Destination**: `10.1.0.0/16`
     * **Target**: Chọn **Peering Connection** (chọn kết nối peering bạn vừa tạo).
   * Nhấn **Save routes**.
<img width="1591" height="265" alt="image" src="https://github.com/user-attachments/assets/c3aa2435-6b1f-4e77-bea1-77d718713fc1" />

2. **Cập nhật Route Table cho VPC B**:

   * Lặp lại các bước trên nhưng lần này chọn **VPC-B** và thêm route:

     * **Destination**: `10.0.0.0/16`
     * **Target**: Chọn **Peering Connection**.
<img width="1539" height="340" alt="image" src="https://github.com/user-attachments/assets/14709e51-3eea-4da4-b851-513ab079d431" />

---

### **Bước 5: Sửa Security Groups**

1. **Cập nhật Security Group của EC2 trong VPC A**:

   * Truy cập vào **EC2** > **Security Groups**.
   * Chọn Security Group của EC2 instance trong **VPC-A**.
   * Chọn **Inbound Rules** > **Edit Inbound Rules**.
   * Thêm rule **ICMP** hoặc **SSH** (tùy theo cách bạn muốn kiểm tra kết nối):

     * **Type**: ICMP (hoặc SSH nếu bạn muốn dùng SSH).
     * **Source**: `10.1.0.0/16` (để cho phép lưu lượng từ VPC B).
   * Nhấn **Save rules**.

2. **Cập nhật Security Group của EC2 trong VPC B**:

   * Lặp lại các bước trên nhưng lần này chọn Security Group của EC2 instance trong **VPC-B** và thêm rule ICMP hoặc SSH, nguồn là `10.0.0.0/16`.

---

### **Bước 6: Kiểm tra kết nối (Ping hoặc SSH)**

1. **SSH vào EC2 trong VPC A**:

   * Từ **EC2 instance** trong **VPC-A**, SSH vào bằng cách sử dụng **Key Pair** bạn đã tạo.
   * Sử dụng lệnh `ping` để kiểm tra kết nối tới EC2 trong **VPC-B**:

     ```bash
     ping <Private IP of EC2 in VPC B>
     ```

2. **SSH vào EC2 trong VPC B**:

   * Tương tự, SSH vào EC2 trong **VPC-B**.
   * Thực hiện lệnh `ping` tới EC2 trong **VPC-A**:

     ```bash
     ping <Private IP of EC2 in VPC A>
     ```

Nếu bạn nhận được phản hồi từ lệnh **ping**, có nghĩa là kết nối VPC Peering hoạt động thành công!
<img width="783" height="338" alt="image" src="https://github.com/user-attachments/assets/7c51d6ba-ba4d-440f-b747-4e1388ef620c" />

---

### **Tổng kết**:

Bạn đã hoàn thành các bước thiết lập **VPC Peering** giữa hai VPC và đã kiểm tra được kết nối giữa các EC2 instance. Nếu mọi thứ hoạt động bình thường, bạn đã thành công trong việc thiết lập kết nối giữa 2 VPC và có thể thực hiện các hoạt động mạng khác giữa chúng.

Nếu gặp vấn đề nào trong quá trình làm lab, hãy kiểm tra lại các bước về **Route Table**, **Security Groups** hoặc **Peering Connection** để đảm bảo rằng các cấu hình đã được thực hiện đúng.
