import 'package:flutter/material.dart';
import 'package:test_drive/pages/detail_page.dart';
import 'package:test_drive/pages/home_page.dart';
import 'package:test_drive/pages/login_page.dart';
import 'package:test_drive/pages/sign_up_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
