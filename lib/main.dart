import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/provider/product_provider.dart';
import 'package:task/view/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MaterialApp(
        home:  HomeScreen(),
      ),
    );
  }
}

