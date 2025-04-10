import 'package:flutter/material.dart';
import 'package:restaurant/models/dish.dart'; // Import the Dish class
import 'package:restaurant/screens/Suggestion/suggetion_screen.dart'; // Import SuggestionScreen

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Dish> _dishes = [];

  @override
  void initState() {
    super.initState();
    loadDishes(); // Load the dishes when the screen is initialized
  }

  // Method to load dishes
  void loadDishes() async {
    List<Dish> dishes =
        await Dish.loadDishes(); // Assuming you have a loadDishes method
    setState(() {
      _dishes = dishes; // Update the state with loaded dishes
    });
  }

  // Method to navigate to SuggestionScreen
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
      body:
          _dishes.isEmpty
              ? Center(
                child: CircularProgressIndicator(),
              ) // Show loading spinner while loading dishes
              : ListView.builder(
                itemCount: _dishes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Món ăn ${_dishes[index].id}'),
                    subtitle: Text(_dishes[index].ingredients.join(", ")),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToSuggestionScreen, // Navigate to SuggestionScreen
        child: Icon(Icons.search), // Thay đổi biểu tượng ở đây
        tooltip: 'Tìm kiếm món ăn',
      ),
    );
  }
}
