import 'package:flutter/material.dart';
import 'package:pomodoro/db/database_manager.dart';
import 'package:pomodoro/models/task.dart';
import 'package:pomodoro/widgets/tasks_contents.dart';
import 'package:pomodoro/widgets/tasks_scaffold.dart';
import 'package:pomodoro/widgets/welcome.dart';


//Selects which task list screen to display depending on db contents
class TaskListScreen extends StatefulWidget {
  static const routeName = 'tasks';

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  TaskList taskList;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    final databaseManager = DatabaseManager.getInstance();
    List<Task> tasks = await databaseManager.getTasks();
    setState(() {
      taskList = TaskList(tasks: tasks);
    });
  }

  //Display Loading, Welcome or tasks screen depending on state of taskList
  @override
  Widget build(BuildContext context) {
    if (taskList == null) {
      return TaskScaffold(
          appBarTitle: 'Loading Tasks',
          body: Center(child: CircularProgressIndicator())
      );
    } else {
      //Welcome Screen if no entries, TaskList Screen otherwise
      return TaskScaffold(
          appBarTitle: taskList.isEmpty ? 'Welcome' : 'Tasks',
          body: taskList.isEmpty ? WelcomeScreen() : TaskContents(taskList: taskList)
      );
    }
  }
}