import 'package:flutter/material.dart';
import 'package:test_drive/components/task_status_icon.dart';
import 'package:test_drive/components/task_status_text.dart';
import 'package:test_drive/database/todo_history_db.dart';
import 'package:test_drive/database/user_db.dart';
import 'package:test_drive/models/task_history_model.dart';
import 'package:test_drive/models/task_model.dart';
import 'package:test_drive/models/user_model.dart';
import 'package:test_drive/enums/task_status_enum.dart'; // TaskStatus enumunu import edin

class DetailPage extends StatefulWidget {
  int taskId;
  Task task;

  DetailPage({required this.taskId, required this.task});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final userDB = UserDB();
  final taskHistoryDB = TodoHistoryDB();
  @override
  void initState() {
    super.initState();
    // initState içinde yapılmak istenen işlemleri burada gerçekleştirin
    // Örneğin, sayfa başlatıldığında belirli bir işlemi gerçekleştirin
    // Bu örnekte, sayfa başlatıldığında task'ın yüklenmesini sağlayabilirsiniz
    loadTaskDetails();
  }

  Future<void> loadTaskDetails() async {
    if (widget.task == null) {
      // Eğer task null ise, varsayılan bir task oluşturun
    } else {
      // Task'ın yaratılan kullanıcısını alın
      final user = await userDB.fetchById(widget.task.createdUserId);
      // Yeni bir Task nesnesi oluşturup, createdUser'ı güncelleyin
      final updatedTask = widget.task;
      updatedTask.createdUser = user;
      var taskHistory = await taskHistoryDB.fetchAll(widget.task!.id);
      print(taskHistory);
      // setState ile task'ı güncelleyin
      setState(() {
        widget.task = updatedTask;
        widget.task.oldActionList = taskHistory;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Burada görsel arayüz oluşturmayı devam ettirin
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Task Status",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              TaskStatusText(
                status: TaskStatus.completed,
                textAlign: TextAlign.start, // Yatayda merkez
                textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              Text(
                "Task Title",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.task!.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Task Summary",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.task!.summary,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Task Created User",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.task.createdUser != null
                    ? widget.task.createdUser!.name
                    : "User not found ${widget.task.createdUser.toString()}",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Task Created Date",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.task!.createdAt.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
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
                        subtitle: Text(
                          history.createdAt.toString(),
                        ), // Örneğin createdAt'i gösteriyorum, sizin için uygun olanı kullanabilirsiniz.
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
