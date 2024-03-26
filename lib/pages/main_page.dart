import 'package:flutter/material.dart';
import 'package:test_drive/components/task_status_icon.dart';
import 'package:test_drive/models/task_model.dart';
import 'package:test_drive/mock/task_data.dart';
import 'package:test_drive/pages/detail_page.dart';
import 'package:test_drive/pages/update_page.dart';
import 'package:shared_preferences/shared_preferences.dart'; // veya flutter_secure_storage

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Search Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    Task task = tasks[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(taskId: task.id, task: task),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: TaskStatusIcon(task.taskStatus),
                          title: Text(task.title),
                          subtitle: Text(task.summary.length > 30
                              ? task.summary.substring(0, 30) + '...'
                              : task.summary),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      UpdatePage(taskId: task.id, task: task),
                                ),
                              );
                              print("edit: " + task.id);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
