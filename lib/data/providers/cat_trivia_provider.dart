import 'package:felinefacts/data/models/cat_trivia_model.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

const TABLE_CAT_TRIVIA = 'cat_trivia';
const COLUMN_ID = '_id';
const COLUMN_FACT = 'fact';
const COLUMN_LENGTH = 'length';

abstract class BaseCatTriviaProvider {
  Future<int> insert(CatTriviaModel model);
  Future<List<int>> insertAll(List<CatTriviaModel> models);
  Future<List<CatTriviaModel>> getAllTrivia();
  Future<int> deleteAll();
}

class CatTriviaProvider extends BaseCatTriviaProvider {
  Database _db;
  final String databasePath;
  CatTriviaProvider({@required this.databasePath});

  Future _open(String path) async {
    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $TABLE_CAT_TRIVIA ( 
          $COLUMN_ID integer primary key autoincrement, 
          $COLUMN_FACT text not null,
          $COLUMN_LENGTH integer not null)
        ''');
    });
  }

  Future _close() async {
    return _db.close();
  }

  @override
  Future<int> insert(CatTriviaModel model) async {
    await _open(databasePath);
    final id = _db.insert(TABLE_CAT_TRIVIA, model.toMap());
    await _close();
    return id;
  }

  @override
  Future<List<int>> insertAll(List<CatTriviaModel> models) async {
    await _open(databasePath);
    List<int> ids = List<int>();
    for (final model in models) {
      final id = await _db.insert(TABLE_CAT_TRIVIA, model.toMap());
      ids.add(id);
    }
    await _close();
    return ids;
  }

  @override
  Future<List<CatTriviaModel>> getAllTrivia() async {
    await _open(databasePath);
    List<Map> queryMaps = await _db.query(
      TABLE_CAT_TRIVIA,
      columns: [COLUMN_ID, COLUMN_FACT],
    );
    await _close();
    return queryMaps.map((map) => CatTriviaModel.fromMap(map)).toList();
  }

  @override
  Future<int> deleteAll() async {
    await _open(databasePath);
    final result = _db.delete(TABLE_CAT_TRIVIA, where: '');
    await _close();
    return result;
  }
}
