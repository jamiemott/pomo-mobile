import 'package:flutter/material.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/screens/timer_screen.dart';

//Code based on class material and from:
//https://iiro.dev/2018/01/28/implementing-adaptive-master-detail-layouts/
class TaskContents extends StatefulWidget {
  final TaskList taskList;

  TaskContents({Key key, @required this.taskList}) : super(key: key);

  @override
  _TaskContentsState createState() => _TaskContentsState();
}

class _TaskContentsState extends State<TaskContents> {
  Task _selectedEntry;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            itemCount: this.widget.taskList.tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: FlatButton(child: Icon(Icons.play_arrow),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              TimerScreen(task: this.widget.taskList
                                  .tasks[index])),
                        );
                        setState(() => {});
                      }),
                  title: Text('${this.widget.taskList.tasks[index].name}'),
                  subtitle:
                  Text('${this.widget.taskList.tasks[index].description}'));
            }));
  }

}