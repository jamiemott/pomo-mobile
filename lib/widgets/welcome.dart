import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding( padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Please add a task', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            //Expanded(child: Image.asset('assets/images/writing.jpg'))
          ],
        )),
    );
  }
}