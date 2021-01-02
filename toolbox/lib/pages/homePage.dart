import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Tool Box'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListBox(icon: Icon(Icons.phone, color: Colors.white, size: 32,), text: 'Phone Book', description: 'See all saved phone numbers.', color: Colors.blue[400], path: '/phone_list'),
            ListBox(icon: Icon(Icons.photo_album_outlined , color: Colors.white, size: 32,), text: 'Photo Gallery', description: 'See all saved pictures.', color: Colors.blue[500], path: '/photo'),
            ListBox(icon: Icon(Icons.sticky_note_2_outlined, color: Colors.white, size: 32,), text: 'To - Do', description: 'See all saved to-do works.', color: Colors.blue[800], path: '/toDo'),
            ListBox(icon: Icon(Icons.calculate, color: Colors.white, size: 32,), text: 'Calculator', description: 'Calculator.  ', color: Colors.blue[900]),
          ]
        )
      ),
    );
  }
}

class ListBox extends StatelessWidget{
  ListBox({this.icon, this.text, this.description, this.color, this.path});

  final Icon icon;
  final String text;
  final String description;
  final Color color;
  final String path;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, path);
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25.0)
          ),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                icon,
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    )
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                  ),
                ),
              )
            )
          ],
        ),
      )
    );
  }
}

/*
class ListBox extends StatelessWidget{
  ListBox({this.icon, this.text, this.description, this.color, this.path});

  final Icon icon;
  final String text;
  final String description;
  final Color color;
  final String path;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, path);
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25.0)
          ),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    icon,
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      )
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),
                    ),
                  )
                )
              ],
            ),
          ],
        )
      )
    );
  }
}
*/