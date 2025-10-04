

---

# 🧪 Lab: Sử dụng AWS Secrets Manager & Parameter Store để quản lý DB password

## 🎯 Mục tiêu

* Tạo RDS Database (MySQL/Postgres).
* Lưu DB password trong **Secrets Manager** và **Parameter Store**.
* Viết Lambda function để **lấy secret** từ 2 dịch vụ này.
* Thử **rotation tự động** với Secrets Manager.

---

## 🪜 Các bước thực hiện

### **Bước 1: Tạo RDS Database**

1. Vào **RDS Console** → chọn **Create database**.
2. Engine: **MySQL** (hoặc PostgreSQL).
3. Credential:

   * Username: `admin`
   * Password: chọn tạm thời, ví dụ `MyTempPass123!`
4. Deploy in **us-east-1** (cho dễ test).
5. Đợi database tạo xong.


<img width="1354" height="664" alt="image" src="https://github.com/user-attachments/assets/6946010c-3bfd-42fe-8d2d-c7ced75cdc7d" />


---

### **Bước 2: Lưu DB password trong Secrets Manager**

1. Vào **AWS Secrets Manager Console** → **Store a new secret**.
2. Secret type: `Credentials for RDS database`.
3. Nhập:

   * Username: `admin`
   * Password: `MyTempPass123!`
   * RDS DB instance: chọn instance vừa tạo.
4. Đặt tên: `MyApp/RDSSecret`.
5. Enable automatic rotation:

   * Tạo **Lambda rotation function** (AWS sẽ auto tạo cho bạn).
   * Rotation interval: **30 ngày**.

✅ Giờ DB password sẽ tự rotate khi tới hạn.
<img width="1566" height="602" alt="image" src="https://github.com/user-attachments/assets/1848c292-652d-4dfc-84e7-6da8481e685a" />

---

### **Bước 3: Lưu DB password trong Parameter Store**

1. Vào **Systems Manager** → **Parameter Store** → **Create parameter**.
2. Name: `/MyApp/RDSPassword`
3. Type: **SecureString** (chọn KMS key default).
4. Value: `MyTempPass123!`
5. Save.

❌ Lưu ý: Parameter Store không có auto-rotation → bạn phải đổi thủ công.

---

### **Bước 4: Tạo Lambda để truy cập secret**

1. Vào **Lambda Console** → Create function → `Python 3.12`.
2. Trong code Lambda, paste nội dung:

```python
import boto3
import os

def lambda_handler(event, context):
    secret_name = "MyApp/RDSSecret"
    parameter_name = "/MyApp/RDSPassword"
    region_name = "us-east-1"

    # Secrets Manager client
    sm_client = boto3.client('secretsmanager', region_name=region_name)
    # Parameter Store client
    ssm_client = boto3.client('ssm', region_name=region_name)

    # Lấy secret từ Secrets Manager
    sm_response = sm_client.get_secret_value(SecretId=secret_name)
    sm_secret = sm_response['SecretString']

    # Lấy password từ Parameter Store
    ssm_response = ssm_client.get_parameter(Name=parameter_name, WithDecryption=True)
    ssm_secret = ssm_response['Parameter']['Value']

    return {
        'SecretsManager': sm_secret,
        'ParameterStore': ssm_secret
    }
```
<img width="1361" height="622" alt="image" src="https://github.com/user-attachments/assets/6684d971-674d-43e3-8571-57dd2d97c511" />

3. Gán cho Lambda quyền:

   * `SecretsManagerReadWrite`
   * `AmazonSSMReadOnlyAccess`
<img width="1570" height="758" alt="image" src="https://github.com/user-attachments/assets/bd114538-d94c-44b5-bf64-9e4e4b61f094" />

---

### **Bước 5: Test**

* Run Lambda test → output sẽ trả về:

  * Password từ **Secrets Manager** (JSON gồm username + password).
  * Password từ **Parameter Store** (chỉ value string).
<img width="1322" height="476" alt="image" src="https://github.com/user-attachments/assets/80e7a8f6-464f-49d0-a1ee-4ec3ea0883d9" />

---

### **Bước 6: Thử rotation**

* Vào **Secrets Manager** → chọn secret → click **Rotate secret now**.
* AWS sẽ tạo mật khẩu mới cho RDS.
* Lambda khi chạy lại → thấy password mới từ Secrets Manager.
* Nhưng Parameter Store vẫn giữ **mật khẩu cũ** (bạn phải update thủ công).

---

## 📌 Kết quả học được

* Secrets Manager: **tự động rotate**, format JSON, chuyên cho secret.
* Parameter Store: **chỉ lưu config**, không rotate, thích hợp lưu settings.

---

