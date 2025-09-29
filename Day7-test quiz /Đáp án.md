

---

# 📘 AWS SAA-C03 Practice Test – Đáp Án & Giải Thích

## IAM & Security

**Q1.** → **B**
STS + IAM Role cung cấp quyền tạm thời, an toàn hơn access key.

**Q2.** → **B**
Best practice: gán policy cho group, rồi thêm user vào group.

**Q3.** → **B**
Dùng IAM policy bắt buộc MFA khi login console.

---

## VPC & Networking

**Q4.** → **B**
Web server ở public subnet, DB ở private subnet.

**Q5.** → **B**
Direct Connect = kết nối chuyên dụng, bảo mật, ổn định.

**Q6.** → **B**
Private subnet cần NAT Gateway (public) để ra internet.

---

## Compute

**Q7.** → **C**
Spot Instance rẻ nhất, phù hợp batch job.

**Q8.** → **B**
HTTPS → Application Load Balancer.

**Q9.** → **B**
ASG sẽ tự khởi tạo instance mới ở AZ khác.

**Q10.** → **C**
Lambda = serverless, tự động scale theo request.

---

## Storage

**Q11.** → **C**
S3 Glacier Deep Archive = lưu lâu, chi phí thấp.

**Q12.** → **A**
Mặc định EBS root volume sẽ bị xóa khi terminate.

**Q13.** → **B**
EFS hỗ trợ nhiều instance NFS access.

**Q14.** → **C**
S3 VPC Endpoint = giới hạn truy cập từ VPC.

**Q15.** → **B**
CloudFront + S3 = phục vụ nội dung tĩnh toàn cầu.

---

## Database

**Q16.** → **A**
Multi-AZ RDS tự động failover sang standby.

**Q17.** → **B**
DynamoDB = NoSQL, low latency, auto scale.

**Q18.** → **A**
On-demand capacity mode linh hoạt cho workload không ổn định.

**Q19.** → **B**
DynamoDB Global Tables = multi-region, low latency.

**Q20.** → **B**
Redshift = OLAP, petabyte-scale.

---

## Monitoring & HA

**Q21.** → **B**
CloudWatch Alarm theo dõi metric (CPU).

**Q22.** → **B**
Config theo dõi thay đổi resource.

**Q23.** → **B**
Trusted Advisor kiểm tra cost, HA, security, performance.

**Q24.** → **B**
Reserved Instance tối ưu chi phí 1-3 năm.

**Q25.** → **B**
S3 Object Lock (WORM) = log không thể xóa.

---

## Mixed Scenario

**Q26.** → **B**
CloudFront + Global Accelerator = latency thấp toàn cầu.

**Q27.** → **B**
Best practice: public subnet cho web, private cho app & DB.

**Q28.** → **B**
AWS Snowball = migrate dữ liệu petabyte rẻ + nhanh.

**Q29.** → **A**
ASG tự động đăng ký instance vào ALB.

**Q30.** → **B**
Kinesis Data Streams = xử lý real-time, hàng triệu req/s.

**Q31.** → **B**
Route 53 latency-based routing = giảm độ trễ DNS.

**Q32.** → **D**
Private IP giữ nguyên khi restart (Elastic IP chỉ giữ public IP).

**Q33.** → **B**
EBS encryption dùng KMS.

**Q34.** → **B**
S3 Event Notification → SNS/SQS/Lambda.

**Q35.** → **B**
Compute Optimized (C5n) = hiệu năng + network throughput cao.

**Q36.** → **B**
ECS on Fargate = serverless microservices.

**Q37.** → **A**
API Gateway throttling = giới hạn rate limit.

**Q38.** → **D**
Backup & Restore = DR chi phí thấp nhất.

**Q39.** → **A**
IAM Role cho EC2 = secure nhất.

**Q40.** → **B**
Mặc định VPC có Route Table, Security Group, NACL.

---


