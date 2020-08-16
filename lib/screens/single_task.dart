import 'package:flutter/material.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/widgets/custom_drawer.dart';
import 'package:pomodoro/widgets/one_task.dart';

//Standalone single entry palge
class SingleTask extends StatelessWidget{
  final Task task;
  SingleTask({Key key, @required this.task}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Task Details')),
            actions: <Widget>[
              Builder(builder: (context) =>
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => Scaffold.of(context).openEndDrawer()))]),
        endDrawer: CustomDrawer(),
        body: OneTask(task: task)
    );
  }
}