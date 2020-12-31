import 'package:flutter/material.dart';

// game page
import './game.dart';

void main() {
  runApp(MaterialApp(
    title:'Flutter',
    initialRoute: '/',
    routes: {
      '/': (context)=>App(),
      '/game': (context)=>Game()
    },
  ));
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schulte Game'),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The time will start when you start the game',
              style:TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            ),
            ElevatedButton(
              child: Text('Start Game'),
              onPressed: () {
                Navigator.pushNamed(context, '/game');
              },
            )
          ],
        )
      ),
    );
  }
}
