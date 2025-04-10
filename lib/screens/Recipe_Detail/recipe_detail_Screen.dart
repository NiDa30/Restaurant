import 'package:flutter/material.dart';

class recipeDetailScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  final List<String> ingredients;
  final String instructions;
  final Map<String, dynamic> nutrition;
  final List<String> relatedRecipes;

  const recipeDetailScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.nutrition,
    required this.relatedRecipes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
            SizedBox(height: 12),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            Text(
              'Nguyên liệu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...ingredients.map(
              (item) => ListTile(leading: Icon(Icons.check), title: Text(item)),
            ),
            SizedBox(height: 16),
            Text(
              'Cách chế biến',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(instructions),
            SizedBox(height: 16),
            Text(
              'Thông tin dinh dưỡng',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Calories: ${nutrition['calories']} kcal"),
            Text("Protein: ${nutrition['protein']} g"),
            Text("Fat: ${nutrition['fat']} g"),
            Text("Carbs: ${nutrition['carbs']} g"),
            SizedBox(height: 16),
            Text(
              'Món ăn liên quan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...relatedRecipes.map((r) => ListTile(title: Text(r))),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Đã lưu vào yêu thích")),
                    );
                  },
                  icon: Icon(Icons.favorite_border),
                  label: Text("Lưu vào yêu thích"),
                ),
                SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Đã thêm vào thực đơn hôm nay")),
                    );
                  },
                  icon: Icon(Icons.playlist_add),
                  label: Text("Thêm vào thực đơn"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
