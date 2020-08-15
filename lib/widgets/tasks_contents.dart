import 'package:flutter/material.dart';
import 'package:pomodoro/models/task.dart';

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
    return LayoutBuilder(builder: (layoutDecider));
  }

  Widget layoutDecider(BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth < 500
        ? verticalLayout()
        : horizontalLayout();
  }

  Widget verticalLayout() {
    return Container(child: ListView.builder(
        itemCount: this.widget.taskList.tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text('${this.widget.taskList.tasks[index].name}'),
              subtitle: Text('${this.widget.taskList.tasks[index].description}'));
        }));
  }

  Widget horizontalLayout() {
    if (_selectedEntry == null){
      _selectedEntry = this.widget.taskList.tasks[0];}

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child:
          Container(child:
          ListView.builder(
              itemCount: this.widget.taskList.tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                    onTap: () => setState(() {
                      _selectedEntry = this.widget.taskList.tasks[index];
                    }),
                    title: Text('${this.widget.taskList.tasks[index].name}'),
                    subtitle: Text('${this.widget.taskList.tasks[index].description}'));})
          )),
          //Expanded(child: Container(child: OneEntry(entry: _selectedEntry)))]
    ]);
  }
}
