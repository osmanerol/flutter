import 'package:flutter/material.dart';


class Sidebar extends StatefulWidget {

  @override
  _SidebarState createState()=> _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool switchOpen=false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(10.0,20.0,10.0,10.0),
        children: <Widget>[
          ListTile(
            title: Text('Change theme'),
            trailing: Switch(value: switchOpen, onChanged: (value){
              setState(() {
                switchOpen=!switchOpen;
              });
            })
          ),
        ],
      ),
    );
  }
}