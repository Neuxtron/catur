import 'package:catur/homepage.dart';
import 'package:catur/loading.dart';
import 'package:catur/mainboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainBoard(),
      theme: ThemeData(backgroundColor: Colors.blueGrey[400]),
      debugShowCheckedModeBanner: false,
    );
  }
}
