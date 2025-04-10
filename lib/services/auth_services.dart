import 'package:restaurant/databases/DatabaseHelper.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    // Lấy người dùng từ cơ sở dữ liệu
    final users = await DatabaseHelper.instance.getUserByUsername(username);

    if (users.isEmpty) {
      return false; // Tên đăng nhập không tồn tại
    } else {
      // Kiểm tra mật khẩu
      if (users[0]['password'] == password) {
        return true; // Mật khẩu đúng
      } else {
        return false; // Mật khẩu sai
      }
    }
  }

  Future<void> register(String username, String password) async {
    // Thêm người dùng vào cơ sở dữ liệu
    await DatabaseHelper.instance.insertUser(username, password);
  }

  Future<void> updatePassword(int id, String newPassword) async {
    // Cập nhật mật khẩu
    await DatabaseHelper.instance.updateUserPassword(id, newPassword);
  }
}
