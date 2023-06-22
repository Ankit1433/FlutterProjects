
import 'package:flutter/material.dart';
import 'splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light, // Default light theme
        // Define your light theme properties here
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark, // Dark theme
        // Define your dark theme properties here
      ),
      debugShowCheckedModeBanner: false,
      title: 'Covid App',
      // theme: ThemeData(appBarTheme: AppBarTheme(color:Colors.black),),

      home: splashScreen(),
    );
  }
}

