import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/pages/create_page.dart';
import 'package:test_drive/pages/main_page.dart';
import 'package:test_drive/pages/profile_page.dart'; // veya flutter_secure_storage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Seçili index

  // Sayfa listesi
  final List<Widget> _pages = [
    MainPage(),
    CreatePage(),
    ProfilePage(),
  ];

  // Sayfa isimleri
  final List<String> _pageNames = [
    'Dashboard',
    'Create',
    'Profile',
  ];

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.data == true) {
            return Scaffold(
              appBar: AppBar(
                title: Text(_pageNames[_selectedIndex]),
              ),
              body: _pages[_selectedIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Dashboard',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.create),
                    label: 'Create',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text('You need to login first!'),
              ),
            );
          }
        }
      },
    );
  }
}
