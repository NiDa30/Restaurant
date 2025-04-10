import 'package:flutter/material.dart';
import 'package:restaurant/services/auth_services.dart'; // Dịch vụ đăng ký

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng Ký')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Xử lý đăng ký ở đây
                Navigator.pop(context); // Quay lại màn hình đăng nhập
              },
              child: Text('Đăng ký'),
            ),
          ],
        ),
      ),
    );
  }
}
