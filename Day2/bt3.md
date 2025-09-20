
#### **3. IAM Roles (Vai trò IAM)**
*   **Mục đích:** Cấp quyền tạm thời cho một thực thể (AWS service, user thuộc account khác, ứng dụng bên ngoài) mà không cần chia sẻ secret key.
*   **Các thao tác lab chính:**
    *   **Tạo Role:**
        *   **Chọn trusted entity (đối tượng được ủy quyền):** AWS Service (ví dụ: EC2, Lambda), Another AWS Account, Web Identity (Google, Facebook...).
        *   <img width="1597" height="678" alt="image" src="https://github.com/user-attachments/assets/df85f4ba-19b6-4ae1-b83b-36d5aedc5d77" />
        *   <img width="1585" height="650" alt="image" src="https://github.com/user-attachments/assets/f840a6a5-6d1a-4193-a18d-e0f0ffd95e87" />
        *  <img width="1583" height="648" alt="image" src="https://github.com/user-attachments/assets/5f514de6-9f46-428b-9206-911120c8f541" />
        *   **Gán Permissions:** Gán các policies cần thiết cho role (ví dụ: `AmazonS3FullAccess` cho role EC2).
        *    <img width="1574" height="476" alt="image" src="https://github.com/user-attachments/assets/f92f405e-3d65-45a3-ac65-bc114f9c4f7e" />
        *   **Đặt tên và Review:** Đặt tên role (ví dụ: `EC2-to-S3-Role`) và tạo.
        *   <img width="1312" height="99" alt="image" src="https://github.com/user-attachments/assets/5b5846ad-fa15-41ab-941a-adec36fbcd2b" />
    *   **Gán Role cho EC2 Instance (Lab phổ biến):**
        *   Tạo EC2 instance(Xem hướng dẫn ở buổi ec2).
        *   <img width="1320" height="623" alt="image" src="https://github.com/user-attachments/assets/313a1c84-7d9c-47aa-8932-403e0ac4f2fd" />
        *   Trong bước "Configure Instance", mục "IAM role", chọn role vừa tạo.
        *   <img width="600" height="321" alt="image" src="https://github.com/user-attachments/assets/3a018424-7acb-4c1d-a1f3-8a303435dc77" />
        *  <img width="1595" height="403" alt="image" src="https://github.com/user-attachments/assets/1fd8440e-12a4-436d-aa80-4ff00334a655" />
        *   SSH vào instance và dùng AWS CLI để test quyền truy cập S3 mà không cần cấu hình access key.
        *   <img width="1003" height="68" alt="image" src="https://github.com/user-attachments/assets/99a8fa75-8575-4f03-a460-3edf7aca82cd" />
        * Tạo file myfile.txt và upload vào s3 bằng ec2
        * <img width="764" height="88" alt="image" src="https://github.com/user-attachments/assets/e789a59c-6119-4163-a3b6-0479188eb7e8" />
        *  Kiểm tra lại trên s3 dashboard
        *  <img width="1297" height="376" alt="image" src="https://github.com/user-attachments/assets/c2813ed7-686c-4a7a-9bce-6c43570317a9" />




