import 'package:flutter/material.dart';
import 'package:toolbox/database/dbHelper.dart';
import 'package:toolbox/models/phone.dart';
import 'package:toolbox/pages/phone/addContactDialog.dart';

class PhonePage extends StatefulWidget{

  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<PhonePage> {
  DBHelper _dbHelper;
  final _formKey=GlobalKey<FormState>();

  @override 
  void initState() {
    _dbHelper=DBHelper();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    String name='';
    String phoneNumber='';

    void stateChange() {
      setState(() { });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Book'),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: _dbHelper.getPhones(),
          builder: (BuildContext context,AsyncSnapshot snapShot){
            if(!snapShot.hasData) return Center(child: CircularProgressIndicator(),);
            if(snapShot.data.isEmpty) return Center(child: Text('Your phone list empty.'),);
            return ListView.builder(
              itemCount: snapShot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Phone phone=snapShot.data[index];
                return GestureDetector(
                  onTap:  () {
                  }, 
                  child: Dismissible(
                    key: UniqueKey(), 
                    onDismissed: (direction) async {
                      await _dbHelper.removePhone(phone.id);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${phone.name} has been deleted.'),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () async {
                              await _dbHelper.insertPhone(phone);
                              setState(() { });
                            },
                          ),
                        )
                      );
                    },
                    child:  ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(phone.name[0]),
                      ),
                      title: Text(phone.name),
                      subtitle: Text(phone.number),
                    )
                  )
                );
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddContactDialog(name: name, phoneNumber: phoneNumber, dbHelper: _dbHelper, setState: stateChange );
              }
            );
        },
      ),
    );
  }
}
