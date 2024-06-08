## To do App

## 💡 Các chức năng

- [x] Đăng nhập và đăng kí, đăng xuất bằng email và mật khẩu
- [x] Tạo công việc với thời gian, ưu tiên, hạng
- [x] Sửa công việc
- [x] Xóa công việc
- [x] Hiển thị công việc lên màn hình

## Cách cài đặt

1. Clone this repo:
   ```bash
   git clone https://github.com/nguyendat0908/ToDoApp_flutter.git
   ```

2. Mở thư mục dự án này bằng **VS Code**:
   ```bash
   code flutter_docker
   ```

3.
```bash
flutter upgrade
```

4.
```bash
flutter pub get
```

5.
```bash
flutter run
```

### Cấu trúc mã
>- |--lib
   >    - |-- app
          >      - |-- app_cubit.dart (sử dụng Flutter Bloc, quản lý trạng thái xác thực (authentication) của ứng dụng.)
          >      - |-- app_state.dart (Bloc để quản lý trạng thái xác thực)
   >    - |-- domains
          >       - |-- data_sources
                              > - |-- firebase_auth_service.dart (quản lý xác thực người dùng qua Firebase)
          >       - |-- user
                              > - |-- user_entity.dart (lưu trữ dữ liệu người dùng)
          >       - |-- authentication_repository.dart (Xác định thay đổi trạng thái xác thực)
   >    - |-- entities
          >    - |-- category_realm_enity.dart (dữ liệu sử dụng reaml)
          >    - |-- category_realm_enity.realm.dart
   >    - |-- firestore
          >      - |-- todo_firestore (class thực hiện giao tiếp trực tiếp với firestore)
   >    - |-- models
          >      - |-- category_models.dart (dữ liệu để lưu trữ lên reaml)
          >      - |-- todo_models.dart (dữ liệu để lưu trữ lên firestore)
   >    - |-- ui
          >      - |-- category
                >        - |-- category_list_page.dart (màn hình hiển thị danh sách thư mục)
                >        - |-- category_or_edit_page (màn hình hiển thị danh sách thư mục)
          >      - |-- index
                >        - |-- index_page (màn hình hiển thị công việc)
          >      - |-- login
                >        - |-- bloc (quản lý trạng thái login)
                           >         - |-- login_cubit.dart
                           >         - |-- login_state.dart
                >        - |-- login_page.dart (màn hình login)
          >      - |-- main
                >        - |-- main_page (những màn hình hiển thị chính)
          >      - |-- onboarding (màn hình mới vào app)
                >        - |-- onboarding_child_page.dart
                >        - |-- onboarding_page_view.dart
          >      - |-- register
                >        - |-- bloc (quản lý trạng thái register)
                            >         - |-- register_cubit.dart
                            >         - |-- register_state.dart
                >        - |-- register_page.dart (màn hình đăng ký)
          >      - |-- splash
                >        - |-- splash_page.dart (màn hình đầu tiên)
          >      - |-- task
                >        - |-- create_task_page.dart (màn hình tạo nhiệm vụ)
          >      - |-- task_priority
                >        - |-- task_priority_list_page.dart (màn hình tạo độ ưu tiên)
          >      - |-- welcom
                >        - |-- welcom_page.dart (màn hình welcom)
   >    - |-- ultils
                >      - |-- enums
                            >       - |-- authentication_status.dart (trạng thái của đăng nhập)
                            >       - |-- color_extention.dart (chuyển đổi mã màu)
                            >       - |-- onboarding_page_position.dart (định nghĩa màn hình)
   >    - |-- firebase_options.dart
   >    - |-- main.dart



