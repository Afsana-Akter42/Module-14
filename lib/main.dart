import 'package:flutter/material.dart';
import 'myApp.dart';

void main() {
  runApp(myApp());
}

Widget myApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: Text("Product App")),
      body: Center(child: Text("Hello!")),
    ),
  );
}
