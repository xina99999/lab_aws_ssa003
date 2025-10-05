# LAB 1: TRIỂN KHAI MULTI-AZ DEPLOTMENT

### 1. **Tạo RDS mới với Multi-AZ Deployment**

Trước tiên, bạn cần tạo một instance Amazon RDS với chế độ Multi-AZ:

#### Bước 1: Đăng nhập vào AWS Console

Truy cập vào [AWS Management Console](https://aws.amazon.com/console/) và đăng nhập vào tài khoản AWS của bạn.

#### Bước 2: Tạo mới RDS Instance

1. Vào **Services** -> **RDS**.

2. Nhấn vào **Create database**.

3. Chọn **Standard Create**.

4. Chọn **Engine**: Lựa chọn engine bạn muốn sử dụng (ví dụ: MySQL, PostgreSQL, MariaDB, Oracle, SQL Server).

5. Chọn phiên bản (ví dụ: **Free tier** nếu bạn muốn làm thử nghiệm, hoặc chọn một loại instance khác nếu bạn muốn dùng tài nguyên cao hơn).

6. **Deployment type**: Chọn **Multi-AZ deployment**: Yes.

   Khi bạn chọn **Multi-AZ**:

   * Amazon sẽ tự động tạo một bản sao (replica) của instance cơ sở dữ liệu của bạn trong một Availability Zone khác.
   * Điều này giúp đảm bảo khả năng sẵn sàng cao, nếu instance chính bị lỗi, RDS sẽ tự động failover sang replica.

7. **Settings**:

   * **DB instance identifier**: Đặt tên cho instance của bạn.
   * **Master username** và **Master password**: Nhập tên người dùng và mật khẩu quản trị.

8. **DB instance size**: Chọn kích thước instance (ví dụ: db.t3.micro cho test).

9. **Storage**: Bạn có thể chọn **General Purpose (SSD)**.
<img width="978" height="315" alt="image" src="https://github.com/user-attachments/assets/acf79fc3-2793-4be7-b687-a7a3d96180ca" />

10. **Connectivity**:

    * Chọn **VPC** mà bạn muốn sử dụng.
    * Đảm bảo rằng **Public accessibility** được chọn là **Yes** (nếu bạn muốn kết nối từ bên ngoài AWS).
    * Bạn có thể để **VPC security group** mặc định hoặc tạo mới.

#### Bước 3: Tạo Database

Nhấn **Create database** để bắt đầu quá trình tạo RDS instance.

### 2. **Kiểm tra Endpoint (chỉ có 1 endpoint, failover tự động)**

Sau khi instance RDS được tạo, bạn sẽ có một **endpoint** duy nhất (được gọi là **Primary endpoint**) cho instance của bạn. Điều này là do Multi-AZ sẽ cung cấp một endpoint duy nhất, AWS sẽ tự động xử lý việc chuyển hướng truy cập từ instance chính sang bản sao khi có sự cố.

1. Vào **RDS Dashboard**.
2. Chọn **Databases** từ menu bên trái.
3. Chọn instance RDS mà bạn vừa tạo.
4. Bạn sẽ thấy **Endpoint** ở mục **Connectivity & security**. Đây là endpoint mà bạn sẽ sử dụng để kết nối đến database.
<img width="995" height="679" alt="image" src="https://github.com/user-attachments/assets/a8278f71-6ac8-45cc-a18c-6cbc05e55376" />

### 3. **Simulate Failure (Dừng AZ chính)**

Để kiểm tra quá trình failover, bạn có thể thực hiện một thao tác giả lập sự cố (simulate) như tắt một Availability Zone (AZ).

#### Bước 1: Tạo Maintenance Event

Để mô phỏng sự cố, bạn có thể kích hoạt một sự kiện bảo trì (maintenance) cho instance RDS.

1. Chọn **Databases** từ menu.
2. Chọn instance RDS của bạn.
3. Nhấn **Modify** ở trên cùng.
4. Trong phần **Maintenance**, bạn có thể bật chế độ bảo trì để AWS thực hiện các thay đổi hoặc tái khởi động instance.
5. Nhấn **Continue** và **Apply immediately**.

Lúc này, nếu bạn dừng hoặc kích hoạt bảo trì, AWS sẽ tự động tiến hành failover sang instance phụ trong AZ khác.

#### Bước 2: Quan sát Failover

Sau khi khởi động sự kiện bảo trì hoặc simulating failure:

1. Kiểm tra trạng thái của instance trong AWS RDS Dashboard. Bạn sẽ thấy rằng instance của bạn sẽ không có sẵn trong một thời gian ngắn khi nó đang failover.
2. Sau khi failover hoàn tất, bạn sẽ thấy endpoint của instance vẫn giữ nguyên. Tuy nhiên, khi kết nối lại, bạn sẽ kết nối đến instance phụ (được xác định thông qua **Failover**).

### 4. **Kiểm tra sự thay đổi của Endpoint**

Sau khi failover, endpoint của bạn sẽ không thay đổi, nhưng bạn có thể kiểm tra việc failover bằng cách kết nối lại và kiểm tra trạng thái của master database.

Ví dụ với MySQL, bạn có thể thực hiện lệnh SQL để kiểm tra **server_id** hoặc **current master**:

```sql
SHOW VARIABLES LIKE 'server_id';
```

### 5. **Kết luận**

Với bước này, bạn đã tạo thành công một Amazon RDS instance với chế độ Multi-AZ và thử nghiệm failover. Các sự cố (failure) sẽ được AWS tự động xử lý mà không cần người dùng can thiệp, đảm bảo rằng ứng dụng của bạn có thể duy trì tính khả dụng cao.

