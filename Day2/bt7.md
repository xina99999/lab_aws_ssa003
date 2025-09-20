
#### **7. IAM Federation (Liên kết IAM)**
*   **Mục đích:** Cho phép users từ hệ thống identity bên ngoài (như Active Directory công ty hoặc tài khoản Google/Facebook) đăng nhập vào AWS mà không cần tạo IAM user.
*   **Các lab có thể có (thường nâng cao):**
    *   **SAML 2.0 Federation:** Cấu hình AWS như một Service Provider (SP) và kết nối với Identity Provider (IdP) như Microsoft AD FS hoặc Okta. (Lab này cần có sẵn IdP).
    *   **Web Identity Federation:** Tạo một Identity Pool với Amazon Cognito (dịch vụ của AWS) để cho phép users đăng nhập bằng Google, Facebook, Amazon... và nhận được AWS credentials tạm thời.
    *   **Custom Identity Broker:** Viết một ứng dụng trung gian (broker) để xác thực user và gọi `AssumeRole` để trả về credentials cho AWS.

 ## 
 **Web Identity Federation:** Tạo một Identity Pool với Amazon Cognito (dịch vụ của AWS) để cho phép users đăng nhập bằng Google, Facebook, Amazon... và nhận được AWS credentials tạm thời.
 Để tạo một **Identity Pool** với **Amazon Cognito** cho phép người dùng đăng nhập qua các dịch vụ như Google, Facebook, Amazon, và nhận được **AWS credentials** tạm thời, bạn có thể làm theo các bước sau:

### Bước 1: Tạo một **Cognito Identity Pool**

1. **Truy cập AWS Console**: Đăng nhập vào AWS Management Console.

2. **Đi đến Amazon Cognito**: Tìm kiếm "Cognito" trong thanh tìm kiếm và chọn **Cognito**.
<img width="1531" height="606" alt="image" src="https://github.com/user-attachments/assets/1df37bfa-763c-4bd5-bb3f-48a06fd762a9" />

3. **Chọn "Manage Identity Pools"**: Sau đó chọn "Create new identity pool".
<img width="1569" height="420" alt="image" src="https://github.com/user-attachments/assets/89118ad7-b992-45d4-84d1-bf31bc1457a0" />

4. **Điền thông tin cho Identity Pool**:

   * **Identity Pool Name**: Chọn tên cho Identity Pool.
   * **Authentication Providers**: Chọn các nhà cung cấp xác thực (Google, Facebook, Amazon, v.v.).
<img width="1294" height="556" alt="image" src="https://github.com/user-attachments/assets/e144ee39-7196-40ec-9d0f-2e0c87e43577" />

5. **Enable access to unauthenticated identities** (tùy chọn): Nếu bạn muốn hỗ trợ người dùng không đăng nhập, chọn ô này. Nếu không, người dùng phải đăng nhập trước khi sử dụng các dịch vụ AWS.

6. **Nhấn "Create Pool"**.

### Bước 2: Cấu hình các nhà cung cấp xác thực (Authentication Providers)

1. **Google**:

   * Truy cập [Google Developer Console](https://console.developers.google.com/).
   * Tạo một dự án mới hoặc chọn dự án hiện có.
   * Trong phần **Credentials**, tạo một **OAuth 2.0 Client ID**.
   * Lấy **Client ID** và **Client Secret**, sau đó quay lại trang Amazon Cognito và nhập các thông tin này vào phần **Google**.

2. **Facebook**:

   * Truy cập [Facebook Developers](https://developers.facebook.com/).
   * Tạo một ứng dụng mới hoặc chọn ứng dụng hiện có.
   * Lấy **App ID** và **App Secret**, sau đó nhập vào phần cấu hình **Facebook** trong Amazon Cognito.

3. **Amazon**:

   * Truy cập vào [AWS Cognito Console](https://console.aws.amazon.com/cognito/).
   * Chọn phần **Amazon** và nhập **App ID** (bạn có thể tạo ứng dụng tại Amazon Developer Console).

### Bước 3: Tạo và Cấu hình Roles

Khi bạn tạo một **Identity Pool**, bạn cần gán các vai trò (Roles) cho người dùng:

* **Authenticated Role**: Dành cho người dùng đã đăng nhập.
* **Unauthenticated Role**: Dành cho người dùng chưa đăng nhập (nếu bạn cho phép).

Cấu hình các vai trò này trong AWS IAM và cấp quyền thích hợp cho từng vai trò.

### Bước 4: Sử dụng SDK của AWS (AWS SDK) trong ứng dụng

Sau khi Identity Pool được tạo và cấu hình, bạn có thể sử dụng SDK của AWS (ví dụ: AWS SDK for JavaScript, AWS SDK for Android, hoặc iOS) để cho phép người dùng đăng nhập và nhận **AWS credentials** tạm thời.

#### Ví dụ sử dụng AWS SDK for JavaScript:

1. **Cài đặt AWS SDK**:

   ```bash
   npm install aws-sdk amazon-cognito-identity-js
   ```

2. **Cấu hình SDK**:

   ```javascript
   var AWS = require('aws-sdk');
   var AmazonCognitoIdentity = require('amazon-cognito-identity-js');

   // Thay đổi thông tin của bạn ở đây
   var poolData = {
       UserPoolId: 'us-east-1_XXXXXXX', // ID của User Pool
       ClientId: 'xxxxxxxxxxxxxxxxxxxxxx' // Client ID của App
   };

   var userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

   // Chọn nhà cung cấp đăng nhập (Google, Facebook, v.v.)
   var logins = {
       'accounts.google.com': googleIdToken, // Đặt Google ID token
       'graph.facebook.com': facebookAccessToken // Đặt Facebook access token
   };

   // Cấu hình Identity Pool
   AWS.config.region = 'us-east-1'; // Khu vực của Identity Pool
   var credentials = new AWS.CognitoIdentityCredentials({
       IdentityPoolId: 'us-east-1:xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx', // Identity Pool ID
       Logins: logins
   });

   AWS.config.credentials = credentials;

   // Lấy AWS credentials tạm thời
   credentials.get(function(err) {
       if (err) {
           console.log("Không thể lấy credentials: ", err);
       } else {
           console.log("AWS Credentials: ", AWS.config.credentials);
       }
   });
   ```

### Bước 5: Kiểm tra và sử dụng AWS credentials

Khi người dùng đăng nhập thành công qua các dịch vụ như Google hoặc Facebook, bạn sẽ nhận được **AWS credentials** tạm thời mà bạn có thể sử dụng để truy cập các dịch vụ AWS như S3, DynamoDB, Lambda, v.v.

### Các bước khác (tuỳ chọn):

* **Tạo API Gateway hoặc Lambda Functions** để người dùng có thể sử dụng các dịch vụ AWS sau khi nhận được credentials.
* **Quản lý quyền truy cập** thông qua các **IAM policies**.

### Lưu ý:

* Đảm bảo rằng các thông số cấu hình (Client ID, App ID, Client Secret) được giữ an toàn.
* Hãy luôn sử dụng các kết nối bảo mật (HTTPS) khi giao tiếp với các dịch vụ của AWS và các nhà cung cấp xác thực bên thứ ba.

Nếu bạn cần chi tiết hơn ở bước nào, hoặc gặp vấn đề trong quá trình thực hiện, hãy cho tôi biết nhé!
