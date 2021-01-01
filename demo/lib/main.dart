import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'App',
    home: MyApp()
  ));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Restaurant',
          ),
        )
      ),
      body: Container(
        child: Text('asd'),
      )
    );
  }
}
