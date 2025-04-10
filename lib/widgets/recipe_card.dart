import 'package:flutter/material.dart';
import 'package:restaurant/screens/Recipe_Detail/recipe_detail_Screen.dart';

class RecipeCard extends StatelessWidget {
  final String title;
  final String imageUrl; // Thêm thuộc tính cho hình ảnh món ăn

  RecipeCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(
          imageUrl, // Hiển thị hình ảnh từ URL
          width: 50,
          height: 50,
          fit: BoxFit.cover, // Căn chỉnh hình ảnh sao cho phù hợp
        ),
        title: Text(title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => recipeDetailScreen(
                    name: title,
                    imageUrl: imageUrl,
                    description: 'Một món ăn hấp dẫn từ nguyên liệu đặc trưng.',
                    ingredients: ['Nguyên liệu 1', 'Nguyên liệu 2'],
                    instructions:
                        '1. Chuẩn bị nguyên liệu\n2. Nấu chín\n3. Trang trí',
                    nutrition: {
                      'calories': 250,
                      'protein': 10,
                      'fat': 5,
                      'carbs': 30,
                    },
                    relatedRecipes: ['Món liên quan A', 'Món liên quan B'],
                  ),
            ),
          );
        },
      ),
    );
  }
}
