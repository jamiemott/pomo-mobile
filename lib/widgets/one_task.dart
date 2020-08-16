import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro/models/task.dart';

class OneTask extends StatelessWidget {
  final Task task;

  OneTask({Key key, @required this.task}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${task.name}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            Text('Description: ${task.description}', style: TextStyle(fontSize: 20)),
            Text('Work Time: ${task.workTime} minutes', style: TextStyle(fontStyle: FontStyle.italic)),
            Text('Break Time: ${task.breakTime} minutes', style: TextStyle(fontSize: 15)),
            Text('Goal Time: ${task.goal} minutes', style: TextStyle(fontSize: 15)),
            SizedBox(height: 20),
            graph()
          ],
        ));
  }

  Widget graph() {
    double percent = task.totalTime / task.goal;
    if (percent > 1) { percent = 1;}
    return CircularPercentIndicator(
      radius: 150.0,
      lineWidth: 5.0,
      percent: percent,
      center: Text('${task.totalTime} / ${task.goal}'),
      progressColor: Colors.purpleAccent,
    );
  }

}