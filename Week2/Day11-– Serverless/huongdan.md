
---

# ⚡ Ngày 11 – Serverless: Lambda, API Gateway, Event-driven, SQS/SNS

## 🎯 Mục tiêu

* Hiểu kiến trúc **Serverless** và cách hoạt động của **AWS Lambda**.
* Biết cách kết hợp **API Gateway + Lambda** để xây REST API không cần server.
* Nắm khái niệm **Event-driven architecture** (kiến trúc hướng sự kiện).
* Thực hành **tích hợp SNS & SQS** để xử lý sự kiện bất đồng bộ.
* Học cách **decouple** (tách rời) các thành phần trong hệ thống để tăng khả năng mở rộng và chống lỗi.

---

## 📚 Nội dung học

### 1. Khái niệm Serverless

* **Serverless** = không quản lý server → chỉ tập trung vào **logic** của ứng dụng.
* AWS tự động lo **scale**, **availability**, **patching**.
* Bạn chỉ trả tiền khi hàm được thực thi.

📘 Dịch vụ phổ biến trong hệ sinh thái Serverless:

| Dịch vụ                     | Vai trò                             |
| --------------------------- | ----------------------------------- |
| **Lambda**                  | Thực thi logic (code)               |
| **API Gateway**             | Cổng giao tiếp HTTP/REST cho Lambda |
| **S3**                      | Lưu trữ file, kích hoạt sự kiện     |
| **DynamoDB**                | Cơ sở dữ liệu không cần quản lý     |
| **SNS / SQS / EventBridge** | Gửi, xử lý sự kiện bất đồng bộ      |

---

### 2. AWS Lambda – Compute không server

* **Lambda Function** là đoạn code nhỏ chạy khi có **trigger** (sự kiện) từ API, S3, DynamoDB, SNS, v.v.
* Hỗ trợ nhiều ngôn ngữ: Node.js, Python, Java, Go...
* Môi trường tự động scale theo số lượng request.

📌 **Cách Lambda hoạt động:**

1. Sự kiện kích hoạt Lambda (ví dụ: request HTTP từ API Gateway).
2. Lambda chạy code, trả kết quả (response) hoặc gửi sang hệ thống khác (SNS/SQS).
3. Không cần khởi tạo EC2 hay container.

---

### 3. API Gateway – Kết nối Lambda với người dùng

* **Amazon API Gateway** là lớp giao tiếp giúp expose Lambda qua HTTP/HTTPS.
* Có thể:

  * Nhận request REST / HTTP.
  * Xác thực (API key, IAM, Cognito).
  * Chuyển request đến Lambda và trả response.

📘 **Luồng cơ bản:**

```
Client → API Gateway → Lambda → (Database / SNS / SQS)
```

* Tích hợp phổ biến:

  * Lambda Proxy Integration (đơn giản, tự động mapping request/response)
  * Custom Integration (tùy chỉnh cấu trúc JSON)

---

### 4. Event-driven Architecture (EDA)

* **EDA** = Kiến trúc hướng sự kiện → các thành phần giao tiếp qua **event** thay vì gọi trực tiếp.
* Giúp hệ thống **decouple** và **scale độc lập**.

📊 Ví dụ:

```
API Gateway → Lambda → SNS Topic → SQS Queue → Lambda Worker
```

* Lambda đầu tiên xử lý request người dùng và **phát sự kiện** (SNS).
* SNS gửi event đến nhiều subscriber (SQS, Lambda khác, email...).
* SQS lưu hàng đợi (queue) để Lambda worker xử lý dần (asynchronous).

---

### 5. SNS & SQS – Hạ tầng Event-driven

#### 📨 SNS (Simple Notification Service)

* Là **Pub/Sub service** – publish 1 event, gửi đến nhiều subscriber.
* Subscriber có thể là:

  * Lambda function
  * SQS Queue
  * Email / SMS / HTTP endpoint

📘 Ví dụ:

```
Lambda A → SNS Topic → Lambda B + Email Subscriber
```

#### 📬 SQS (Simple Queue Service)

* Là **message queue** – dùng để **decouple** hệ thống producer và consumer.
* Hàng đợi đảm bảo không mất dữ liệu khi consumer lỗi.
* Có 2 loại:

  * **Standard Queue** – throughput cao, có thể trùng lặp.
  * **FIFO Queue** – đảm bảo thứ tự và không trùng lặp.

📘 Ví dụ:

```
Lambda → SQS → Lambda Worker
```

---

## 🛠️ Thực hành

### 1. Xây dựng REST API Serverless (API Gateway + Lambda)

1. Mở **AWS Lambda Console** → Create Function → Author from scratch.
2. Code ví dụ (Python):

   ```python
   import json

   def lambda_handler(event, context):
       name = event.get("queryStringParameters", {}).get("name", "World")
       return {
           "statusCode": 200,
           "body": json.dumps({"message": f"Hello {name}!"})
       }
   ```
3. Deploy → Test function.
4. Mở **API Gateway Console** → Create API → REST API → Integration với Lambda vừa tạo.
5. Deploy API → truy cập URL endpoint → test `?name=Nhan`.

---

### 2. Tích hợp SNS và SQS

**Bước 1:**
Tạo **SNS Topic** → đặt tên `event-notification`.

**Bước 2:**
Tạo **SQS Queue** → đặt tên `event-queue`.

**Bước 3:**
Trong SNS → Add subscription → chọn protocol = SQS → chọn queue vừa tạo.

**Bước 4:**
Tạo Lambda → publish event:

```python
import boto3, json

sns = boto3.client('sns')
TOPIC_ARN = 'arn:aws:sns:ap-southeast-1:123456789012:event-notification'

def lambda_handler(event, context):
    message = {"order_id": "A123", "status": "created"}
    sns.publish(TopicArn=TOPIC_ARN, Message=json.dumps(message))
    return {"status": "Message sent"}
```

**Bước 5:**
Tạo Lambda Worker → nhận event từ SQS Queue để xử lý:

```python
def lambda_handler(event, context):
    for record in event["Records"]:
        print("Received message:", record["body"])
```

**Bước 6:**
Test → gọi Lambda đầu tiên → kiểm tra CloudWatch Logs của Lambda Worker để thấy message được xử lý qua SNS → SQS.

---

## 🧩 Kiến trúc tổng thể

```
Client
   ↓
API Gateway
   ↓
Lambda (Business Logic)
   ↓
SNS Topic → (Fan-out)
        ↳ SQS Queue → Lambda Worker
        ↳ Email Notification
```

---

## 📝 Ghi chú

* **Lambda timeout** mặc định 3 giây → có thể tăng tối đa 15 phút.
* **API Gateway** giới hạn payload 10MB → với file lớn nên dùng S3 presigned URL.
* **SNS + SQS** giúp **decouple** hệ thống → giảm rủi ro domino khi 1 thành phần lỗi.
* **Event-driven design** giúp **scale độc lập** từng phần.
* **Chi phí thấp** vì Lambda và API Gateway chỉ tính khi có request.
* Dùng **DLQ (Dead Letter Queue)** để lưu lại message lỗi khi Lambda không xử lý được.

---

