import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/db/model/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';

class FavDb {
  static ValueNotifier<List<SongModel>> musicListNotifier = ValueNotifier([]);
  static ValueNotifier<List<ListModel>> playListNotifier = ValueNotifier([]);
  static late Database db;
  static late Database playlistDb;
  //fav
  static Future<void> initializeDatabase() async {
    db = await openDatabase(
      'song.db',
      version: 1,
      onCreate: ((Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS song (id INTEGER PRIMARY KEY AUTOINCREMENT, _id INTEGER, title TEXT, artist TEXT)');
      }),
    );
//playlist
    playlistDb = await openDatabase(
      'playlist.db',
      version: 1,
      onCreate: (Database playlistDb, int version) async {
        await playlistDb.execute(
            'CREATE TABLE IF NOT EXISTS playlist (id INTEGER PRIMARY KEY,playlistName TEXT)');
      },
    );
  }

//playlist
  static Future<void> addPlaylist(ListModel playlistmodel) async {
    await playlistDb.rawInsert('INSERT INTO playlist (playlistName) VALUES (?)',
        [playlistmodel.playlistName]);

    getAllPlaylist();

    FavDb.playListNotifier.notifyListeners();
  }

  static Future<void> removePlaylist(String playlistName) async {
    await playlistDb.delete('playlist',
        where: 'playlistName= ?', whereArgs: [playlistName]);
    getAllPlaylist();
    playListNotifier.notifyListeners();
  }

  static Future<void> getAllPlaylist() async {
    final playlistmodel = await playlistDb.rawQuery('SELECT * FROM playlist');
    print(playlistmodel);
    playListNotifier.value.clear();
    for (var map in playlistmodel) {
      final playlist = ListModel.fromMap(map);
      playListNotifier.notifyListeners();
      playListNotifier.value.add(playlist);
    }
  }

//Song Fav
  static Future<void> addFav(SongModel song) async {
    await db.rawInsert('INSERT INTO song (_id,title,artist) VALUES (?,?,?)',
        [song.id, song.title, song.artist]);
    musicListNotifier.value.add(song);

    getAllSongs();

    FavDb.musicListNotifier.notifyListeners();
  }

  static Future<void> getAllSongs() async {
    final song = await db.rawQuery('SELECT * FROM song');
    log(song.toString());
    musicListNotifier.value.clear();
    for (var map in song) {
      final addsong = SongModel(map);
      musicListNotifier.value.add(addsong);
    }
  }

  static Future<void> removeFav(int id) async {
    await db.delete('song', where: '_id= ?', whereArgs: [id]);
    getAllSongs();
    musicListNotifier.notifyListeners();
  }
}
