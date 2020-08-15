import 'package:flutter/material.dart';
import 'package:pomodoro/db/database_manager.dart';
import 'package:pomodoro/screens/task_list_screen.dart';
import 'package:pomodoro/widgets/custom_drawer.dart';
import 'package:pomodoro/db/task_dto.dart';

//New Journal Entry form
class NewEntryForm extends StatefulWidget {
  static const routeName = 'newEntry';

  _NewEntryFormState createState() => _NewEntryFormState();
}

class _NewEntryFormState extends State<NewEntryForm> {
  final formKey= GlobalKey<FormState>();
  final newTask = TaskDTO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('New Task Entry')),
            actions: <Widget>[
              Builder(builder: (context) =>
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => Scaffold.of(context).openEndDrawer()))]),
        endDrawer: CustomDrawer(),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: formKey,
                child: SingleChildScrollView(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Task Name', border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.name = value;
                          },
                          validator: (value) {
                            if (value.isEmpty){
                              return 'Please enter a title';
                            } else {
                              return null;
                            }
                          }
                      ),
                      TextFormField(
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'Description', border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.description = value;
                          },
                          validator: (value) {
                            if (value.isEmpty){
                              return 'Please enter a description';
                            } else {
                              return null;
                            }
                          }
                      ),
                      TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: 'Work Time', border: OutlineInputBorder()),
                          onSaved: (value) {
                            newTask.workTime = int.tryParse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty){
                              return 'Please enter a rating';
                            } else {
                              return null;
                            }
                          }
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                                onPressed: () { Navigator.of(context).pop();},
                                child: Text('Cancel')),
                            RaisedButton(
                                color: Colors.red,
                                onPressed: () async {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    newTask.breakTime = 1;
                                    newTask.goal = 20;
                                    newTask.total = 0;
                                    final databaseManager = DatabaseManager.getInstance();
                                    databaseManager.saveTask(newTask: newTask);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => TaskListScreen()));
                                  }
                                },
                                child: Text('SaveEntry'))
                          ]
                      )
                    ])))));
  }
}

//Validation for number. Must be 1-4 to pass
//api.flutter.dev/flutter/dart-core/int/tryParse.html
bool notValid(String value) {
  var num = int.tryParse(value);
  if (num == null) {
    return true;}
  if (num > 4 || num < 1) {
    return true;
  }
  return false;
}