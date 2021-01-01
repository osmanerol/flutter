import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tutorials',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Flutter Tutorials'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('Load image from assets', style: TextStyle(fontSize: 18.0),),
            Padding(padding: EdgeInsets.only(bottom: 18.0),),
            Image.asset('assets/images/eiffel.jpg'),
            Padding(padding: EdgeInsets.only(bottom: 18.0),),
            Text('Checkout tutorial at: https://fluttermaster.com/load-image-from-assets-in-flutter/', style: TextStyle(fontSize: 18.0),)
          ],
        ),
      ),
    );
  }
}
