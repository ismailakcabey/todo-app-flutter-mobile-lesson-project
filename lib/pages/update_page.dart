import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_drive/components/custom_alert_dialog.dart';
import 'package:test_drive/components/task_status_icon.dart';
import 'package:test_drive/components/task_status_select.dart';
import 'package:test_drive/components/task_status_text.dart';
import 'package:test_drive/database/todo_db.dart';
import 'package:test_drive/database/todo_history_db.dart';
import 'package:test_drive/database/user_db.dart';
import 'package:test_drive/models/task_history_model.dart';
import 'package:test_drive/models/task_model.dart';
import 'package:test_drive/models/user_model.dart';
import 'package:test_drive/enums/task_status_enum.dart'; // TaskStatus enumunu import edin
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePage extends StatefulWidget {
  final int taskId;
  Task? task;

  UpdatePage({required this.taskId, this.task});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
    // initState içinde yapılmak istenen işlemleri burada gerçekleştirin
    // Örneğin, sayfa başlatıldığında belirli bir işlemi gerçekleştirin
    // Bu örnekte, sayfa başlatıldığında task'ın yüklenmesini sağlayabilirsiniz
    loadTaskUpdates();
  }

  final userDB = UserDB();
  final todoDB = TodoDB();
  final todoHistoryDB = TodoHistoryDB();
  int? selectedUserId;
  List<User> users = [];
  Future<void> loadTaskUpdates() async {
    if (widget.task == null) {
      // Eğer task null ise, varsayılan bir task oluşturun
    } else {
      var fetchedUsers = await userDB.fetchAll();
      final userData = await userDB.fetchById(widget.task!.assignedUserId);
      setState(() {
        widget.task = widget.task;
        users = fetchedUsers;
        taskTitleController.text = widget.task!.title;
        taskSummaryController.text = widget.task!.summary;
        selectedStatus = widget.task!.taskStatus == null
            ? widget.task!.taskStatus
            : TaskStatus.backlog;
        selectedUserId = userData.id;
      });
    }
  }

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskSummaryController = TextEditingController();

  TaskStatus selectedStatus = TaskStatus.backlog; // Varsayılan durum ataması
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> update(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJsonFromPrefs = prefs.getString("user");
    Map<String, dynamic> userJson = json.decode(userJsonFromPrefs!);
    await todoDB.update(
        id: widget.task!.id,
        title: taskTitleController.text,
        summary: taskSummaryController.text,
        assignedUserId: selectedUserId,
        taskStatus: selectedStatus == null
            ? TaskStatus.backlog.name
            : selectedStatus.name,
        updatedUserId: userJson["id"]);
    var todos_history_text = "";
    if (widget.task!.summary != taskSummaryController.text) {
      todos_history_text = "changed task summary " +
          widget.task!.summary +
          "->" +
          taskSummaryController.text;
    }
    if (widget.task!.title != taskTitleController.text) {
      todos_history_text = "changed task title " +
          widget.task!.title +
          "->" +
          taskTitleController.text;
    }
    if (widget.task!.taskStatus != selectedStatus) {
      todos_history_text = "changed task status " +
          widget.task!.taskStatus.toString() +
          "->" +
          selectedStatus.toString();
    }
    todoHistoryDB.create(
        createdUserId: userJson["id"],
        description: todos_history_text,
        taskId: widget.task!.id);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Task Success Updated',
          content: ListBody(
            children: <Widget>[
              Text('Task Title: ${taskTitleController.text}'),
              Text('Task Summary: ${taskSummaryController.text}'),
              Text('Assigned User: '),
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
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                taskSummaryController.clear();
                taskTitleController.clear();
                selectedStatus = TaskStatus.backlog;
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
      appBar: AppBar(
        title: Text('Update'),
      ),
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
                      controller: taskTitleController,
                      decoration: InputDecoration(
                        labelText: 'Task Title',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      // `DropdownMenuItem`'ların `value`'sı `int`
                      decoration: InputDecoration(
                          // ... diğer kod
                          ),
                      value: selectedUserId, // `selectedUserId` kullanın
                      onChanged: (newValue) {
                        setState(() {
                          selectedUserId =
                              newValue; // `selectedUserId`'yi güncelleyin
                        });
                      },
                      items: users.isNotEmpty
                          ? users.map<DropdownMenuItem<int>>((User user) {
                              // `value`'yi `int` yapın
                              return DropdownMenuItem<int>(
                                value: user.id, // `User`'ın `id`'sini kullanın
                                child: Text(user.name),
                              );
                            }).toList()
                          : [],
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
                      onPressed: () => update(context),
                      child: Text('Update'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Task History",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: widget.task!.oldActionList!.map((history) {
                  return GestureDetector(
                    onTap: () {
                      // Tıklama işlemleri
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(history.description),
                        subtitle: Text(history.createdAt
                            .toString()), // Örneğin createdAt'i gösteriyorum, sizin için uygun olanı kullanabilirsiniz.
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
