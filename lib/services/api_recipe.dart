import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl =
      'http://127.0.0.1:5000'; // Địa chỉ Flask API của bạn

  // Hàm lấy công thức từ Flask
  Future<List<dynamic>> getRecipes() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/load_recipes'));

      if (response.statusCode == 200) {
        // Nếu API trả về thành công, chuyển đổi dữ liệu JSON thành List
        List<dynamic> recipes = json.decode(response.body);
        return recipes;
      } else {
        // Nếu có lỗi từ server
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
