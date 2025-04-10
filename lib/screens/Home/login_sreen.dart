import 'package:flutter/material.dart';
import 'package:restaurant/services/auth_services.dart'; // Dịch vụ đăng nhập

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Đăng Nhập')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Tên đăng nhập',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Mật khẩu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Text('Đăng nhập'),
                ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/register',
                ); // Điều hướng đến màn hình đăng ký
              },
              child: Text('Chưa có tài khoản? Đăng ký'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/search',
                ); // Điều hướng đến màn hình tìm kiếm
              },
              child: Text('Tìm kiếm món ăn'),
            ),
          ],
        ),
      ),
    );
  }
}
