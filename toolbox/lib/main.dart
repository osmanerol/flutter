import 'package:flutter/material.dart';
import 'package:toolbox/pages/phone/phonePage.dart';
import 'package:toolbox/pages/photo/photoGalleryPage.dart';
import 'package:toolbox/pages/toDo/toDoPage.dart';

void main() {
  runApp( MyApp() );
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState()=> _MyAppState();
}


class _MyAppState extends State<MyApp> {
  var dark=false;

  void changeTheme() {
    setState((){
      dark=!dark;
     });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: dark ? ThemeData.dark() :  ThemeData.light(),
      home: HomePage(dark: dark, changeTheme: changeTheme),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({this.dark, this.changeTheme});
  final bool dark;
  final VoidCallback changeTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: dark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tool Box'),
          actions: [
            IconButton(
              icon: Icon(dark ? Icons.wb_sunny_outlined  : Icons.brightness_3 ),
              onPressed: changeTheme,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListBox(icon: Icon(Icons.phone, color: Colors.white, size: 32,), text: 'Phone Book', description: 'See all saved phone numbers.', color: Colors.blue[400], path: PhonePage() ),
              ListBox(icon: Icon(Icons.photo_album_outlined , color: Colors.white, size: 32,), text: 'Photo Gallery', description: 'See all saved pictures.', color: Colors.blue[500], path: PhotoGalleryPage() ),
              ListBox(icon: Icon(Icons.sticky_note_2_outlined, color: Colors.white, size: 32,), text: 'To - Do', description: 'See all saved to-do works.', color: Colors.blue[800], path: ToDoPage() ),  
            ]
          )
        ),
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
  final path;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> path));
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