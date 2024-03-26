import 'package:flutter/material.dart';
import 'package:test_drive/components/custom_alert_dialog.dart';
import 'package:test_drive/models/user_model.dart'; // TaskStatus enumunu import edin
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    loadTaskProfiles();
  }

  late User? currentUser;
  Future<void> loadTaskProfiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJsonFromPrefs = prefs.getString("user");

    if (userJsonFromPrefs != null) {
      // JSON dizesini User nesnesine dönüştür
      User retrievedUser = User.fromJson(jsonDecode(userJsonFromPrefs));
      print(retrievedUser.name);
      setState(() {
        currentUser = retrievedUser;
        userEmailController.text = retrievedUser.email;
        userNameController.text = retrievedUser.name;
        selectedCompany = retrievedUser.company;
      });
      // Burada elde edilen User nesnesini kullanabilirsiniz
    }
  }

  final List<String> companies = [
    'Apple',
    'Microsoft',
    'Tesla',
    'Open Ai',
    'Google',
  ];
  late String selectedCompany = "Apple";
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> profile(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Task Success Profiled',
          content: ListBody(
            children: <Widget>[
              Text('User name: ${userNameController.text}'),
              Text('User email: ${userEmailController.text}'),
              Text('User company: ${selectedCompany}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                userEmailController.clear();
                userNameController.clear();
                selectedCompany = "Apple";
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                userEmailController.clear();
                userNameController.clear();
                selectedCompany = "Apple";
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Burada görsel arayüz oluşturmayı devam ettirin
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: userEmailController,
                      decoration: InputDecoration(
                        labelText: 'User Email',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: selectedCompany ?? companies!.first,
                      decoration: InputDecoration(
                        labelText: 'User Company',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCompany = newValue!;
                        });
                      },
                      items: companies
                          .map<DropdownMenuItem<String>>((String company) {
                        return DropdownMenuItem<String>(
                          value: company,
                          child: Text(company),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: () => profile(context),
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
