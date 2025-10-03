
---


## **Lab 2 – CloudWatch Alarm: Monitor CPU của EC2**

**Mục tiêu:** Tạo cảnh báo khi EC2 instance quá tải.

### Bước làm:

1. Tạo 1 **EC2 instance** nhỏ (t2.micro).
2. Vào **CloudWatch → Alarms → Create Alarm**:

   * Metric: `EC2 → Per-Instance Metrics → CPUUtilization`
   * Threshold: > 60% trong 5 phút.
3. Tạo **SNS topic** → đăng ký email của bạn.
4. Gắn Alarm vào EC2.
  <img width="1575" height="644" alt="image" src="https://github.com/user-attachments/assets/dd5473dd-7ec8-47c3-a1fe-2b2236fee0f8" />

6. SSH vào EC2 và chạy script stress test:

   ```bash
   sudo amazon-linux-extras install -y stress
   stress --cpu 2 --timeout 300
   ```
   <img width="1597" height="292" alt="image" src="https://github.com/user-attachments/assets/fbfbcbc7-f41c-41db-b382-d1e2db72f558" />

7. Quan sát Alarm chuyển từ **OK → ALARM**, và email cảnh báo gửi đến.
<img width="1367" height="684" alt="image" src="https://github.com/user-attachments/assets/5fddcc68-e220-4e7f-836e-b486746e474f" />

✅ **Kết quả mong đợi:** Bạn nhận được email “CPU Utilization > 60%”.

---



