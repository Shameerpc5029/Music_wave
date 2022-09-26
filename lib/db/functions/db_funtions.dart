import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';

class FavDb {
  static ValueNotifier<List<SongModel>> musicListNotifier = ValueNotifier([]);

  static late Database _db;
  static Future<void> initializeDatabase() async {
    _db = await openDatabase(
      'song.db',
      version: 1,
      onCreate: ((Database db, int version) async {
        await db.execute(
            'CREATE TABLE song (id INTEGER PRIMARY KEY, title TEXT, artist TEXT)');
      }),
    );
  }

  static Future<void> addFav(SongModel song) async {
    _db.rawInsert('INSERT INTO song (title,artist) VALUES (?,?)',
        [song.title, song.artist]);
    musicListNotifier.value.add(song);
    getAllSongs();

    musicListNotifier.notifyListeners();
  }

  static Future<void> getAllSongs() async {
    final song = await _db.rawQuery('SELECT * FROM song');
    print(song);

    musicListNotifier.value.clear();

    for (var map in song) {
      final addsong = SongModel(map);
      musicListNotifier.value.add(addsong);
      musicListNotifier.notifyListeners();
    }
    // musicListNotifier.value.add(song);
  }
}
