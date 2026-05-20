import 'package:game_vault/database/database_helper.dart';
import 'package:game_vault/models/game_model.dart';
import 'package:sqflite/sqflite.dart';

class GameService {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertGame(GameModel game) async {
    Database db = await _databaseHelper.database;

    return await db.insert(
      'games',
      game.toMap(),
    );
  }

  Future<List<GameModel>> getGames() async {
    Database db = await _databaseHelper.database;

    final List<Map<String, dynamic>> maps =
        await db.query('games');

    return List.generate(
      maps.length,
      (i) => GameModel.fromMap(maps[i]),
    );
  }

  Future<int> deleteGame(int id) async {
    Database db = await _databaseHelper.database;

    return await db.delete(
      'games',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  Future<int> updateGame(GameModel game) async {
  Database db = await _databaseHelper.database;

  return await db.update(
    'games',
    game.toMap(),
    where: 'id = ?',
    whereArgs: [game.id],
  );
}
}