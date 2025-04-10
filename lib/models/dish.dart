import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle

class Dish {
  final int id;
  final List<String> ingredients;
  final String imageUrl;
  final String description;

  Dish({
    required this.id,
    required this.ingredients,
    this.imageUrl = "",
    this.description = "",
  });

  static Future<List<Dish>> loadDishes() async {
    String jsonString = await rootBundle.loadString('assets/data/test.json');
    List<dynamic> jsonResponse = json.decode(jsonString);
    return jsonResponse.map((dish) => Dish.fromJson(dish)).toList();
  }

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      id: json['id'],
      ingredients: List<String>.from(json['ingredients']),
      imageUrl: json['imageUrl'] ?? "",
      description: json['description'] ?? "",
    );
  }
}
