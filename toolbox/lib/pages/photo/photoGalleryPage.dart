import 'dart:io';
import 'dart:convert';
import 'dart:async';
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

  @override
  void initState() {
    _dbHelper=DBHelper();
    super.initState();
  }

  Future  getFile() async{
   final selectedImage = await picker.getImage(source: ImageSource.camera);
   if(selectedImage!=null){
    final File file=File(selectedImage.path);
    String image=base64Encode(file.readAsBytesSync());
    await _dbHelper.insertPhoto(Photo(path: image));
    setState(() { });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Gallery'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          future: _dbHelper.getPhotos(),
          builder: (BuildContext context,AsyncSnapshot snapShot){
            if(!snapShot.hasData) return Center(child: CircularProgressIndicator(),);
            if(snapShot.data.isEmpty) return Center(child: Text('Your photo gallery list empty.'),);
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
                              Image.memory(base64Decode(photo.path), fit: BoxFit.fill),
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
                  child: Image.memory(base64Decode(photo.path))
                );
              }
            );
          }
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: getFile,
      ),
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