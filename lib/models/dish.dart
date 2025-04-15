import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle

class Dish {
  final int id;
  final List<String> ingredients;
  final String imageUrl;
  final String description;
  final String name; // Thêm thuộc tính name (tên món ăn)
  final String cuisine; // Thêm thuộc tính cuisine (loại món ăn)

  Dish({
    required this.id,
    required this.ingredients,
    required this.name, // Khởi tạo name
    required this.cuisine, // Khởi tạo cuisine
    this.imageUrl = "",
    this.description = "",
  });

  // Phương thức tải món ăn từ tệp JSON
  static Future<List<Dish>> loadDishes() async {
    try {
      // Đọc tệp JSON từ assets
      String jsonString = await rootBundle.loadString('assets/data/test.json');

      // Giải mã chuỗi JSON thành một danh sách
      List<dynamic> jsonResponse = json.decode(jsonString);

      // Chuyển đổi dữ liệu từ JSON thành các đối tượng Dish
      return jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
    } catch (e) {
      // Xử lý lỗi khi không thể tải hoặc giải mã tệp JSON
      print('Error loading dishes: $e');
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }

  // Factory constructor để tạo đối tượng Dish từ JSON
  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      ingredients: List<String>.from(json['ingredients'] ?? []),
      name: json['name'] ?? "Unknown", // Thêm tên món ăn từ JSON
      cuisine: json['cuisine'] ?? "Unknown", // Thêm loại món ăn từ JSON
      imageUrl: json['imageUrl'] ?? "",
      description: json['description'] ?? "",
    );
  }
}
