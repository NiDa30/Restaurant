import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle
import 'package:restaurant/models/dish.dart'; // Import model Dish
import 'dart:convert';
import 'package:restaurant/screens/Suggestion/Suggetion_screen.dart';

class _SuggestionScreenState extends State<SuggestionScreen> {
  String? selectedCuisine;
  String? selectedIngredient;
  List<Dish> dishes = [];
  List<Dish> menu = []; // List to hold the selected dishes

  @override
  void initState() {
    super.initState();
    loadDishes();
  }

  Future<void> loadDishes() async {
    String jsonString = await rootBundle.loadString('assets/data/test.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    List<Dish> loadedDishes =
        jsonResponse.map((dish) => Dish.fromJson(dish)).toList();

    setState(() {
      dishes = loadedDishes;
    });
  }

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

  void addToMenu(Dish dish) {
    setState(() {
      menu.add(dish);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Món ăn đã được thêm vào thực đơn!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gợi ý theo sở thích')),
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
                    // leading: Image.asset(dish.imageUrl, width: 50, height: 50),
                    title: Text('Món ăn ${dish.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(dish.description),
                        Text('Nguyên liệu: ${dish.ingredients.join(", ")}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => addToMenu(dish),
                      tooltip: 'Thêm vào thực đơn',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
