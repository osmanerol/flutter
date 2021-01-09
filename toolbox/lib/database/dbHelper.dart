import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:toolbox/models/phone.dart';
import 'package:toolbox/models/photo.dart';
import 'package:toolbox/models/toDo.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if(_db != null) return _db;
    _db=await initDb();
    return _db; 
  }

  initDb() async {
    io.Directory documentDirectory=await getApplicationDocumentsDirectory();
    String path= join(documentDirectory.path, 'toolbox.db');
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Phone(id INTEGER PRIMARY KEY, name TEXT, phone_number TEXT)');
    await db.execute('CREATE TABLE Photo(id INTEGER PRIMARY KEY, path TEXT)');
    await db.execute('CREATE TABLE Todo(id INTEGER PRIMARY KEY, description TEXT)');
  }

  //  phone_book
  Future<List<Phone>> getPhones() async {
    var dbClient= await db;
    var result=await dbClient.query('Phone', orderBy:'name');
    return result.map((data)=> Phone.fromMap(data)).toList();
  }

  Future<int> insertPhone(Phone phone) async {
    var dbClient=await db;
    return  await dbClient.insert('Phone', phone.toMap());
  }

  Future<void> removePhone(int id) async {
    var dbClient=await db;
    return await dbClient.delete('Phone', where: 'id=?', whereArgs:[id]);
  }

  //  photo_gallery
  Future<List<Photo>> getPhotos() async {
    var dbClient= await db;
    var result=await dbClient.query('Photo', orderBy:'id');
    return result.map((data)=> Photo.fromMap(data)).toList();
  }

  Future<int> insertPhoto(Photo photo) async {
    var dbClient=await db;
    return dbClient.insert('Photo', photo.toMap());
  }

  Future<void> removePhoto(int id) async {
    var dbClient=await db;
    return await dbClient.delete('Photo', where: 'id=?', whereArgs:[id]);
  }

  // to-do
  Future<List<ToDo>> getToDos() async {
    var dbClient= await db;
    var result=await dbClient.query('Todo', orderBy:'id');
    return result.map((data)=> ToDo.fromMap(data)).toList();
  }

  Future<int> insertToDo(ToDo toDo) async {
    var dbClient=await db;
    return dbClient.insert('Todo', toDo.toMap());
  }

  Future<void> removeToDo(int id) async {
    var dbClient=await db;
    return await dbClient.delete('Todo', where: 'id=?', whereArgs:[id]);
  }


}