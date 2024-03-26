import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // veya flutter_secure_storage

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Future<void> signUp(BuildContext context) async {
    Navigator.pushReplacementNamed(context, '/');
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final List<String> companies = [
    'Apple',
    'Microsoft',
    'Amazon',
    'Tesla',
    'Open AI'
  ];
  String selectedCompany = 'Apple'; // Başlangıçta seçilen şirket
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
        title: Text('SignUp'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Boşluk ekleyelim
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
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Company',
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                          value: selectedCompany,
                          onChanged: (newValue) {
                            // Seçilen şirketi güncelle
                            selectedCompany = newValue!;
                          },
                          items: companies
                              .map<DropdownMenuItem<String>>((String company) {
                            return DropdownMenuItem<String>(
                              value: company,
                              child: Text(company),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight, // Sağa yaslanacak
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, '/');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Sign In",
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
                  )),
              ElevatedButton(
                onPressed: () => signUp(context),
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
