import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toolbox/models/phone.dart';
import 'package:toolbox/models/photo.dart';

class DBHelper {
  static Database _db;

  Future<Database> get db async {
    if(_db != null) return _db;
    _db=await initDb();
    return _db; 
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path= join(dbFolder, 'toolbox.db');
    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE Phone(id INTEGER PRIMARY KEY, name TEXT, phone_number TEXT)');
    await db.execute('CREATE TABLE Photo(id INTEGER PRIMARY KEY, path TEXT)');
  }

  //  phone_book
  Future<List<Phone>> getPhones() async {
    var dbClient= await db;
    var result=await dbClient.query('Phone', orderBy:'name');
    return result.map((data)=> Phone.fromMap(data)).toList();
  }

  Future<int> insertPhone(Phone phone) async {
    var dbClient=await db;
    return dbClient.insert('Phone', phone.toMap());
  }

  Future<void> removePhone(int id) async {
    var dbClient=await db;
    return await dbClient.delete('Phone', where: 'id=?', whereArgs:[id]);
  }

  //  photo_gallery
  Future<List<Photo>> getPhotos() async {
    var dbClient= await db;
    var result=await dbClient.query('Photo', orderBy:'id');
    print('asd');
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

}