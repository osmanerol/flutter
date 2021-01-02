import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/pages/homePage.dart';
import 'package:toolbox/pages/phone/phonePage.dart';
import 'package:toolbox/pages/photo/photoGalleryPage.dart';
import 'package:toolbox/pages/toDo/toDoPage.dart';

void main() {
  runApp( MaterialApp(
      title: 'ToolBox',
      initialRoute: '/',
      routes: {
        '/': (context)=> HomePage(),
        '/phone_list': (context)=> PhonePage(),
        '/photo': (context)=> PhotoGalleryPage(),
        '/toDo': (context)=> ToDoPage(),
      },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}