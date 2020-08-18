import 'package:flutter/material.dart';
import 'custom_drawer.dart';
import 'package:pomodoro/screens/new_entry.dart';

//Creates AppBar, EndDrawer and FAB for screens
class TaskScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;

  TaskScaffold({this.appBarTitle, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(child: Text(appBarTitle)),
            actions: <Widget>[
              Builder(builder: (context) =>
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => Scaffold.of(context).openEndDrawer()))]),
        endDrawer: CustomDrawer(),
        body: body,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () { Navigator.pushNamed(context, NewEntryForm.routeName);}
        ));
  }
}
