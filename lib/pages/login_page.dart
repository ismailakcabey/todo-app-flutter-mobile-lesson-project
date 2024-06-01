import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_drive/components/custom_alert_dialog.dart';
import 'package:test_drive/database/user_db.dart';
import 'package:test_drive/models/user_model.dart'; // veya flutter_secure_storage
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userDB = UserDB();
  Future<void> login(BuildContext context) async {
    try {
      String email = emailController.text;
      String password = passwordController.text;
      // Backend'e istek yap, token al
      final alreadyUser = await userDB.fetchByEmail(email);
      if (alreadyUser != null && password == alreadyUser.password) {
        print(alreadyUser);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        User user = alreadyUser;
        print("user:");
        print("${user.email}, ${user.password}");
        final userData = {
          "id": user.id,
          "email": user.email,
          "password": user.password
        };
        String userJson = jsonEncode(userData);
        await prefs.setString("user", userJson);
        await prefs.setString("token", userJson.toString());
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
              title: 'Email or password incorrect',
              content: Text("Email or password incorrect"),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e);
    }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // Form anahtarı oluştur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          200), // Genişliği ve yüksekliği aynı olduğu için 100 verebilirsiniz
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        'https://cdn.dribbble.com/users/158247/screenshots/2388053/media/0a1fbb6bbe12947ca1a84c903777db9b.jpg?resize=400x300&vertical=center',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Email input
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Boşluk ekleyelim
                        // Password input
                        TextFormField(
                          controller: passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            suffixIcon: IconButton(
                              onPressed: togglePasswordVisibility,
                              icon: Icon(_isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight, // Sağa yaslanacak
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signup');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue, // Metin rengini belirle
                                  decoration: TextDecoration
                                      .underline, // Alt çizgi ekleyelim
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => login(context),
                    child: Text('Login'),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
