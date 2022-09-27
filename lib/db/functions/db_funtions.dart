import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';

class FavDb {
  static ValueNotifier<List<SongModel>> musicListNotifier = ValueNotifier([]);

  static late Database db;
  static Future<void> initializeDatabase() async {
    db = await openDatabase(
      'song.db',
      version: 1,
      onCreate: ((Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS song (id INTEGER PRIMARY KEY AUTOINCREMENT, _id INTEGER, title TEXT, artist TEXT)');
      }),
    );
  }

  static Future<void> addFav(SongModel song) async {
    int id = await db.rawInsert(
        'INSERT INTO song (_id,title,artist) VALUES (?,?,?)',
        [song.id, song.title, song.artist]);
    musicListNotifier.value.add(song);
    print(id);
    getAllSongs();
    // removeFav(id);
    FavDb.musicListNotifier.notifyListeners();
  }

  static Future<void> getAllSongs() async {
    final song = await db.rawQuery('SELECT * FROM song');
    log(song.toString());
    musicListNotifier.value.clear();
    for (var map in song) {
      final addsong = SongModel(map);
      musicListNotifier.value.add(addsong);
      // musicListNotifier.notifyListeners();
    }
    // musicListNotifier.value.add(song);
   
  }

  static Future<void> removeFav(int id) async {
    await db.delete('song.db', where: 'id= ?', whereArgs: [id]);
  }
}
