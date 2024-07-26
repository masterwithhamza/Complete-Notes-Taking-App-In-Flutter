import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'notes_model.dart';
class DatabaseHelper {
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/attendance.db';

    // open/ create database at a given path
    var attendanceDatabase = await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
    );

    return attendanceDatabase;
  } //end of  initializeDatabase

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE tbl_teacher (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  name TEXT,
                  designation TEXT,
                  dept TEXT)
    
    ''');

    // await db.execute('''Create TABLE tbl_student (
    //               id INTEGER PRIMARY KEY AUTOINCREMENT,
    //               name TEXT,
    //               designation TEXT,
    //               dept TEXT)
    //
    // ''');
  } // end of _createDb

  Future<int> insertTeacher(Teacher tch) async {
    // add dog to table

    Database db = await instance.database;
    int result = await db.insert('tbl_teacher', tch.toMap());
    //db.rawInsert(sql)
    return result;
  } //end of insertTeacher

  Future<List<Teacher>> getAllTeachers() async {
    List<Teacher> tch_list = [];

    Database db = await instance.database;

    List<Map<String, dynamic>> listMap = await db.query('tbl_teacher');

    for (var tchMap in listMap) {
      Teacher tch = Teacher.fromMap(tchMap);
      tch_list.add(tch);
    }
    return tch_list;
  } // end of getAllTeachers

  Future<int> deleteTeacher(int id) async {
    Database db = await instance.database;
    int result = await db.delete('tbl_teacher', where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<int> updateTeacher(Teacher tch) async {
    Database db = await instance.database;
    // print(tch.toMap());
    int result = await db.update('tbl_teacher', tch.toMap(), where: 'id=?', whereArgs: [tch.id]);
    return result;
  }

}
