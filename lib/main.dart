import 'package:flutter/material.dart';
import 'package:pacman/welcomePage.dart';

import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context)=>welcomePage(),
      },
      debugShowCheckedModeBanner: false,
     // home: HomePage(),
    );
  }
}