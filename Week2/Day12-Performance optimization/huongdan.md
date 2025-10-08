

---

# ⚡ Ngày 12 – Performance Optimization: Caching (ElastiCache), CloudFront, DB Replicas

## 🎯 Mục tiêu

* Hiểu vai trò của **caching** trong tối ưu hiệu năng hệ thống.
* Biết cách dùng **Amazon CloudFront** để cache nội dung tĩnh và tăng tốc truy cập toàn cầu.
* Nắm khái niệm **in-memory cache** với **ElastiCache (Redis/Memcached)**.
* Hiểu cách **Read Replica** trong RDS giúp giảm tải đọc và tăng khả năng mở rộng.
* Thực hành thiết lập CloudFront, ElastiCache, và RDS Read Replica.

---

## 📚 Nội dung học

### 1. Tối ưu hiệu năng là gì?

* Mục tiêu: giảm **thời gian phản hồi (latency)** và **tải hệ thống (load)**.
* 3 hướng tối ưu phổ biến:

  1. **Caching** – lưu tạm dữ liệu thường dùng để giảm truy vấn DB.
  2. **CDN (CloudFront)** – cache nội dung tĩnh gần người dùng.
  3. **Database Replication** – tách luồng đọc/ghi để scale DB.

📊 Tổng quan kiến trúc hiệu năng cao:

```
Client → CloudFront → App (EC2/Lambda) → ElastiCache → RDS (Primary + Read Replica)
```

---

### 2. CloudFront – Tăng tốc phân phối nội dung

* **Amazon CloudFront** là **Content Delivery Network (CDN)** của AWS.
* Lưu cache nội dung tĩnh (HTML, JS, CSS, ảnh, video...) tại hơn 400+ edge location toàn cầu.

📘 **Cách hoạt động:**

1. Người dùng truy cập CloudFront URL (ví dụ: `d1234.cloudfront.net`).
2. Nếu file có sẵn tại edge → trả về ngay (cache hit).
3. Nếu chưa có → CloudFront tải từ **Origin (S3/EC2/API Gateway)** và cache lại.

🧩 **Lợi ích:**

* Giảm tải lên server gốc.
* Cải thiện tốc độ tải trang toàn cầu.
* Tích hợp HTTPS, WAF, DDoS Protection.

📸 **Ví dụ cấu hình:**

1. Mở **CloudFront Console** → Create Distribution.
2. Origin: chọn **S3 bucket** hoặc **ALB / EC2 endpoint**.
3. Bật cache policy mặc định (`CachingOptimized`).
4. Deploy và test qua URL phân phối CloudFront.

---

### 3. ElastiCache – Cache dữ liệu động

* **ElastiCache** là dịch vụ **cache in-memory** (RAM) với **Redis** hoặc **Memcached**.
* Thường dùng để giảm truy cập RDS cho các truy vấn lặp lại.

📘 **Mô hình hoạt động:**

```
App → ElastiCache (Redis) → RDS
```

* Khi app cần dữ liệu:

  * Nếu có trong cache → lấy ngay (rất nhanh, <1ms).
  * Nếu không → đọc từ DB rồi lưu vào cache.

💡 **Ví dụ:**

```python
import redis, json
import pymysql

r = redis.Redis(host='mycache.abc123.apse1.cache.amazonaws.com', port=6379)
db = pymysql.connect(host='mydb.c123.apse1.rds.amazonaws.com', user='admin', password='123456', database='demo')

def get_user(user_id):
    key = f"user:{user_id}"
    cached = r.get(key)
    if cached:
        return json.loads(cached)

    cursor = db.cursor()
    cursor.execute("SELECT * FROM users WHERE id=%s", (user_id,))
    row = cursor.fetchone()
    if row:
        r.setex(key, 300, json.dumps(row))  # cache 5 phút
    return row
```

🧠 **Lợi ích:**

* Giảm tải DB 70–90%.
* Tốc độ phản hồi tăng lên gấp 10–100 lần.
* Có thể dùng cho session store, leaderboard, counter, queue tạm, v.v.

---

### 4. Database Read Replica – Giảm tải đọc

* **Amazon RDS** hỗ trợ **Read Replica** để tách luồng **đọc (SELECT)** khỏi **ghi (INSERT/UPDATE)**.

📘 **Mô hình:**

```
App → Read Replica (đọc)
App → Primary DB (ghi)
```

* Dữ liệu đồng bộ **gần real-time** (asynchronous).
* Có thể tạo nhiều replica để scale đọc toàn cầu.

🧩 **Thực hành tạo Replica:**

1. Vào **RDS Console** → chọn DB instance chính.
2. Chọn **Actions → Create read replica**.
3. Đặt tên, chọn region (có thể khác region).
4. Sau khi tạo xong, test kết nối:

```bash
mysql -h mydb-replica.apse1.rds.amazonaws.com -u admin -p
```

---

## 🛠️ Thực hành

### 1. Thiết lập CloudFront với S3

1. Upload website tĩnh lên **S3 bucket** (`index.html`, `style.css`).
2. Cho phép **public read** hoặc dùng **Origin Access Control (OAC)**.
3. Tạo **CloudFront Distribution** trỏ đến bucket.
4. Deploy → Test qua domain CloudFront (`https://dxxxx.cloudfront.net`).

📸 Ảnh minh họa: <img width="1500" alt="image" src="https://github.com/user-attachments/assets/f65cf89a-bd2b-4769-83f5-ef6a9ce26b33" />

---

### 2. Thiết lập ElastiCache Redis

1. Mở **ElastiCache Console** → chọn **Redis** → Create Cluster.
2. Chọn node type nhỏ (`cache.t3.micro`) để tiết kiệm.
3. Kết nối từ EC2/App bằng endpoint Redis.
4. Thử `SET key value` và `GET key`.

📸 Ảnh minh họa: <img width="1420" alt="image" src="https://github.com/user-attachments/assets/849af75e-ef52-4952-8356-5f2e2d5c492b" />

---

### 3. Tạo và test RDS Read Replica

1. Trong **RDS Console**, chọn DB chính → Actions → Create read replica.
2. Chờ vài phút để AWS đồng bộ dữ liệu.
3. Trong app, cập nhật cấu hình:

   ```env
   READ_DB_HOST=mydb-replica.apse1.rds.amazonaws.com
   WRITE_DB_HOST=mydb-primary.apse1.rds.amazonaws.com
   ```
4. Gửi truy vấn SELECT sang replica và INSERT/UPDATE sang primary → test tốc độ.

---

## 🧩 Kiến trúc tổng thể

```
Client
   ↓
CloudFront (cache static)
   ↓
Application (EC2/Lambda)
   ↓
ElastiCache (cache dynamic)
   ↓
RDS Primary (write) ↔ RDS Read Replica (read)
```

---

## 📝 Ghi chú

* **CloudFront TTL** có thể tùy chỉnh (cache-control header).
* **Redis eviction policy** nên chọn `volatile-lru` để xóa key ít dùng.
* **Read Replica lag** có thể vài giây → không dùng cho tác vụ cần dữ liệu real-time chính xác.
* Dùng **Elastic Load Balancer** hoặc **Aurora Cluster endpoint** để tự động cân bằng giữa replica.
* **Monitoring:** dùng CloudWatch metric như `CacheHitRate`, `ReplicationLag`.

---

## 🧠 Tổng kết

| Kỹ thuật       | Dịch vụ                       | Mục tiêu chính      | Lợi ích                           |
| -------------- | ----------------------------- | ------------------- | --------------------------------- |
| CDN Cache      | CloudFront                    | Cache nội dung tĩnh | Tăng tốc truy cập toàn cầu        |
| Memory Cache   | ElastiCache (Redis/Memcached) | Cache dữ liệu động  | Giảm tải DB, tăng tốc xử lý       |
| DB Replication | RDS Read Replica              | Tách luồng đọc      | Tăng khả năng scale & độ sẵn sàng |

---


