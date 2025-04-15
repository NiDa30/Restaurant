import 'package:flutter/material.dart';
import 'package:restaurant/models/dish.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Dish> favorites;
  final Function(Dish)
  onRemoveFavorite; // Callback to remove a dish from favorites

  FavoriteScreen({required this.favorites, required this.onRemoveFavorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Danh sách yêu thích')),
      body:
          favorites.isEmpty
              ? Center(
                child: Text(
                  'Chưa có món yêu thích!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final dish = favorites[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12.0),
                      title: Text(
                        dish.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        'Nguyên liệu: ${dish.ingredients.join(", ")}',
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          // Remove the dish from favorites
                          onRemoveFavorite(dish);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đã xóa "${dish.name}" khỏi yêu thích!',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
