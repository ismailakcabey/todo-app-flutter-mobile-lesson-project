import 'package:flutter/material.dart';
import 'package:test_drive/components/custom_alert_dialog.dart';
import 'package:test_drive/components/task_status_icon.dart';
import 'package:test_drive/components/task_status_select.dart';
import 'package:test_drive/components/task_status_text.dart';
import 'package:test_drive/models/task_history_model.dart';
import 'package:test_drive/models/task_model.dart';
import 'package:test_drive/models/user_model.dart';
import 'package:test_drive/enums/task_status_enum.dart'; // TaskStatus enumunu import edin

class UpdatePage extends StatefulWidget {
  final String taskId;
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

  void loadTaskUpdates() {
    // Burada task detaylarının yüklenmesi işlemini gerçekleştirin
    // Örneğin, bir API'den task detaylarını alabilirsiniz
    // Bu örnekte, mevcut task verisini kullanacağız
    if (widget.task == null) {
      // Eğer task null ise, yükleme yapın
      // Örneğin, widget.task'i bir API'den alınan veri ile doldurun
      // Bu örnekte, varsayılan olarak örnek bir task oluşturacağız
      setState(() {
        widget.task = Task(
          id: '1',
          createdUserId: '3',
          taskStatus: TaskStatus.completed,
          oldActionList: [
            TaskHistory(
                id: "1",
                creadUserId: "1",
                createdAt: DateTime(2024, 3, 25, 9, 0),
                updatedAt: DateTime(2024, 3, 25, 9, 0),
                description: "İsmail Akça changed status1"),
            TaskHistory(
                id: "1",
                creadUserId: "1",
                createdAt: DateTime(2024, 3, 25, 9, 0),
                updatedAt: DateTime(2024, 3, 25, 9, 0),
                description: "İsmail Akça changed status12"),
            TaskHistory(
                id: "1",
                creadUserId: "1",
                createdAt: DateTime(2024, 3, 25, 9, 0),
                updatedAt: DateTime(2024, 3, 25, 9, 0),
                description: "İsmail Akça changed status123"),
            TaskHistory(
                id: "1",
                creadUserId: "1",
                createdAt: DateTime(2024, 3, 25, 9, 0),
                updatedAt: DateTime(2024, 3, 25, 9, 0),
                description: "İsmail Akça changed status1234")
          ],
          updatedUserId: '2',
          createdUser: User(
              id: "1",
              name: "ismail akca",
              email: "ismailakca399@gmail.com",
              password: "123",
              company: "Apple",
              createdAt: DateTime(2024, 3, 25, 10, 15),
              updatedAt: DateTime(2024, 3, 25, 10, 15)),
          updatedUser: User(
              id: "1",
              name: "metin yilmaz",
              email: "metinyilmaz@gmail.com",
              password: "123",
              company: "Apple",
              createdAt: DateTime(2024, 3, 25, 10, 15),
              updatedAt: DateTime(2024, 3, 25, 10, 15)),
          title: 'Meeting Agenda Preparation',
          summary: 'Prepare agenda for the upcoming team meeting.',
          createdAt: DateTime(2024, 3, 25, 9, 0),
          updatedAt: DateTime(2024, 3, 25, 10, 30),
        );
      });
    } else {
      print(widget!.task!.title);
      print(widget!.task!.summary);
      print(widget!.task!.assignedUser!.name);
      setState(() {
        taskTitleController.text = widget.task!.title;
        taskSummaryController.text = widget.task!.summary;
        selectedUser = widget.task!.assignedUser!
            .name; // Varsayılan atama, görevdeki atanmış kullanıcıya
        selectedStatus =
            widget.task!.taskStatus; // Varsayılan atama, görevin durumuna
      });
    }
  }

  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskSummaryController = TextEditingController();
  final List<String> users = [
    'ismail akca',
    'Ahmet Çetin',
    'Mert aslan',
    'Elon Musk'
  ];

  TaskStatus selectedStatus = TaskStatus.backlog; // Varsayılan durum ataması
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String selectedUser;
  Future<void> update(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: 'Task Success Updated',
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
                selectedUser = "";
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                taskSummaryController.clear();
                taskTitleController.clear();
                selectedStatus = TaskStatus.backlog;
                selectedUser = "";
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
                    DropdownButtonFormField<String>(
                      value: selectedUser ?? users!.first,
                      decoration: InputDecoration(
                        labelText: 'Assigned User',
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedUser = newValue!;
                        });
                      },
                      items: users.map<DropdownMenuItem<String>>((String user) {
                        return DropdownMenuItem<String>(
                          value: user,
                          child: Text(user),
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
                children: widget.task!.oldActionList.map((history) {
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
