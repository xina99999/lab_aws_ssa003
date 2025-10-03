

## **Lab 3 – AWS Config: Compliance Check**

**Mục tiêu:** Xác định S3 bucket nào không bật encryption.

### Bước làm:

1. Vào **AWS Config → Get Started**.

   * Chọn track resource: **S3** + **IAM**.
   * Lưu config history vào S3 bucket.
2. Tạo rule: **S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED**.
3. Tạo 2 bucket test:

   * `bucket-encrypted` → bật SSE-S3.
   * `bucket-unencrypted` → không bật encryption.
4. Vào **Config Console → Compliance**, kiểm tra kết quả.

✅ **Kết quả mong đợi:** 1 bucket “Compliant”, 1 bucket “Noncompliant”.




