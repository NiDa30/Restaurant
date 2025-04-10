import 'package:flutter/material.dart';
import 'package:restaurant/screens/Manage_recipe/management_screen.dart';
import 'package:restaurant/widgets/recipe_card.dart'; // Giả sử bạn có widget này để hiển thị món ăn
import 'package:restaurant/screens/Manage_recipe/management_screen.dart'; // Giả sử bạn có màn hình quản lý thực đơn
import 'search_screen.dart'; // Màn hình tìm kiếm

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình tương ứng
  static List<Widget> _screens = <Widget>[
    // Màn hình trang chủ (Hiển thị danh sách món ăn)
    ListView(
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
    // Màn hình yêu thích (hiển thị thông báo danh sách yêu thích)
    Center(
      child: Text('⭐ Danh sách yêu thích', style: TextStyle(fontSize: 20)),
    ),
    // Màn hình quản lý thực đơn
    MenuManagementScreen(),
    // Màn hình tìm kiếm
    SearchScreen(),
  ];

  // Cập nhật index khi người dùng chọn tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🍽️ Ứng dụng Món Ăn')),
      body:
          _screens[_selectedIndex], // Hiển thị màn hình dựa trên _selectedIndex
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Quản lý thực đơn',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tìm kiếm'),
        ],
      ),
    );
  }
}
