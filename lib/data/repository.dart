import 'package:flutter_boilerplate/data/api/music_api.dart';
import 'package:flutter_boilerplate/models/music_data.dart';

class Repository {
  final MusicApi _musicApi;
  const Repository(this._musicApi);

  Future<List<AudioFileData>> getMusicData() => _musicApi.getMusicData();
}
