import 'package:flutter/material.dart';
import 'package:toolbox/database/dbHelper.dart';
import 'package:toolbox/models/toDo.dart';

class AddToDoForm extends StatelessWidget {
  AddToDoForm({this.description, this.setState, this.dbHelper});
  var description;
  final VoidCallback setState;
  final DBHelper dbHelper;
  final _formKey=GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'To-Do'
              ),
              validator: (value) {
                if(value.isEmpty){
                  return 'Required';
                }
              },
              onSaved: (value){ description=value;},
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              child: Text('Submit'),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                  var phone=ToDo(description: description);
                  await dbHelper.insertToDo(phone);
                  _controller.clear();
                  setState();
                }
              },
              color: Colors.blue,
              textColor: Colors.white,
            ),
          )
        ],
      )
    );
  }
}

