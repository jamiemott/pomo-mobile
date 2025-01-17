import 'package:flutter/material.dart';
import 'package:pomodoro/screens/new_entry.dart';
import 'package:pomodoro/screens/task_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  SharedPreferences preferences;

  App({Key key, @required this.preferences}) : super(key: key);

  //Routes for all pages that need to be named
  static final routes = {
    NewEntryForm.routeName: (context) => NewEntryForm(),
    TaskListScreen.routeName: (context) => TaskListScreen()
  };

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  ThemeData data;
  SharedPreferences prefs;

  //Function to handle resetting the theme mode
  getTheme() {
    setState(() {
      prefs = this.widget.preferences;
      //Look to see if the key exists, if so, set mode accordingly
      if (prefs.containsKey('_darkOn')){
        data = (prefs.getBool("_darkOn") ?? false) ?
        ThemeData.dark(): ThemeData.light();
      }else {
        //If no key, enter it and set to light mode
        prefs.setBool('_darkOn', false);
        data = ThemeData.light();
      }});
  }

  @override
  void initState() {
    super.initState();
    getTheme();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pomodoro',
        theme: data,
        initialRoute: TaskListScreen.routeName,
        routes: App.routes
    );
  }
}
