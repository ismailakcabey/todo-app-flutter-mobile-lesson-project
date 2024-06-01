import 'package:flutter/material.dart';
import 'package:test_drive/components/custom_alert_dialog.dart';
import 'package:test_drive/components/task_status_select.dart';
import 'package:test_drive/database/todo_db.dart';
import 'package:test_drive/database/user_db.dart';
import 'package:test_drive/enums/task_status_enum.dart';
import 'package:test_drive/models/user_model.dart';
import 'package:test_drive/pages/home_page.dart';
import 'package:test_drive/pages/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskSummaryController = TextEditingController();
  List<User> users = [];
  TaskStatus selectedStatus = TaskStatus.backlog; // Varsayılan durum ataması
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late User? selectedUser;
  final todoDB = TodoDB();
  final userDB = UserDB();
  @override
  void initState() {
    super.initState();
    fetchUsers(); // Kullanıcıları yükle
  }

  Future<void> fetchUsers() async {
    var fetchedUsers = await userDB.fetchAll();
    setState(() {
      users = fetchedUsers.map<User>((user) => user).toList();
      selectedUser = users[0];
    });
  }

  Future<void> create(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJsonFromPrefs = prefs.getString("user");
    Map<String, dynamic> userJson = json.decode(userJsonFromPrefs!);
    await todoDB.create(
        title: taskTitleController.text,
        summary: taskSummaryController.text,
        taskStatus: selectedStatus.name,
        createdUserId: userJson["id"],
        assignedUserId: selectedUser!.id);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'New Task Success Added',
          content: ListBody(
            children: <Widget>[
              Text('Task Title: ${taskTitleController.text}'),
              Text('Task Summary: ${taskSummaryController.text}'),
              Text(
                  'Assigned User: ${users.firstWhere((user) => user == selectedUser)}'),
              Text('Task Status: $selectedStatus'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                taskSummaryController.clear();
                taskTitleController.clear();
                selectedStatus = TaskStatus.backlog;
                selectedUser = null;
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                taskSummaryController.clear();
                taskTitleController.clear();
                selectedStatus = TaskStatus.backlog;
                selectedUser = null;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
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
                  SizedBox(height: 10),
                  TextFormField(
                    controller: taskTitleController,
                    decoration: InputDecoration(
                      labelText: 'Task Title',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: taskSummaryController,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 7,
                    decoration: InputDecoration(
                      labelText: 'Task Summary',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonFormField<User>(
                    decoration: InputDecoration(
                      labelText: 'Assigned User',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    value: selectedUser, // Varsayılan seçili kullanıcı
                    onChanged: (newValue) {
                      setState(() {
                        selectedUser = newValue!;
                      });
                    },
                    items: users.map<DropdownMenuItem<User>>((User user) {
                      return DropdownMenuItem<User>(
                        value: user,
                        child: Text(user.name), // Kullanıcının adını göster
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  TaskStatusDropdown(
                    selectedStatus: selectedStatus,
                    onChanged: (newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => create(context),
                    child: Text('Create'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
