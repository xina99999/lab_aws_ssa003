
#### **5. IAM Best Practices (Các phương pháp hay nhất)**
*   **Các lab để thực hành:**
    *   **Root Account Protection:** Không sử dụng root account cho tasks hàng ngày. Chỉ dùng để tạo user admin đầu tiên.
    *   **Áp dụng Principle of Least Privilege (Nguyên tắc đặc quyền tối thiểu):** Trong lab, tạo một policy chỉ cho phép đọc một bucket S3 cụ thể, thay vì gán `AmazonS3FullAccess`.
    *   **Sử dụng Groups:** Tạo group `Admins`, gán policy `AdministratorAccess`, và thêm users vào nhóm thay vì gán policy trực tiếp.
    *   **Bật MFA (Xem mục 6):** Thực hành bật MFA cho user.
    *   **Sử dụng Roles:** Tạo role cho EC2 thay vì lưu access key trên instance.
    *   **Xoay Access Keys:** Trong lab, tạo một access key mới cho user, sau đó disable hoặc xóa key cũ.
