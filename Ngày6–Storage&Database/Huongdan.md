# 📘 Ngày 6 – Storage & Database: S3, EBS, EFS, Glacier; RDS, DynamoDB, Aurora

## 🎯 Mục tiêu

* Hiểu được các dịch vụ lưu trữ trên AWS: **S3**, **EBS**, **EFS**, **Glacier**.
* Nắm được các dịch vụ cơ sở dữ liệu: **RDS**, **DynamoDB**, **Aurora**.
* Thực hành tạo và cấu hình **S3 Bucket**, **Lifecycle Rules**, **Snapshot**, **RDS instance**, **DynamoDB table**.
* Thử nghiệm với các thao tác **backup** và **restore**.

---

## 📚 Nội dung học

### 1. Các dịch vụ lưu trữ trên AWS

#### **Amazon S3 (Simple Storage Service)**

* **S3** là dịch vụ lưu trữ đối tượng (object storage) dành cho dữ liệu không có cấu trúc (unstructured data) như hình ảnh, video, log files, v.v.
* **Đặc điểm**:

  * **Scalable**: Có thể mở rộng vô hạn.
  * **Durable**: Đảm bảo độ bền cao (99.999999999%).
  * **Secure**: Hỗ trợ mã hóa và kiểm soát truy cập (IAM policies, ACLs).
  * **Lifecycle management**: Cấu hình các **lifecycle policies** để tự động di chuyển hoặc xóa dữ liệu.

#### **Amazon EBS (Elastic Block Store)**

* **EBS** là dịch vụ lưu trữ khối (block storage) dành cho EC2 instances.
* **Đặc điểm**:

  * **Persistent**: Dữ liệu sẽ không mất khi EC2 instance bị dừng hoặc khởi động lại.
  * **Performance options**: Có nhiều loại volume, từ **General Purpose SSD** đến **Provisioned IOPS SSD**.
  * **Snapshot**: Bạn có thể tạo **snapshots** của EBS volumes để sao lưu hoặc tạo bản sao dữ liệu.

#### **Amazon EFS (Elastic File System)**

* **EFS** là dịch vụ lưu trữ file system (giống như NAS), cho phép nhiều EC2 instances truy cập vào dữ liệu chia sẻ.
* **Đặc điểm**:

  * **Scalable**: Tự động mở rộng và thu nhỏ dung lượng.
  * **Shared Access**: Hỗ trợ nhiều EC2 instance đọc/ghi đồng thời.

#### **Amazon Glacier**

* **Glacier** là dịch vụ lưu trữ đối tượng giá rẻ, dùng để lưu trữ dữ liệu lâu dài và ít truy cập.
* **Đặc điểm**:

  * **Low Cost**: Chi phí thấp, phù hợp cho lưu trữ lâu dài.
  * **Retrieval Time**: Khôi phục dữ liệu có thể mất từ vài giờ đến vài ngày tùy thuộc vào mức độ khôi phục.

---

### 2. Các dịch vụ cơ sở dữ liệu trên AWS

#### **Amazon RDS (Relational Database Service)**

* **RDS** là dịch vụ quản lý cơ sở dữ liệu quan hệ, hỗ trợ các hệ quản trị như **MySQL**, **PostgreSQL**, **SQL Server**, **MariaDB**, **Oracle**.
* **Đặc điểm**:

  * **Managed Service**: AWS sẽ tự động quản lý việc sao lưu, vá lỗi, cập nhật, và phát triển hệ thống.
  * **Multi-AZ**: Có thể triển khai với chế độ Multi-AZ để tăng tính sẵn sàng và phục hồi sau thảm họa.
  * **Scaling**: Hỗ trợ mở rộng theo chiều ngang (read replicas) và chiều dọc (tăng kích thước instance).

#### **Amazon DynamoDB**

* **DynamoDB** là dịch vụ cơ sở dữ liệu NoSQL, lý tưởng cho các ứng dụng yêu cầu độ trễ thấp và khả năng mở rộng cao.
* **Đặc điểm**:

  * **Fully Managed**: Không cần quản lý phần cứng hay phần mềm.
  * **Key-Value and Document Store**: Lưu trữ dữ liệu theo kiểu key-value hoặc tài liệu.
  * **Auto Scaling**: Tự động điều chỉnh công suất đọc/ghi.

#### **Amazon Aurora**

* **Aurora** là dịch vụ cơ sở dữ liệu quan hệ, tương thích với **MySQL** và **PostgreSQL**, nhưng hiệu suất cao hơn 5 lần so với MySQL.
* **Đặc điểm**:

  * **High Performance**: Tốc độ truy xuất dữ liệu rất nhanh.
  * **Fully Managed**: AWS tự động quản lý sao lưu, cập nhật, và bảo mật.
  * **Multi-AZ and Global Databases**: Hỗ trợ triển khai đa khu vực và sao lưu tự động.

---

## 🛠️ Thực hành

### 1. Tạo một **S3 Bucket**

1. Truy cập **S3 Console**.
2. Chọn **Create Bucket**.
3. Đặt tên bucket (tên phải duy nhất trên toàn cầu).
4. Chọn Region.
5. Thiết lập quyền truy cập.
6. **Create**.

### 2. Thiết lập **Lifecycle Rules** cho S3

1. Vào **S3 Console** → chọn bucket vừa tạo.
2. Chọn **Management** → **Lifecycle Rules**.
3. Chọn **Create lifecycle rule**.
4. Thiết lập quy tắc chuyển dữ liệu từ **S3 Standard** sang **Glacier** sau một khoảng thời gian.

### 3. Tạo **Snapshot** cho EBS

1. Truy cập **EC2 Console** → **Volumes**.
2. Chọn volume muốn sao lưu.
3. Click **Actions** → **Create Snapshot**.
4. Đặt tên cho snapshot và tạo.

### 4. Cấu hình **RDS Instance**

1. Truy cập **RDS Console**.
2. Chọn **Create Database**.
3. Chọn loại DB engine (MySQL, PostgreSQL, v.v.).
4. Cấu hình instance, vùng địa lý, và bảo mật.
5. Chọn **Create database**.

### 5. Tạo **DynamoDB Table**

1. Truy cập **DynamoDB Console**.
2. Chọn **Create Table**.
3. Đặt tên cho bảng và chỉ định **Partition key** (VD: `UserID`).
4. Thiết lập các tùy chọn mở rộng như **Provisioned** hoặc **On-demand**.
5. Chọn **Create**.

### 6. Thử nghiệm với **Backup** và **Restore** cho RDS và DynamoDB

* **RDS**:

  1. Tạo một **DB Snapshot**.
  2. Kiểm tra sao lưu và phục hồi từ snapshot.
* **DynamoDB**:

  1. Sử dụng tính năng **Backup** trong **DynamoDB Console** để tạo bản sao lưu.
  2. Khôi phục dữ liệu từ bản sao lưu.

---

## 📝 Ghi chú

* **S3** có thể tích hợp với **CloudFront** để tối ưu hiệu suất phục vụ nội dung.
* Khi sử dụng **EBS** và **RDS**, nhớ tận dụng tính năng **snapshot** để sao lưu và phục hồi dễ dàng.
* **DynamoDB** là lựa chọn tuyệt vời cho các ứng dụng yêu cầu độ trễ thấp và khả năng mở rộng mạnh mẽ.
* **Glacier** rất lý tưởng cho dữ liệu lưu trữ lâu dài với chi phí thấp, nhưng cần lưu ý thời gian khôi phục dữ liệu có thể lâu.
* Hãy luôn nhớ kiểm tra cấu hình bảo mật và quyền truy cập cho các dịch vụ này (S3, EBS, RDS).

---
