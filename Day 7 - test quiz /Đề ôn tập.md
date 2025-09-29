

---

# 📘 AWS SAA-C03 Practice Test (40 Questions)

## IAM & Security

**Q1.** Một công ty muốn cung cấp quyền truy cập tạm thời vào AWS cho một ứng dụng bên thứ ba. Giải pháp nào là tốt nhất?

* [ ] A. Tạo user IAM và cấp Access Key
* [ ] B. Tạo role IAM và sử dụng **STS AssumeRole**
* [ ] C. Tạo group IAM và gán policy
* [ ] D. Sử dụng root account để chia sẻ key

---

**Q2.** Một developer cần quyền chỉ đọc với S3 bucket. Bạn nên gán quyền ở đâu để **tuân thủ best practice**?

* [ ] A. Gán policy trực tiếp cho user IAM
* [ ] B. Gán policy vào group IAM, rồi cho user tham gia group
* [ ] C. Gán ACL ở bucket
* [ ] D. Dùng access key của root account

---

**Q3.** Một tổ chức cần bật **MFA bắt buộc** khi người dùng IAM truy cập console. Cách làm nào đúng?

* [ ] A. Bật MFA ở cấp account
* [ ] B. Tạo IAM policy bắt buộc MFA
* [ ] C. Bật MFA ở EC2
* [ ] D. Bật MFA ở S3 bucket

---

## VPC & Networking

**Q4.** Một kiến trúc sư cần triển khai ứng dụng web public và database private. Giải pháp nào đúng?

* [ ] A. Tất cả EC2 trong 1 public subnet
* [ ] B. Web server trong public subnet, DB server trong private subnet
* [ ] C. DB server trong public subnet với security group hạn chế
* [ ] D. Dùng default VPC, không cần subnet

---

**Q5.** Muốn kết nối VPC với on-premise data center một cách **ổn định và bảo mật**, chọn gì?

* [ ] A. VPC Peering
* [ ] B. AWS Direct Connect
* [ ] C. NAT Gateway
* [ ] D. Internet Gateway

---

**Q6.** Ứng dụng web cần tải bản cập nhật từ internet nhưng database ở private subnet. Chọn gì?

* [ ] A. Internet Gateway trong private subnet
* [ ] B. NAT Gateway trong public subnet
* [ ] C. S3 VPC Endpoint
* [ ] D. VPC Peering

---

## Compute

**Q7.** Một ứng dụng batch chạy ban đêm, cần giảm chi phí compute. Giải pháp nào tối ưu?

* [ ] A. On-Demand Instances
* [ ] B. Reserved Instances
* [ ] C. Spot Instances
* [ ] D. Dedicated Instances

---

**Q8.** Một công ty muốn cân bằng tải HTTPS traffic đến ứng dụng web. Họ nên dùng gì?

* [ ] A. Classic Load Balancer
* [ ] B. Application Load Balancer
* [ ] C. Network Load Balancer
* [ ] D. Gateway Load Balancer

---

**Q9.** Auto Scaling Group (min=2, max=6). Một AZ bị mất điện, chuyện gì xảy ra?

* [ ] A. ASG không thay đổi
* [ ] B. ASG khởi tạo instance mới ở AZ khác
* [ ] C. Tất cả instance bị terminate
* [ ] D. Người dùng phải tạo lại ASG

---

**Q10.** Công ty muốn chạy API backend không quản lý server, scale theo request. Chọn gì?

* [ ] A. EC2 Spot
* [ ] B. ECS
* [ ] C. Lambda
* [ ] D. Elastic Beanstalk

---

## Storage

**Q11.** Lưu log 7 năm, chi phí thấp, có thể khôi phục khi cần. Chọn gì?

* [ ] A. S3 Standard
* [ ] B. S3 Intelligent-Tiering
* [ ] C. S3 Glacier Deep Archive
* [ ] D. EBS

---

**Q12.** Khi EC2 bị terminate, dữ liệu trong **EBS root volume** sẽ?

* [ ] A. Bị xóa
* [ ] B. Được giữ lại
* [ ] C. Chuyển sang S3
* [ ] D. Sao lưu vào Glacier

---

**Q13.** Ứng dụng big data cần nhiều server truy cập file system qua NFS. Dịch vụ nào?

* [ ] A. EBS
* [ ] B. EFS
* [ ] C. Instance Store
* [ ] D. Glacier

---

**Q14.** Giới hạn truy cập vào S3 bucket chỉ từ VPC. Bạn nên dùng gì?

* [ ] A. Bucket ACL
* [ ] B. IAM Policy
* [ ] C. S3 VPC Endpoint
* [ ] D. CloudFront

---

**Q15.** Phục vụ nội dung tĩnh S3 cho khách hàng toàn cầu, độ trễ thấp. Giải pháp?

* [ ] A. S3 Transfer Acceleration
* [ ] B. CloudFront + S3
* [ ] C. Direct Connect
* [ ] D. ALB

---

## Database

**Q16.** Ứng dụng e-commerce cần RDS HA multi-AZ. Khi AZ chính gặp sự cố?

* [ ] A. RDS failover sang standby
* [ ] B. Restore từ snapshot
* [ ] C. Người dùng phải tạo DB mới
* [ ] D. Dữ liệu bị mất

---

**Q17.** Ứng dụng cần NoSQL, millisecond latency, scale linh hoạt. Dịch vụ nào?

* [ ] A. RDS MySQL
* [ ] B. DynamoDB
* [ ] C. Redshift
* [ ] D. Aurora

---

**Q18.** Giảm chi phí DynamoDB khi workload không ổn định. Chọn gì?

* [ ] A. On-demand capacity mode
* [ ] B. Provisioned mode + autoscaling
* [ ] C. Reserved capacity
* [ ] D. Global tables

---

**Q19.** Đọc DynamoDB multi-region với low latency. Giải pháp?

* [ ] A. DynamoDB Streams
* [ ] B. DynamoDB Global Tables
* [ ] C. ElastiCache
* [ ] D. S3 Cross-Region Replication

---

**Q20.** Dữ liệu OLAP petabyte-scale. Chọn gì?

* [ ] A. RDS
* [ ] B. Redshift
* [ ] C. Aurora
* [ ] D. DynamoDB

---

## Monitoring & HA

**Q21.** Nhận cảnh báo khi CPU EC2 > 80%. Dùng gì?

* [ ] A. CloudTrail
* [ ] B. CloudWatch Alarm
* [ ] C. Trusted Advisor
* [ ] D. Config

---

**Q22.** Theo dõi lịch sử thay đổi resource (VD: Security Group). Dùng gì?

* [ ] A. CloudTrail
* [ ] B. Config
* [ ] C. CloudWatch
* [ ] D. GuardDuty

---

**Q23.** Trusted Advisor dùng để?

* [ ] A. Quản lý IAM user
* [ ] B. Kiểm tra cost optimization, HA, security
* [ ] C. Quản lý log S3
* [ ] D. Scale Auto Scaling Group

---

**Q24.** Giảm chi phí EC2 cho workload chạy liên tục 1-3 năm. Chọn gì?

* [ ] A. Spot
* [ ] B. Reserved Instances
* [ ] C. On-Demand
* [ ] D. Dedicated Host

---

**Q25.** Compliance log không thể xóa. Giải pháp nào?

* [ ] A. CloudWatch Logs
* [ ] B. S3 Object Lock (WORM)
* [ ] C. EBS Snapshot
* [ ] D. CloudTrail

---

## Mixed Scenario

**Q26.** Triển khai ứng dụng latency thấp toàn cầu. Chọn gì?

* [ ] A. Multi-AZ RDS
* [ ] B. CloudFront + Global Accelerator
* [ ] C. VPC Peering
* [ ] D. Route 53 + ALB

---

**Q27.** Ứng dụng nhiều tầng (web, app, DB). Thiết kế VPC thế nào?

* [ ] A. 1 subnet cho tất cả
* [ ] B. Public subnet cho web, private subnet cho app & DB
* [ ] C. Public subnet cho tất cả instance
* [ ] D. Dùng default VPC

---

**Q28.** Migrate petabyte dữ liệu on-premise lên AWS nhanh và rẻ. Chọn gì?

* [ ] A. Direct Connect
* [ ] B. Snowball
* [ ] C. VPN
* [ ] D. S3 Transfer Acceleration

---

**Q29.** EC2 mới tự động đăng ký vào ALB target group. Làm thế nào?

* [ ] A. Cấu hình trong Auto Scaling Group
* [ ] B. Tạo Lambda thêm thủ công
* [ ] C. Viết script trong EC2
* [ ] D. Không thể tự động

---

**Q30.** Ứng dụng IoT cần xử lý **hàng triệu request/giây**. Giải pháp nào?

* [ ] A. SQS
* [ ] B. Kinesis Data Streams
* [ ] C. DynamoDB Streams
* [ ] D. SNS

---

**Q31.** Giảm độ trễ DNS toàn cầu. Giải pháp nào?

* [ ] A. CloudFront
* [ ] B. Route 53 latency-based routing
* [ ] C. Direct Connect
* [ ] D. NAT Gateway

---

**Q32.** EC2 giữ nguyên private IP khi restart. Làm thế nào?

* [ ] A. Dùng Elastic IP
* [ ] B. DHCP option set
* [ ] C. Placement group
* [ ] D. Private IP mặc định đã giữ nguyên khi restart

---

**Q33.** Để bật encryption cho EBS volume, bạn cần?

* [ ] A. IAM role
* [ ] B. AWS KMS
* [ ] C. CloudHSM
* [ ] D. CloudTrail

---

**Q34.** Gửi notification khi object mới được upload vào S3. Giải pháp?

* [ ] A. CloudTrail
* [ ] B. EventBridge hoặc S3 Event Notification → SNS/SQS/Lambda
* [ ] C. CloudWatch Alarm
* [ ] D. IAM Policy

---

**Q35.** Workload cần compute hiệu năng cao + network throughput tối đa. Chọn gì?

* [ ] A. Spot instance
* [ ] B. Compute Optimized (C5n)
* [ ] C. T3 burstable
* [ ] D. Reserved instance

---

**Q36.** Triển khai microservices theo hướng serverless. Giải pháp?

* [ ] A. ECS on EC2
* [ ] B. ECS on Fargate
* [ ] C. EKS
* [ ] D. Beanstalk

---

**Q37.** Giới hạn truy cập API bằng rate limit. Dùng gì?

* [ ] A. API Gateway throttling
* [ ] B. WAF
* [ ] C. Route 53
* [ ] D. Security Group

---

**Q38.** Disaster recovery chi phí thấp, chỉ chạy khi có sự cố. Chiến lược nào?

* [ ] A. Multi-site active-active
* [ ] B. Pilot light
* [ ] C. Warm standby
* [ ] D. Backup & Restore

---

**Q39.** EC2 có quyền đọc S3 bucket. Giải pháp secure nhất?

* [ ] A. Gán IAM Role cho EC2
* [ ] B. Tạo Access Key trong EC2
* [ ] C. Copy root credential vào EC2
* [ ] D. ACL trong S3 bucket

---

**Q40.** Khi tạo VPC mới, thành phần nào được tạo mặc định?

* [ ] A. Internet Gateway
* [ ] B. Route Table + Security Group + NACL
* [ ] C. NAT Gateway
* [ ] D. Bastion Host

---


