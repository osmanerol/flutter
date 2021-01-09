import 'package:flutter/material.dart';
import 'package:toolbox/database/dbHelper.dart';
import 'package:toolbox/models/phone.dart';

class AddContactDialog extends StatelessWidget {
  AddContactDialog({this.name, this.phoneNumber, this.dbHelper, this.setState});
  var name;
  var phoneNumber;
  final VoidCallback setState;
  final _formKey=GlobalKey<FormState>();
  DBHelper dbHelper;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Phone Number'),
      scrollable: true,
      content: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Name'
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
                    var phone=Phone(name: name, number: phoneNumber );
                    await dbHelper.insertPhone(phone);
                    setState();
                    Navigator.pop(context, true);
                  }
                },
                color: Colors.blue,
                textColor: Colors.white,
              )
            ],
          )
        ),
      )
    );
  }
}