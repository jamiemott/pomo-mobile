import 'package:flutter/material.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/screens/single_task.dart';
import 'package:pomodoro/widgets/one_task.dart';
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
  Task _selectedTask;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (layoutDecider));
  }

  Widget layoutDecider(BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth < 500
        ? verticalLayout()
        : horizontalLayout();
  }

  Widget verticalLayout() {
    return Container(
        child: ListView.builder(
            itemCount: this.widget.taskList.tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                  onTap: () =>
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                        SingleTask(task: this.widget.taskList.tasks[index])))
                  },
                  leading: FlatButton(child: Icon(Icons.play_arrow), color: Colors.greenAccent,
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
                  Text('Total time: ${this.widget.taskList.tasks[index].totalTime}'));
            }));
  }

  Widget horizontalLayout() {
    if (_selectedTask == null){
      _selectedTask = this.widget.taskList.tasks[0];}

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child:
          Container(child:
          ListView.builder(
              itemCount: this.widget.taskList.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () =>
                        setState(() {
                          _selectedTask = this.widget.taskList.tasks[index];
                        }),
                    leading: FlatButton(child: Icon(Icons.play_arrow),
                        color: Colors.greenAccent,
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
                    Text('Total time: ${this.widget.taskList.tasks[index]
                        .totalTime}'));
              }))),
          Expanded(child: Container(child: OneTask(task: _selectedTask)))]
    );
  }
}
