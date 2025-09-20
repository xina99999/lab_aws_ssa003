

---

### **Tổng hợp Lab IAM trên AWS**

#### **1. IAM Users (Người dùng IAM)**
*   **Mục đích:** Tạo ra một danh tính (username và password hoặc access key) cho một người hoặc ứng dụng để tương tác với AWS.
*   **Các thao tác lab chính:**
    *   **Tạo User:** Điền tên user, chọn loại truy cập (Programmatic access, AWS Management Console access).
    *   **Set password:** Có thể set mật khẩu tùy chỉnh hoặc để AWS tự generate.
    *   **Gán Permissions:** Gán policy trực tiếp cho user hoặc thêm user vào nhóm (group) đã có policy.
    *   **Tạo Access Key:** Ghi lại **Access Key ID** và **Secret Access Key** (chỉ hiện một lần khi tạo).
    *   **Đăng nhập thử:** Sử dụng URL đặc biệt của account (`https://<your-account-id-or-alias>.signin.aws.amazon.com/console`) để đăng nhập với user vừa tạo.

#### **2. IAM Groups (Nhóm IAM)**
*   **Mục đích:** Nhóm các users lại để quản lý quyền (permissions) một cách tập trung và hiệu quả.
*   **Các thao tác lab chính:**
    *   **Tạo Group:** Đặt tên nhóm (ví dụ: `Developers`, `Admins`).
    *   **Gán Policy cho Group:** Tìm và gán các managed policies (như `AdministratorAccess`, `AmazonS3ReadOnlyAccess`) hoặc custom policy cho group.
    *   **Thêm User vào Group:** Có thể thêm user vào group ngay khi tạo user hoặc thêm vào sau từ danh sách users.

#### **3. IAM Roles (Vai trò IAM)**
*   **Mục đích:** Cấp quyền tạm thời cho một thực thể (AWS service, user thuộc account khác, ứng dụng bên ngoài) mà không cần chia sẻ secret key.
*   **Các thao tác lab chính:**
    *   **Tạo Role:**
        *   **Chọn trusted entity (đối tượng được ủy quyền):** AWS Service (ví dụ: EC2, Lambda), Another AWS Account, Web Identity (Google, Facebook...).
        *   **Gán Permissions:** Gán các policies cần thiết cho role (ví dụ: `AmazonS3FullAccess` cho role EC2).
        *   **Đặt tên và Review:** Đặt tên role (ví dụ: `EC2-to-S3-Role`) và tạo.
    *   **Gán Role cho EC2 Instance (Lab phổ biến):**
        *   Tạo EC2 instance.
        *   Trong bước "Configure Instance", mục "IAM role", chọn role vừa tạo.
        *   SSH vào instance và dùng AWS CLI để test quyền truy cập S3 mà không cần cấu hình access key.

#### **4. IAM Policies (Chính sách IAM)**
*   **Mục đích:** Định nghĩa các quyền ( permissions ) dưới dạng JSON, quy định những hành động được phép hoặc bị từ chối trên tài nguyên nào.
*   **Các thao tác lab chính:**
    *   **Tạo Custom Policy (Visual Editor):**
        *   Chọn Service (ví dụ: S3).
        *   Chọn Actions (Read, Write, List...).
        *   Chỉ định Resources (ARN của bucket hoặc object cụ thể, hoặc `*` cho tất cả).
        *   Có thể thêm conditions (điều kiện) nếu cần.
    *   **Tạo Custom Policy (JSON):** Viết hoặc chỉnh sửa trực tiếp đoạn JSON.
    *   **Gán Policy:** Gán policy vừa tạo cho user, group hoặc role.
    *   **Test Policy:** Đăng nhập bằng user có policy đó để kiểm tra quyền.

#### **5. IAM Best Practices (Các phương pháp hay nhất)**
*   **Các lab để thực hành:**
    *   **Root Account Protection:** Không sử dụng root account cho tasks hàng ngày. Chỉ dùng để tạo user admin đầu tiên.
    *   **Áp dụng Principle of Least Privilege (Nguyên tắc đặc quyền tối thiểu):** Trong lab, tạo một policy chỉ cho phép đọc một bucket S3 cụ thể, thay vì gán `AmazonS3FullAccess`.
    *   **Sử dụng Groups:** Tạo group `Admins`, gán policy `AdministratorAccess`, và thêm users vào nhóm thay vì gán policy trực tiếp.
    *   **Bật MFA (Xem mục 6):** Thực hành bật MFA cho user.
    *   **Sử dụng Roles:** Tạo role cho EC2 thay vì lưu access key trên instance.
    *   **Xoay Access Keys:** Trong lab, tạo một access key mới cho user, sau đó disable hoặc xóa key cũ.

#### **6. MFA (Multi-Factor Authentication)**
*   **Mục đích:** Tăng cường bảo mật bằng yếu tố xác thực thứ 2 (mã từ điện thoại).
*   **Các thao tác lab chính:**
    *   **Bật MFA cho User:**
        *   Đăng nhập bằng user có đủ quyền (hoặc root).
        *   Vào IAM > Users > chọn user > Security credentials.
        *   Chọn "Assign MFA device".
        *   Chọn loại device (Virtual MFA là phổ biến nhất, dùng app như Google Authenticator ho Authy).
        *   Quét QR code và nhập 2 mã liên tiếp từ app để kích hoạt.
    *   **Test:** Đăng xuất và đăng nhập lại bằng user đó, bạn sẽ được yêu cầu nhập mã MFA.

#### **7. IAM Federation (Liên kết IAM)**
*   **Mục đích:** Cho phép users từ hệ thống identity bên ngoài (như Active Directory công ty hoặc tài khoản Google/Facebook) đăng nhập vào AWS mà không cần tạo IAM user.
*   **Các lab có thể có (thường nâng cao):**
    *   **SAML 2.0 Federation:** Cấu hình AWS như một Service Provider (SP) và kết nối với Identity Provider (IdP) như Microsoft AD FS hoặc Okta. (Lab này cần có sẵn IdP).
    *   **Web Identity Federation:** Tạo một Identity Pool với Amazon Cognito (dịch vụ của AWS) để cho phép users đăng nhập bằng Google, Facebook, Amazon... và nhận được AWS credentials tạm thời.
    *   **Custom Identity Broker:** Viết một ứng dụng trung gian (broker) để xác thực user và gọi `AssumeRole` để trả về credentials cho AWS.

---

