import 'package:flutter/material.dart';

class CategoryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryItem(title: 'Món chính'),
          CategoryItem(title: 'Món tráng miệng'),
          CategoryItem(title: 'Đồ uống'),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;

  CategoryItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(label: Text(title)),
    );
  }
}
