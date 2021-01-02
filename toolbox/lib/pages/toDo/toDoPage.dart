import 'package:flutter/material.dart';

class ToDoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Container(
        child: Text('To-Do List'),
      ),
    );
  }
}