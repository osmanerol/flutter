import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title:'Flutter',
    home:MyApp()
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation 1'),
      ),
      body: Center(
        child:Column(
          children: [
            Text(
              'Page 1',
              style:TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
            ),
            ElevatedButton(
              child: Text('Page 2'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>SecondRoute())
                );
              },
            )
          ],
        )
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation 2'),
      ),
      body: Center(
        child:Column(
          children: [
            Text(
              'Page 2',
              style:TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
            ),
            ElevatedButton(
              child: Text('Page 1'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        )
      ),
    );
  }
}