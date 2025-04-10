import 'package:flutter/material.dart';

class MenuManagementScreen extends StatefulWidget {
  @override
  _MenuManagementScreenState createState() => _MenuManagementScreenState();
}

class _MenuManagementScreenState extends State<MenuManagementScreen> {
  List<String> favoriteDishes = [
    'Cơm gà',
    'Phở bò',
    'Bún chả',
  ]; // Danh sách yêu thích mẫu
  Map<String, List<String>> weeklyMenu = {
    'Thứ 2': [],
    'Thứ 3': [],
    'Thứ 4': [],
    'Thứ 5': [],
    'Thứ 6': [],
    'Thứ 7': [],
    'Chủ nhật': [],
  };

  List<Map<String, dynamic>> historyMenus = [];

  void _addToMenu(String day, String dish) {
    setState(() {
      weeklyMenu[day]?.add(dish);
    });
  }

  void _saveMenu() {
    setState(() {
      historyMenus.add({'date': DateTime.now(), 'menu': Map.from(weeklyMenu)});
      // Reset menu sau khi lưu
      weeklyMenu.updateAll((key, value) => []);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('📝 Quản lý thực đơn')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '❤️ Danh sách yêu thích',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8,
                children:
                    favoriteDishes
                        .map((dish) => Chip(label: Text(dish)))
                        .toList(),
              ),
              SizedBox(height: 20),
              Text(
                '📆 Tạo thực đơn theo tuần',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...weeklyMenu.entries.map((entry) {
                return ExpansionTile(
                  title: Text(entry.key),
                  children: [
                    ...entry.value.map((dish) => ListTile(title: Text(dish))),
                    DropdownButton<String>(
                      hint: Text('Chọn món từ yêu thích'),
                      items:
                          favoriteDishes.map((dish) {
                            return DropdownMenuItem<String>(
                              value: dish,
                              child: Text(dish),
                            );
                          }).toList(),
                      onChanged: (selectedDish) {
                        if (selectedDish != null) {
                          _addToMenu(entry.key, selectedDish);
                        }
                      },
                    ),
                  ],
                );
              }).toList(),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _saveMenu,
                child: Text('💾 Lưu thực đơn tuần này'),
              ),
              Divider(height: 30),
              Text(
                '🕘 Lịch sử thực đơn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...historyMenus.map((menuData) {
                final date = (menuData['date'] as DateTime);
                final formattedDate = '${date.day}/${date.month}/${date.year}';
                final menu = menuData['menu'] as Map<String, List<String>>;
                return ExpansionTile(
                  title: Text('Thực đơn: $formattedDate'),
                  children:
                      menu.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${entry.key}:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              ...entry.value.map((dish) => Text('- $dish')),
                            ],
                          ),
                        );
                      }).toList(),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
