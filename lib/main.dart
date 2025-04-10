import 'package:flutter/material.dart';
import 'package:restaurant/screens/Home/home_screen.dart'; // Home screen after login
import 'package:restaurant/screens/Home/login_sreen.dart'; // Login screen
import 'package:restaurant/screens/Home/register_screen.dart'; // Register screen
import 'package:restaurant/screens/Home/search_screen.dart'; // Search screen for dishes
import 'package:restaurant/screens/Suggestion/suggetion_screen.dart'; // Suggestion screen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // Default route set to the login screen
      routes: {
        '/login': (context) => LoginScreen(), // Login screen route
        '/register': (context) => RegisterScreen(), // Register screen route
        '/home': (context) => HomeScreen(), // After successful login
        '/search':
            (context) => SearchScreen(), // Search screen for searching dishes
        '/suggestion':
            (context) =>
                SuggestionScreen(), // Suggestion screen for dish suggestions
      },
    );
  }
}
