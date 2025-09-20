
#### **6. MFA (Multi-Factor Authentication)**
*   **Mục đích:** Tăng cường bảo mật bằng yếu tố xác thực thứ 2 (mã từ điện thoại).
*   **Các thao tác lab chính:**
    *   **Bật MFA cho User:**
        *   Đăng nhập bằng user có đủ quyền (hoặc root).
        *   <img width="1273" height="648" alt="image" src="https://github.com/user-attachments/assets/ed0075ab-5c10-497e-82f3-06421f50fd26" />
        *   Vào IAM > Users > chọn user > Security credentials.
        *   <img width="1577" height="607" alt="image" src="https://github.com/user-attachments/assets/c926825c-2383-43b1-a875-17bbe510f389" />
        *   Chọn "Assign MFA device".
        *   <img width="1020" height="631" alt="image" src="https://github.com/user-attachments/assets/5712ac5b-fbbc-4fa2-9218-04cf5df9b1a5" />
        *   Chọn loại device (Virtual MFA là phổ biến nhất, dùng app như Google Authenticator ho Authy).
        *   Quét QR code và nhập 2 mã liên tiếp từ app để kích hoạt.
    *   **Test:** Đăng xuất và đăng nhập lại bằng user đó, bạn sẽ được yêu cầu nhập mã MFA.
