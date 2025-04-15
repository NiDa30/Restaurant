import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:restaurant/models/dish.dart';
import 'package:restaurant/screens/favorite/favorite_screen.dart';

class SuggestionScreen extends StatefulWidget {
  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  String? selectedCuisine;
  String? selectedIngredient;
  List<Dish> dishes = [];
  List<Dish> menu = [];
  List<Dish> favorites = [];

  @override
  void initState() {
    super.initState();
    loadDishes();
  }

  Future<void> loadDishes() async {
    try {
      String jsonString = await rootBundle.loadString('assets/data/test.json');
      List<dynamic> jsonResponse = json.decode(jsonString);
      List<Dish> loadedDishes =
          jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
      setState(() {
        dishes = loadedDishes;
      });
    } catch (e) {
      print("Lỗi khi tải dữ liệu món ăn: $e");
    }
  }

  List<Dish> getSuggestedDishes() {
    return dishes.where((dish) {
      bool matchesCuisine =
          selectedCuisine == null || dish.cuisine == selectedCuisine;
      bool matchesIngredient =
          selectedIngredient == null ||
          dish.ingredients.contains(selectedIngredient!);
      return matchesCuisine && matchesIngredient;
    }).toList();
  }

  void addToMenu(Dish dish) {
    setState(() {
      if (!menu.contains(dish)) {
        menu.add(dish);
      }
      if (!favorites.contains(dish)) {
        favorites.add(dish);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đã thêm "${dish.name}" vào thực đơn và danh sách yêu thích!',
        ),
      ),
    );
  }

  void addToFavorites(Dish dish) {
    setState(() {
      if (!favorites.contains(dish)) {
        favorites.add(dish);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã thêm "${dish.name}" vào danh sách yêu thích!'),
      ),
    );
  }

  void showMenuDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Thực đơn của bạn'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: menu.map((dish) => Text('• ${dish.name}')).toList(),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Đóng'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  void showFavoritesDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Danh sách yêu thích'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children:
                    favorites.map((dish) => Text('• ${dish.name}')).toList(),
              ),
            ),
            actions: [
              TextButton(
                child: Text('Đóng'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gợi ý món ăn theo sở thích'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            tooltip: 'Danh sách yêu thích',
            onPressed: showFavoritesDialog,
          ),
          IconButton(
            icon: Icon(Icons.menu_book),
            tooltip: 'Thực đơn',
            onPressed: showMenuDialog,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCuisine,
              hint: Row(
                children: [
                  Icon(Icons.fastfood),
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
                  Icon(Icons.restaurant),
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
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.food_bank),
                    title: Text(dish.name),
                    subtitle: Text(
                      'Nguyên liệu: ${dish.ingredients.join(", ")} - ${dish.cuisine}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => addToMenu(dish),
                          tooltip: 'Thêm vào thực đơn',
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite),
                          tooltip: 'Thêm vào danh sách yêu thích',
                          onPressed: () => addToFavorites(dish),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Thực đơn (${menu.length})',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích (${favorites.length})',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            showMenuDialog();
          } else if (index == 1) {
            showFavoritesDialog();
          }
        },
      ),
    );
  }
}
