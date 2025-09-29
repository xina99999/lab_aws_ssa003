
#### **4. IAM Policies (Chính sách IAM)**
*   **Mục đích:** Định nghĩa các quyền ( permissions ) dưới dạng JSON, quy định những hành động được phép hoặc bị từ chối trên tài nguyên nào.
*   **Các thao tác lab chính:**
    *   **Tạo Custom Policy (Visual Editor):**
        *   Chọn Service (ví dụ: S3).
        *   <img width="1583" height="681" alt="image" src="https://github.com/user-attachments/assets/5687b983-72f1-4bdf-9724-8e3ef885a5f3" />
        *   Chọn Actions (Read, Write, List...).
        *   <img width="1193" height="309" alt="image" src="https://github.com/user-attachments/assets/d30915c5-06c8-478c-a38f-6c01f28775c3" />
        *  <img width="1184" height="610" alt="image" src="https://github.com/user-attachments/assets/0c78a8f3-1524-4114-a9bc-74e69ef34030" />    
        *   Chỉ định Resources (ARN của bucket hoặc object cụ thể, hoặc `*` cho tất cả).
        *   <img width="1284" height="366" alt="image" src="https://github.com/user-attachments/assets/5a4ec1c5-eef4-4b6a-93e3-7b4de86377b8" />
        *   Có thể thêm conditions (điều kiện) nếu cần.
    *   **Tạo Custom Policy (JSON):** Viết hoặc chỉnh sửa trực tiếp đoạn JSON.
    *   <img width="1027" height="621" alt="image" src="https://github.com/user-attachments/assets/9ee04a6c-8f96-4e79-8fbb-c84407e8a12e" />
    *   **Gán Policy:** Gán policy vừa tạo cho user, group hoặc role.
    *   <img width="1284" height="355" alt="image" src="https://github.com/user-attachments/assets/4690569f-3f02-47ca-a024-d87e9e00caca" />
    *   **Test Policy:** Đăng nhập bằng user có policy đó để kiểm tra quyền.

