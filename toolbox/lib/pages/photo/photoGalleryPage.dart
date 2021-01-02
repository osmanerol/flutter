import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toolbox/database/dbHelper.dart';
import 'package:toolbox/models/photo.dart';


class PhotoGalleryPage extends StatefulWidget {
  @override
  _PhotoGalleryState createState()=> _PhotoGalleryState();
}

class _PhotoGalleryState extends State<PhotoGalleryPage> {
  DBHelper _dbHelper;
  final picker = ImagePicker();
  File _image;

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
        _dbHelper.insertPhoto(Photo(path: _image.path));
        setState(() { });
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: getFile,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: _dbHelper.getPhotos(),
          builder: (BuildContext context,AsyncSnapshot snapShot){
            if(!snapShot.hasData) return CircularProgressIndicator();
            if(snapShot.data.isEmpty) return Text('Your contact list empty.');
            return GridView.builder(
              itemCount: snapShot.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, crossAxisSpacing: 10, mainAxisSpacing: 10  ), 
              itemBuilder: (BuildContext context, int index) {
                Photo photo=snapShot.data[index];
                return GestureDetector(
                  onTap: () { 
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Material(
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image.asset(photo.path,fit: BoxFit.fill),
                              Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  icon: Icon(Icons.cancel), 
                                  onPressed: (){
                                    Navigator.pop(context, true);
                                  }
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete, 
                                    size: 40, 
                                    color: Colors.red
                                  ), 
                                  onPressed: (){
                                    _dbHelper.removePhoto(photo.id);
                                    setState(() { });
                                    Navigator.pop(context, true);
                                  }
                                )
                              )
                            ],
                          )
                        );
                      }
                    );
                   },
                  child: Image.asset(photo.path)
                );
              }
            );
          }
        )
      )
    );
  }
}

class Photos extends StatelessWidget {
  Photos({this.dbHelper});
  final DBHelper dbHelper;

  @override
  Widget build(BuildContext context){
    return Text('asd');
  }
}


class Camera extends StatelessWidget {
  Camera({this.getFile});
  final VoidCallback getFile;

  @override
  Widget build(BuildContext context){
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: getFile,
          )
        ],
      ),
    );
  }
}