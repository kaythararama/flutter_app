
import 'package:flutter_app/database/entity/person.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class PersonDao{
  String _databaseName = "test.db";
  Database _db;
  String _tableName = 'person';

  Future open() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $_tableName(`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `address` TEXT, `dob` INTEGER NOT NULL, `weight` DOUBLE)",
        );
      },
      version: 1,
    );
    try {
      _db.rawQuery("PRAGMA encoding ='UTF-8'");
      _db.rawQuery( "PRAGMA journal_mode ='delete'");
    }catch (e){
        print(e.toString());
    }
  }

  Future<int> insert(Person person) async {
    return await _db.insert(
      _tableName,
      person.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> update( Person person ) async{
    return await _db.update(
        _tableName,
        person.toMap(),
        where: 'id=?',
        whereArgs: [person.id],
        conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<Person>> list(int limit, int offset) async {
    final List<Map<String, dynamic>> maps = await _db.query(
        _tableName,
        limit: limit,
        offset: offset,
        orderBy: "id DESC"
    );

    return List.generate( maps.length, (i) {
      return Person.fromMap(maps[i]);
    });
  }

  Future<Person> findById(int id) async {

    final List<Map<String, dynamic>> maps = await _db.query(
        _tableName,
        where: 'id=?',
        whereArgs: [id]
    );
    if (maps.isNotEmpty) {
      return Person.fromMap(maps.first);
    }else
      return null;
  }

  Future<int> deleteById( int id ) async{
    return await _db.delete(
        _tableName,
        where: 'id=?',
        whereArgs: [id]
    );
  }

  Future close() async => _db.close();
}