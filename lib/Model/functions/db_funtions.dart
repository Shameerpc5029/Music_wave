// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_wave/Model/model/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sqflite/sqflite.dart';

class FavDb extends ChangeNotifier {
  List<SongModel> favSongModel = [];
  List<ListModel> playlistModel = [];
  List<SongModel> songsPlaylist = [];

  static late Database db;
  static late Database playlistDb;
  static late Database playlistMusicDb;

  //fav
  static Future<void> initializeDatabase() async {
    db = await openDatabase(
      'song.db',
      version: 1,
      onCreate: ((Database db, int version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS song (id INTEGER PRIMARY KEY AUTOINCREMENT, _id INTEGER, _uri TEXT, _data TEXT, title TEXT, artist TEXT, _display_name_wo_ext TEXT)',
        );
      }),
    );
    //playlist
    playlistDb = await openDatabase(
      'playlist.db',
      version: 1,
      onCreate: (Database playlistDb, int version) async {
        await playlistDb.execute(
          'CREATE TABLE IF NOT EXISTS playlist (id INTEGER PRIMARY KEY,playlistName TEXT)',
        );
      },
    );
    //playlist music
    playlistMusicDb = await openDatabase(
      'playlistmusic.db',
      version: 1,
      onCreate: (Database playlistMusicDb, int version) async {
        await playlistMusicDb.execute(
          'CREATE TABLE IF NOT EXISTS playlistSong (id INTEGER PRIMARY KEY AUTOINCREMENT, _id INTEGER, _uri TEXT, _data TEXT, title TEXT, artist TEXT, _display_name_wo_ext TEXT, playlistName TEXT)',
        );
      },
    );
  }

  //playlist
  Future<void> addPlaylist(ListModel playlistmodel) async {
    await playlistDb.rawInsert(
      'INSERT INTO playlist (playlistName) VALUES (?)',
      [playlistmodel.playlistName],
    );

    getAllPlaylist();
    playlistModel.add(playlistmodel);
    notifyListeners();

    // FavDb.playListNotifier.notifyListeners();
  }

  Future<void> removePlaylist(String playlistName) async {
    await playlistDb.delete(
      'playlist',
      where: 'playlistName= ?',
      whereArgs: [playlistName],
    );

    playlistMusicDb.delete(
      'playlistSong',
    );
    getAllPlaylist();
    notifyListeners();

    // playListNotifier.notifyListeners();
  }

  Future<void> getAllPlaylist() async {
    final playlistmodel = await playlistDb.rawQuery(
      'SELECT * FROM playlist',
    );
    playlistModel.clear();
    // playListNotifier.value.clear();
    for (var map in playlistmodel) {
      final playlist = ListModel.fromMap(map);
      // playListNotifier.notifyListeners(
      // );
      playlistModel.add(playlist);

      // playListNotifier.value.add(
      //   playlist,
      // );
      notifyListeners();
    }
  }

  //add playlist music
  Future<void> getAllPlaylistSongs(String playlistName) async {
    final song = await playlistMusicDb.rawQuery(
      'SELECT * FROM playlistSong WHERE playlistName = ? ',
      [playlistName],
    );
    // playListMusicNotifier.value.clear();
    songsPlaylist.clear();
    for (var map in song) {
      final addsong = SongModel(
        map,
      );
      // playListMusicNotifier.value.add(
      //   addsong,
      // );
      songsPlaylist.add(addsong);
    }
    // playListMusicNotifier.notifyListeners();
    notifyListeners();
  }

  Future<void> addPlaylistMusic(SongModel song, String playlistName) async {
    await playlistMusicDb.rawInsert(
      'INSERT INTO playlistSong (_id,_uri,_data,title,artist,_display_name_wo_ext,playlistName) VALUES (?,?,?,?,?,?,?)',
      [
        song.id,
        song.uri,
        song.data,
        song.title,
        song.artist,
        song.displayNameWOExt,
        playlistName
      ],
    );
    // playListMusicNotifier.value.add(
    //   song,
    // );
    songsPlaylist.add(song);

    getAllPlaylistSongs(
      playlistName,
    );

    // FavDb.playListMusicNotifier.notifyListeners();
    notifyListeners();
  }

  Future<void> removePlaylistMusic(int id, String playlistName) async {
    await playlistMusicDb.delete(
      'playlistSong',
      where: '_id= ?',
      whereArgs: [id],
    );
    getAllPlaylistSongs(
      playlistName,
    );

    // playListMusicNotifier.notifyListeners();
    notifyListeners();
  }

  //Song Fav
  Future<void> addFav(SongModel song) async {
    await db.rawInsert(
        'INSERT INTO song (_id,_uri,_data,title,artist,_display_name_wo_ext) VALUES (?,?,?,?,?,?)',
        [
          song.id,
          song.uri,
          song.data,
          song.title,
          song.artist,
          song.displayNameWOExt
        ]);
    // musicListNotifier.value.add(
    //   song,
    // );

    // favSongModel.add(song);
    favSongModel.add(song);
    log(song.toString());
    getAllSongs();
    notifyListeners();
    // musicListNotifier.notifyListeners();
  }

  Future<void> getAllSongs() async {
    final song = await db.rawQuery(
      'SELECT * FROM song',
    );
    favSongModel.clear();
    // musicListNotifier.value.clear();
    for (var map in song) {
      final addsong = SongModel(
        map,
      );
      // musicListNotifier.value.add(
      //   addsong,
      // );
      favSongModel.add(addsong);
      // log(addsong.toString());
    }
    // musicListNotifier.notifyListeners();
    print("Get all Music");

    notifyListeners();
  }

  Future<void> removeFav(int id) async {
    await db.delete(
      'song',
      where: '_id= ?',
      whereArgs: [id],
    );
    print("Removed");
    getAllSongs();
    notifyListeners();
  }

  Future<int?> countFav() async {
    final count = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT COUNT (*) FROM song',
      ),
    );

    // musicListNotifier.notifyListeners();
    notifyListeners();
    return count;
  }

  Future<bool> isFav(dynamic id) async {
    final song = await db.rawQuery(
      'SELECT * FROM song WHERE _id = ?',
      [id],
    );
    notifyListeners();
    // musicListNotifier.notifyListeners()
    return song.isNotEmpty;
  }

  //reset App
  Future<void> resetAll() async {
    await db.delete(
      'song',
    );
    await playlistDb.delete(
      'playlist',
    );
    await playlistMusicDb.delete(
      'playlistSong',
    );
    notifyListeners();
  }

  static Future<void> dbClose() async {
    await db.close();
    await playlistDb.close();
    await playlistMusicDb.close();
  }
}
