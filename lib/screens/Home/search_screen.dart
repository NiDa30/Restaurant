import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:restaurant/models/dish.dart';
import 'package:restaurant/screens/Suggestion/suggetion_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Dish> _dishes = [];
  List<Dish> _filteredDishes = [];
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    loadDishes();
  }

  // Load dishes từ file JSON (assets/data/test.json)
  Future<void> loadDishes() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/test.json');
      List<dynamic> jsonResponse = json.decode(jsonString);
      List<Dish> loadedDishes =
          jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
      setState(() {
        _dishes = loadedDishes;
        _filteredDishes = loadedDishes; // Ban đầu, hiển thị toàn bộ
      });
    } catch (e) {
      print("Lỗi khi tải dữ liệu món ăn: $e");
    }
  }

  // Hàm cập nhật bộ lọc dựa trên từ khóa tìm kiếm
  void _filterDishes(String query) {
    query = query.toLowerCase();
    setState(() {
      _searchQuery = query;
      _filteredDishes =
          _dishes.where((dish) {
            // Kiểm tra nếu tên món chứa từ khóa hoặc bất kỳ nguyên liệu nào chứa từ khóa.
            bool matchesName = dish.name.toLowerCase().contains(query);
            bool matchesIngredient = dish.ingredients.any(
              (ing) => ing.toLowerCase().contains(query),
            );
            return matchesName || matchesIngredient;
          }).toList();
    });
  }

  // Hàm điều hướng đến SuggestionScreen nếu cần (ví dụ khi bấm FloatingActionButton)
  void navigateToSuggestionScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuggestionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tìm kiếm món ăn')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterDishes,
              decoration: InputDecoration(
                labelText: 'Nhập từ khóa (tên món hoặc nguyên liệu)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child:
                _filteredDishes.isEmpty
                    ? Center(
                      child: Text('Không tìm thấy món nào cho "$_searchQuery"'),
                    )
                    : ListView.builder(
                      itemCount: _filteredDishes.length,
                      itemBuilder: (context, index) {
                        var dish = _filteredDishes[index];
                        return ListTile(
                          leading: Icon(Icons.food_bank),
                          title: Text(dish.name),
                          subtitle: Text(
                            'Nguyên liệu: ${dish.ingredients.join(", ")}',
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: navigateToSuggestionScreen,
      //   child: Icon(Icons.search),
      //   tooltip: 'Gợi ý món ăn',
      // ),
    );
  }
}
