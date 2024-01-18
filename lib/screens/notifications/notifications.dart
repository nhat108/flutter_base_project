import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationState createState() => new _NotificationState();
}

class _NotificationState extends State<Notifications> {
  List<String> items = new List.generate(100, (index) => 'Hello $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  Widget renderItem(BuildContext context, dynamic item) {
    return Text(item);
  }
}
