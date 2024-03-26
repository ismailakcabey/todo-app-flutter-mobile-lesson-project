import 'package:flutter/material.dart';
import 'package:test_drive/components/task_status_icon.dart';
import 'package:test_drive/components/task_status_text.dart';
import 'package:test_drive/models/task_history_model.dart';
import 'package:test_drive/models/task_model.dart';
import 'package:test_drive/models/user_model.dart';
import 'package:test_drive/enums/task_status_enum.dart'; // TaskStatus enumunu import edin

class DetailPage extends StatefulWidget {
  final String taskId;
  Task? task;

  DetailPage({required this.taskId, this.task});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    // initState içinde yapılmak istenen işlemleri burada gerçekleştirin
    // Örneğin, sayfa başlatıldığında belirli bir işlemi gerçekleştirin
    // Bu örnekte, sayfa başlatıldığında task'ın yüklenmesini sağlayabilirsiniz
    loadTaskDetails();
  }

  void loadTaskDetails() {
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
                widget.task!.createdUser!.name,
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
