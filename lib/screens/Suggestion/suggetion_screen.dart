import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle
import 'package:restaurant/models/dish.dart'; // Import model Dish
import 'dart:convert';

class SuggestionScreen extends StatefulWidget {
  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  // Các lựa chọn sở thích của người dùng
  String? selectedCuisine; // Loại món ăn (Ẩm thực)
  String? selectedIngredient; // Nguyên liệu yêu thích
  List<Dish> dishes = []; // Danh sách món ăn đã tải

  @override
  void initState() {
    super.initState();
    loadDishes(); // Tải danh sách món ăn khi mở màn hình
  }

  // Tải món ăn từ file JSON hoặc API
  Future<void> loadDishes() async {
    // Đọc tệp JSON từ assets
    String jsonString = await rootBundle.loadString('assets/data/test.json');

    // Chuyển đổi chuỗi JSON thành danh sách các món ăn
    List<dynamic> jsonResponse = json.decode(jsonString);

    // Tạo danh sách các món ăn từ JSON
    List<Dish> loadedDishes =
        jsonResponse.map((dish) => Dish.fromJson(dish)).toList();

    setState(() {
      dishes = loadedDishes; // Cập nhật danh sách món ăn
    });
  }

  // Lọc món ăn dựa trên sở thích của người dùng
  List<Dish> getSuggestedDishes() {
    return dishes.where((dish) {
      bool matchesCuisine =
          selectedCuisine == null ||
          dish.ingredients.contains(selectedCuisine!);
      bool matchesIngredient =
          selectedIngredient == null ||
          dish.ingredients.contains(selectedIngredient!);
      return matchesCuisine && matchesIngredient;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gợi ý theo sở thích'),
        leading: Icon(Icons.menu), // Biểu tượng menu
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCuisine,
              hint: Row(
                children: [
                  Icon(Icons.fastfood), // Biểu tượng món ăn
                  SizedBox(width: 8),
                  Text('Chọn loại món ăn'),
                ],
              ),
              items:
                  ['Món Á', 'Món Âu', 'Món Chay'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCuisine = newValue;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedIngredient,
              hint: Row(
                children: [
                  Icon(Icons.restaurant), // Biểu tượng nguyên liệu
                  SizedBox(width: 8),
                  Text('Chọn nguyên liệu yêu thích'),
                ],
              ),
              items:
                  ['Gà', 'Thịt bò', 'Cá', 'Rau xanh'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedIngredient = newValue;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getSuggestedDishes().length,
              itemBuilder: (context, index) {
                var dish = getSuggestedDishes()[index];
                return ListTile(
                  leading: Icon(Icons.food_bank), // Biểu tượng món ăn
                  title: Text('Món ăn ${dish.id}'),
                  subtitle: Text(dish.ingredients.join(", ")),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
