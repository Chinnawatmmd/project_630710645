import 'package:flutter/material.dart';
import 'package:project_630710645/pages/addCardPage.dart';
import 'package:project_630710645/pages/home.dart';
import 'package:project_630710645/pages/review.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //home: ReviewPage(),
    );
  }
}
