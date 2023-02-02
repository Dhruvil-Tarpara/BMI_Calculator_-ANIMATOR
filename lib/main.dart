import 'package:bmi/screens/home_page.dart';
import 'package:bmi/screens/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: "splash",
      routes: {
        "/": (context) => const HomePage(),
        "splash" : (context) => const SplashPage(),
      },
    ),
  );
}
