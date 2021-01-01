import 'package:flutter/material.dart';
import 'package:phone_list/add_contact_page.dart';
import 'package:phone_list/database/db_helper.dart';
import 'package:phone_list/model/contact.dart';

class ContactPage extends StatefulWidget {

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts;
  DBHelper _dbHelper;

  @override
  void initState() {
    contacts = Contact.contacts;
    _dbHelper=DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact.contacts.sort(
      (Contact a, Contact b) => a.name[0].toLowerCase().compareTo(b.name[0].toLowerCase()),
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone List'),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: _dbHelper.getContact(),
          builder: (BuildContext context,AsyncSnapshot snapShot){
            if(!snapShot.hasData) return CircularProgressIndicator();
            if(snapShot.data.isEmpty) return Text('Your contact list empty.');
            return ListView.builder(
              itemCount: snapShot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Contact contact=snapShot.data[index];
                return Dismissible(
                  key: UniqueKey(), 
                  onDismissed: (direction) async {
                    await _dbHelper.removeContact(contact.id);

                    setState((){ });
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${contact.name} has been deleted.'),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () async {
                            await _dbHelper.insertContact(contact);
                            setState(() { });
                          },
                        ),
                      )
                    );
                  },
                  child:  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(contact.avatar.isEmpty ? 'assets/images/person.png' : contact.avatar),
                      /*
                      backgroundColor: Colors.blue,
                      child: Text(contact.name[0]),
                      */
                    ),
                    title: Text(contact.name),
                    subtitle: Text(contact.phoneNumber),
                  )
                );
              },
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> AddContactPage()));
        },
      ),
    );
  }
}