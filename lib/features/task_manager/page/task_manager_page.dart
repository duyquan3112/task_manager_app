import 'package:flutter/material.dart';
import 'package:task_manager_app/common/colors.dart';
import 'package:task_manager_app/common/styles.dart';

class TaskManagerPage extends StatefulWidget {
  const TaskManagerPage({super.key});

  @override
  State<TaskManagerPage> createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page",
          style: UITextStyle.bold.copyWith(
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
