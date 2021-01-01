import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phone_list/database/db_helper.dart';
import 'package:phone_list/model/contact.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Contact'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: AddContactForm()
        )
      ),
    );
  }
}

class AddContactForm extends StatefulWidget {
  
  @override
  _AddContactFormState createState()=> _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formKey=GlobalKey<FormState>();
  final picker = ImagePicker();
  File _image;
  var a=10;
  DBHelper _dbHelper;

  @override
  void initState() {
    _dbHelper=DBHelper();
    super.initState();
  }

  Future  getFile() async{
   final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context){
    String name;
    String phoneNumber; 

    return Column(
      children: [
        Stack(
          children: [
            Image.asset(
              _image==null ? 'assets/images/person.png' : _image.path,
              fit: BoxFit.cover,
              height: 250,
            ),
            Positioned(
              bottom: 30,
              right: 10,
              child: IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: getFile,
              ),
            )
          ],
        ),
        Padding(  
          padding: EdgeInsets.all(8.0) ,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Contact Name'
                    ),
                    validator: (value) {
                      if(value.isEmpty){
                        return 'Name required';
                      }
                    },
                    onSaved: (value){ name=value; },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Phone Number'
                    ),
                    validator: (value) {
                      if(value.isEmpty){
                        return 'Phone Number required';
                      }
                    },
                    onSaved: (value){ phoneNumber=value; },
                  ),
                ),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      _formKey.currentState.save();
                      var contact=Contact(name: name, phoneNumber: phoneNumber, avatar: _image==null ? '' : _image.path );
                      await _dbHelper.insertContact(contact);
                      var snackBar= Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('$name has been saved.')
                        )
                      );
                      snackBar.closed.then((value){
                        Navigator.pop(context);
                      });
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ],
            )
          ),
        )
      ],
    );
  }
}