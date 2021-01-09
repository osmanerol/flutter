import 'package:flutter/material.dart';
import 'package:toolbox/database/dbHelper.dart';
import 'package:toolbox/models/toDo.dart';
import 'package:toolbox/pages/toDo/addTodoForm.dart';

class ToDoPage extends StatefulWidget{

  @override
  _ToDoState createState() => _ToDoState();
}

class _ToDoState extends State<ToDoPage> {
  DBHelper _dbHelper;

  @override
  void initState() {
    _dbHelper=DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String description='';

    void stateChange() {
      setState(() { });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            AddToDoForm(description: description, setState: stateChange, dbHelper: _dbHelper),
            Expanded(
              child: FutureBuilder(
                future: _dbHelper.getToDos(),
                builder: (BuildContext context,AsyncSnapshot snapShot){
                  if(!snapShot.hasData) return Center(child: CircularProgressIndicator(),);
                  if(snapShot.data.isEmpty) return Center(child: Text('Your to-do list empty.'),);
                  return ListView.separated(  
                    itemCount: snapShot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      ToDo toDo=snapShot.data[index];
                      return ListTile(
                        title: Text('${toDo.description}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await _dbHelper.removeToDo(toDo.id);
                            setState(() { });
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                  );
                }
              )
            )
          ]
        ),
      )
    );
  }
}
