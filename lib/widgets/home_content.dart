import 'package:flutter/material.dart';
import 'package:restaurant/widgets/recipe_card.dart';
import 'package:restaurant/widgets/categogy.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CategoryMenu(), // Danh mục món ăn
        Expanded(
          child: ListView(
            children: <Widget>[
              RecipeCard(
                title: 'Món 1',
                imageUrl:
                    "https://th.bing.com/th/id/OIP.1DOqNqfjliekww-HoZsReQHaEc?w=297&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7",
              ),
              RecipeCard(
                title: 'Món 2',
                imageUrl:
                    "https://th.bing.com/th/id/OIP.l-iaKULBjlfwBvXQFsUv6wHaEK?w=329&h=185&c=7&r=0&o=5&dpr=1.3&pid=1.7",
              ),
              RecipeCard(
                title: 'Món 3',
                imageUrl:
                    "https://th.bing.com/th/id/OIP.-fUduplh0i_7bk8W0cJurgHaHa?w=187&h=187&c=7&r=0&o=5&dpr=1.3&pid=1.7",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
