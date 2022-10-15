class ListModel {
  final String playlistName;

  ListModel({
    required this.playlistName,
  });

  static ListModel fromMap(Map<String, Object?> map) {
    final listName = map['playlistName'] as String;
    return ListModel(
      playlistName: listName,
    );
  }
}
