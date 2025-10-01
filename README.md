

---

## Thông tin về exam SAA-C03 cần nắm

* Các domain chính (trọng số):

  1. **Design Secure Architectures** – \~30 % 
  2. **Design Resilient Architectures** – \~26 % 
  3. **Design High-Performing Architectures** – \~24 %
  4. **Design Cost-Optimized Architectures** – \~20 %

* Yêu cầu: ít nhất 1 năm kinh nghiệm thực hành về thiết kế kiến trúc hệ thống AWS, familiar với các dịch vụ như IAM, VPC, EC2, S3, RDS, Lambda etc.
* Phương thức thi: câu hỏi nhiều lựa chọn và nhiều đáp án (multiple response), tình huống thực tế, không phải lab. 

---

## Lịch học 60 ngày

Mình chia thành 8 tuần + 4 ngày đệm để ôn lại & làm mock exam. Mỗi ngày đều có chủ đề rõ ràng + thực hành + kiểm tra nhỏ nếu được.

| Tuần       | Ngày   | Nội dung học lý thuyết / chủ đề chính                                                                              | Thực hành / lab                                                                                                             | Ghi chú                                                        |
| ---------- | ------ | ------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| **Tuần 1** | Ngày 1 | Giới thiệu AWS & tổng quan SAA-C03; Well-Architected Framework; Global Infrastructure, Regions, Availability Zones | Tạo tài khoản AWS nếu chưa có; làm quen với console; khám phá Regions & AZ; thử deploy EC2 1 instance đơn giản              | Mục là làm quen môi trường AWS và hiểu cấu trúc hạ tầng cơ bản |
|            | Ngày 2 | IAM: Users, Groups, Roles, Policies, IAM Best Practices, MFA, IAM federation                                       | Tạo user, group, role; viết policy; thử cross-account access nếu có thể                                                     | IAM là phần nền tảng, rất quan trọng cho phần Secure Domain    |
|            | Ngày 3 | VPC cơ bản: Subnets, Route Tables, Internet Gateway, NAT Gateway, Security Groups, Network ACLs                    | Xây VPC có public/private subnet; thiết lập NAT; rules SG & NACL; test từ EC2 trong private subnet ra Internet và ngược lại |                                                                |
|            | Ngày 4 | Networking nâng cao: VPC Peering, Transit Gateway, VPN, AWS Direct Connect, Elastic Load Balancing                 | Lab thiết lập Load Balancer (ELB), autoscaling; thử peering hoặc VPN nếu có tài nguyên                                      |                                                                |
|            | Ngày 5 | Compute Services: EC2, Lambda, Auto Scaling, Container Basics (ECS, Fargate)                                       | Deploy EC2 + chỉnh auto scaling; viết thử hàm Lambda; đơn giản với ecs/fargate nếu có thời gian                             |                                                                |
|            | Ngày 6 | Storage & Database: S3, EBS, EFS, Glacier; RDS, DynamoDB, Aurora                                                   | Lab: tạo bucket S3; lifecycle rules; snapshot; RDS setup; DynamoDB table; thử backup/restore                                |                                                                |
|            | Ngày 7 | Review tuần 1: làm quiz / đề kiểm tra nhỏ nội dung IAM / VPC / Compute / Storage; fix các chỗ chưa hiểu            | Ôn lại lab; làm quiz / bài tập nhỏ; xem lại các topic khó                                                                   |                                                                |



### Tuần 2

| Ngày | Nội dung học                                                             | Thực hành / Lab                                                           | Ghi chú                               |
| ---- | ------------------------------------------------------------------------ | ------------------------------------------------------------------------- | ------------------------------------- |
| 8    | Security: Encryption (KMS), ACM, Secrets Manager; WAF, Shield, GuardDuty | Tạo key KMS, mã hóa S3, bật GuardDuty, cấu hình WAF rule                  | Trọng tâm: bảo mật dữ liệu & ứng dụng |
| 9    | Monitoring: CloudWatch, CloudTrail, AWS Config, X-Ray                    | Bật CloudTrail, tạo alarm CloudWatch, cấu hình log, thử tracing với X-Ray | Hiểu monitoring & audit               |
| 10   | Resilience & HA: Multi-AZ, Multi-Region, Failover                        | RDS Multi-AZ, cross-region replication, thử recovery                      | Quan trọng cho domain resilience      |
| 11   | Serverless: Lambda, API Gateway, Event-driven, SQS/SNS                   | Xây app nhỏ Lambda + API Gateway, tích hợp SNS/SQS                        | Học cách decouple                     |
| 12   | Performance Optimization: Caching (ElastiCache), CloudFront, DB replicas | Setup CloudFront, ElastiCache, test Read Replica                          | Bài lab về tối ưu hiệu năng           |
| 13   | Cost Optimization: Cost Explorer, Spot, Reserved, Rightsizing            | Bật cost explorer, tạo billing alerts, thử spot instance                  | Luyện trade-offs cost                 |
| 14   | Review tuần 2                                                            | Quiz + ôn lab                                                             | Tổng hợp kiến thức                    |

---

### Tuần 3

| Ngày | Nội dung học                                               | Lab                                           | Ghi chú                   |
| ---- | ---------------------------------------------------------- | --------------------------------------------- | ------------------------- |
| 15   | AWS Databases: RDS, Aurora, DynamoDB, Redshift             | Tạo DB, migration nhỏ, query thử              | So sánh DB services       |
| 16   | Networking nâng cao: VPC Endpoints, PrivateLink            | Setup endpoint, test private access           | Hiểu segmentation         |
| 17   | IAM nâng cao: STS, Roles, Resource policies, cross-account | Assume role, role chaining, thử cross-account | Security nâng cao         |
| 18   | DR & Business Continuity: RPO/RTO, backup strategies       | Thiết kế DR plan, test failover               | Quan trọng cho resilience |
| 19   | Containers & CI/CD: ECS, EKS overview, CodePipeline        | Deploy ECS sample, tạo pipeline               | Hiểu microservices        |
| 20   | Governance: AWS Organizations, SCPs, Tagging               | Tạo Org, SCP, tag policy                      | Quản lý multi-account     |
| 21   | Review tuần 3                                              | Quiz + ôn lab                                 | Đánh giá tiến độ          |

---

### Tuần 4

| Ngày | Nội dung học                                 | Lab                           | Ghi chú                     |
| ---- | -------------------------------------------- | ----------------------------- | --------------------------- |
| 22   | High-Performance Arch: scaling, caching, CDN | Multi-tier app + CloudFront   | Performance                 |
| 23   | Security nâng cao: NACL vs SG, WAF, Shield   | Thiết lập rules, audit        | Defense in depth            |
| 24   | Monitoring nâng cao: dashboards, tracing     | CloudWatch dashboards + X-Ray | Quan sát toàn diện          |
| 25   | Cost & Operational Excellence                | Rightsizing, tagging cost     | Tối ưu chi phí              |
| 26   | Case studies thực tế                         | Vẽ kiến trúc + phân tích      | Rèn tư duy thiết kế         |
| 27   | Mock Exam 1                                  | Làm đề full 65 câu            | Luyện tốc độ & độ chính xác |
| 28   | Review Mock 1                                | Phân tích lỗi, bổ sung lab    | Học từ sai sót              |

---

### Tuần 5

| Ngày | Nội dung học                                                 | Lab                            | Ghi chú                |
| ---- | ------------------------------------------------------------ | ------------------------------ | ---------------------- |
| 29   | App Integration: EventBridge, Step Functions                 | Tạo workflow serverless        | Thực hành integration  |
| 30   | IaC: CloudFormation/CDK basics                               | Deploy stack CFN, update       | Infrastructure as Code |
| 31   | Hybrid Architectures: On-prem + Cloud                        | Migration plan, Snowball study | Biết giải pháp hybrid  |
| 32   | Logging & Audit: Incident response, compliance               | Audit logs, giả lập breach     | Security response      |
| 33   | Reliability patterns: Retry, DLQ, idempotency                | SQS DLQ, retry logic           | Ứng dụng pattern       |
| 34   | Performance tuning: DB indexing, caching, Global Accelerator | Test latency, thử accelerator  | Hiệu năng nâng cao     |
| 35   | Review tuần 5                                                | Quiz + ôn lab                  | Củng cố kiến thức      |

---

### Tuần 6

| Ngày | Nội dung học                   | Lab                              | Ghi chú              |
| ---- | ------------------------------ | -------------------------------- | -------------------- |
| 36   | Security + Networking tổng hợp | Thiết kế arch full stack an toàn | Kiến trúc hoàn chỉnh |
| 37   | Cost + Performance tổng hợp    | Trade-offs với cost calc         | So sánh giải pháp    |
| 38   | Resilience & Recovery tổng hợp | Multi-region + backup            | DR plan thực tế      |
| 39   | High Availability & Scaling    | Web app autoscaling + CDN        | Kiến trúc HA         |
| 40   | Mock Exam 2                    | Làm đề full 65 câu               | Giả lập kỳ thi       |
| 41   | Review Mock 2                  | Phân tích lỗi + bổ sung lab      | Tập trung phần yếu   |
| 42   | Thiết kế kiến trúc tổng thể    | Viết design doc cho case study   | Thực hành end-to-end |

---

### Tuần 7

| Ngày | Nội dung học                  | Lab                   | Ghi chú             |
| ---- | ----------------------------- | --------------------- | ------------------- |
| 43   | Làm lại các lab chính         | IAM, VPC, EC2, RDS…   | Thành thạo thao tác |
| 44   | Ôn Secure + Resilient domains | Quiz + notes          | Trọng số cao        |
| 45   | Ôn High-Perf + Cost domains   | Quiz + notes          | Bổ sung điểm yếu    |
| 46   | Practice exam theo domain     | 15–20 câu/domain      | Luyện tốc độ        |
| 47   | AWS updates mới               | AWS blog, service mới | Nắm xu hướng        |
| 48   | Ôn tổng hợp                   | Flashcards, notes     | Chuẩn bị mock       |
| 49   | Mock Exam 3                   | Full đề 65 câu        | So sánh tiến bộ     |

---

### Tuần 8

| Ngày | Nội dung học             | Lab                    | Ghi chú                  |
| ---- | ------------------------ | ---------------------- | ------------------------ |
| 50   | Review Mock 3            | Fix lỗi + lab lại      | Bổ sung                  |
| 51   | Phân tích câu hỏi mẫu    | Xem pattern câu hỏi    | Tăng kỹ năng chọn đáp án |
| 52   | Ôn lab nhanh             | IAM, VPC, S3, RDS      | Ôn thao tác              |
| 53   | Ôn Security + Monitoring | Logs, audit, WAF       | Quan trọng               |
| 54   | Ôn Cost optimization     | Calculator, trade-offs | Tối ưu chi phí           |
| 55   | Mock Exam 4              | Full đề 65 câu         | Tổng duyệt               |
| 56   | Review Mock 4            | Fix lỗi, thư giãn nhẹ  | Giữ tinh thần tốt        |

---

### Ngày đệm (57–60)

| Ngày | Nội dung                              | Ghi chú             |
| ---- | ------------------------------------- | ------------------- |
| 57   | Ôn nhanh domain chính bằng flashcards | Không học mới       |
| 58   | Làm mock cuối cùng nếu còn thời gian  | Luyện tập thêm      |
| 59   | Chuẩn bị thi: nghỉ ngơi, review notes | Sức khỏe quan trọng |
| 60   | Thi thật                              | Chúc thành công 🎉  |

---



---

## Một vài lời khuyên khi thực hiện plan

* **Thực hành nhiều**: lab & làm mock exam là cực kỳ quan trọng. Ngay khi bạn học một dịch vụ, hãy làm thử hands-on.
* **Case study & thinking architecture**: không chỉ học từng dịch vụ riêng lẻ mà hãy nghĩ cách kết hợp chúng trong hệ thống thực tế — trade-offs giữa chi phí / bảo mật / hiệu suất / độ chịu lỗi.
* **Ôn theo domain trọng số**: Secure + Resilient là \~56 % tổng số điểm — dành nhiều thời gian vào đó.
* **Đọc whitepapers / Best practices AWS**: AWS Well-Architected Framework, Security Best Practices, Reliability Pillar …
* **Chú ý cập nhật mới**: AWS thay đổi nhiều, có dịch vụ mới, hoặc features mới, nên có thời gian cập nhật.
* **Tốc độ & time management**: trong exam có giới hạn thời gian 130 phút cho \~65 câu — tập làm quen để quản lý thời gian tốt.

---



