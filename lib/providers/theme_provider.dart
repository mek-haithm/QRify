import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.grey[300],
    scaffoldBackgroundColor: Colors.grey[100],
    cardColor: Colors.grey[200],
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey[900]),
      bodyMedium: TextStyle(color: Colors.grey[700]),
    ),
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[800],
    scaffoldBackgroundColor: Colors.grey[900],
    cardColor: Colors.grey[850],
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey[100]),
      bodyMedium: TextStyle(color: Colors.grey[300]),
    ),
  );
}