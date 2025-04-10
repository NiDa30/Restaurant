import 'package:restaurant/models/dish.dart'; // Import mô hình Dish

List<Dish> searchDishesByIngredients(
  List<String> ingredients,
  List<Dish> dishes,
) {
  return dishes.where((dish) {
    // Kiểm tra xem món ăn có chứa tất cả nguyên liệu tìm kiếm không
    return ingredients.every(
      (ingredient) => dish.ingredients.contains(ingredient),
    );
  }).toList();
}
