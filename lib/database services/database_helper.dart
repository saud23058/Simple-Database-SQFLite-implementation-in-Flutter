import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const dbName='Mydatabase.db';
  static const dbVersion= 1;
  static const dbTable='MyTable';
  static const columnId='id';
  static const columnName='Myname';


static  final  DatabaseHelper instance= DatabaseHelper();

//database initialization
Database? _database;

Future<Database?>get database async{
 if(_database!=null){
   return _database;
 }else{
   _database = await initDB();
 }
 return _database;
}

initDB()async{
  Directory directory = await getApplicationDocumentsDirectory();
  String path= join(directory.path,dbName);
  return await openDatabase(path,version: dbVersion,onCreate: onCreate);
}
Future onCreate(Database db, int version)async{
  db.execute(
      ''' 
    CREATE TABLE $dbTable(
    $columnId INTEGER PRIMARY KEY,
    $columnName TEXT NOT NULL
    )
    ''');
}
// Insert Method
insert(Map<String , dynamic>row) async{
  Database? db= await instance.database;
  return await db?.insert(dbTable, row);
}

//Read or Query Method
Future<List<Map<String,dynamic>>> queryDatabase()async
{
  Database? db= await instance.database;
  return db!.query(dbTable);
}
// update Method
Future<int>updateRecord(Map<String,dynamic>row)async{
  Database? db= await instance.database;
  int id= row[columnId];
  return db!.update(dbTable, row,where: '$columnId=?',whereArgs: [id]);
}
// delete Method
Future<int> deleteRecord(int id)async{
  Database? db= await instance.database;
  return db!.delete(dbTable,where: '$columnId=?',whereArgs: [id]);
}
}