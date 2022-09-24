import 'package:on_audio_query/on_audio_query.dart';

class SongListModel {
  int? id;
  final String title;
  final String artist;
  SongListModel({required this.title, required this.artist, this.id});
  static SongListModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final title = map['title'] as String;
    var artist = map['artist'] as String;
    return SongListModel(
      id: id,
      title: title,
      artist: artist,
    );
  }
}
