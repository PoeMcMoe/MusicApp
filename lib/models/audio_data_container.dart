import 'package:flutter_boilerplate/models/music_data.dart';

class AudioDataContainer {
  List<AudioFileData> audioFileData;

  List<AudioFileData> songsInMemory = [];
  List<AudioFileData> songsInFileSystem = [];

  AudioDataContainer({required this.audioFileData});

  Map<String, List<AudioFileData>> getGenreFileMap() {
    final Map<String, List<AudioFileData>> map = {};
    for (final AudioFileData audioDataItem in audioFileData) {
      map[audioDataItem.genre] ??= [];
      map[audioDataItem.genre]?.add(audioDataItem);
    }

    return map;
  }
}
