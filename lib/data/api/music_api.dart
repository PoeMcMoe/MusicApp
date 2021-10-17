import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/constants/strings.dart';
import 'package:flutter_boilerplate/models/music_data.dart';
import 'package:flutter_boilerplate/utils/file_utils.dart';
import 'package:flutter_boilerplate/utils/string_util.dart';
import 'package:id3/id3.dart';
import 'package:just_audio/just_audio.dart';

class MusicApi {
  MusicApi();

  Future<List<AudioFileData>> getMusicData() async {
    final List<String> paths = await FileUtils.getMusicFilesPaths();
    final List<AudioFileData> musicData = await _getMusicData(paths);

    return musicData;
  }

  Future _getDuration(String path) {
    final AudioPlayer player = AudioPlayer();
    return player.setAsset(path);
  }

  Future<List<AudioFileData>> _getMusicData(List<String> paths) async {
    final List<AudioFileData> musicData = [];

    for (final String path in paths) {
      final Duration duration = await _getDuration(path);

      final ByteData mp3ByteData = await rootBundle.load(path);
      final ByteBuffer buffer = mp3ByteData.buffer;
      final List<int> mp3Bytes =
          buffer.asUint8List(0, mp3ByteData.lengthInBytes).toList();

      final MP3Instance mp3instance = MP3Instance(mp3Bytes);

      if (mp3instance.parseTagsSync()) {
        final AudioFileData musicDataElement = AudioFileData(
          name: mp3instance.getMetaTags()?[Strings.title] ?? 'Unkown title',
          genre:
              _getGenreName(mp3instance.getMetaTags()?[Strings.genre]) ?? '-1',
          sizeInBytes: mp3ByteData.lengthInBytes,
          duration: duration,
          imageBytes: _getImageBytes(
              mp3instance.getMetaTags()?['APIC']?['base64'], mp3instance),
        );

        musicData.add(musicDataElement);
      }
    }

    return musicData;
  }

  //Depending on the tag version it may return genre id or genre name.
  //Here I convert genre id to name if needed
  String? _getGenreName(String? genre) {
    if (genre != null) {
      final int? id =
          int.tryParse(genre.replaceAll('(', '').replaceAll(')', ''));
      return id != null ? StringUtil.convertGenreIdToName(id) : genre;
    } else {
      return StringUtil.convertGenreIdToName(-1);
    }
  }

  Uint8List? _getImageBytes(String? imageData, MP3Instance mp3instance) {
    if (imageData != null) {
      return base64Decode(mp3instance.getMetaTags()!['APIC']!['base64']);
    }
  }
}
