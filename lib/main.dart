import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyek_prak/views/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/boxes.dart';
import 'models/recipes.dart';

void main() async {
  Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<Item>(HiveBoxes.recipes);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Recipes',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: LoginPage(),
    );
  }
}