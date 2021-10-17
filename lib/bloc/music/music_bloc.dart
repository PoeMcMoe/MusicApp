import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_boilerplate/constants/strings.dart';
import 'package:flutter_boilerplate/data/repository.dart';
import 'package:flutter_boilerplate/models/audio_data_container.dart';
import 'package:flutter_boilerplate/models/music_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final Repository repository;
  final SharedPreferences sharedPreferences;

  MusicBloc(this.sharedPreferences, {required this.repository})
      : super(MusicBlocInitial());

  List<AudioFileData> songsInMemory = [];
  List<AudioFileData> songsInFileSystem = [];

  AudioDataContainer? audioDataContainer;

  @override
  Stream<MusicState> mapEventToState(MusicEvent event) async* {
    switch (event.runtimeType) {
      case LoadMusicData:
        yield* _mapLoadMusicDataToMusicDataLoaded();
        break;
      case StoreSongToMemory:
        yield* _mapStoreSongToMemoryToSongStoredToMemory(
            event as StoreSongToMemory);
        break;
      case StoreSongToFilesystem:
        yield* _mapStoreSongToFilesystemToSongStoredToFilesystem(
            event as StoreSongToFilesystem);
        break;
    }
  }

  Stream<MusicState> _mapLoadMusicDataToMusicDataLoaded() async* {
    yield MusicDataLoading();

    audioDataContainer =
        AudioDataContainer(audioFileData: await repository.getMusicData());
    songsInFileSystem = _getSongsInFileSystem();

    yield MusicDataLoaded(audioDataContainer);
  }

  Stream<MusicState> _mapStoreSongToMemoryToSongStoredToMemory(
      StoreSongToMemory event) async* {
    yield SavingMusicData();
    songsInMemory.contains(event.data)
        ? songsInMemory.remove(event.data)
        : songsInMemory.add(event.data);
    yield SavedMusicData();
  }

  Stream<MusicState> _mapStoreSongToFilesystemToSongStoredToFilesystem(
      StoreSongToFilesystem event) async* {
    yield SavingMusicData();
    songsInFileSystem.contains(event.data)
        ? songsInFileSystem.remove(event.data)
        : songsInFileSystem.add(event.data);

    await sharedPreferences.setString(
        Strings.audioData, jsonEncode(songsInFileSystem));
    yield SavedMusicData();
  }

  List<AudioFileData> _getSongsInFileSystem() {
    final List<dynamic> songDataJsonList =
        json.decode(sharedPreferences.get(Strings.audioData).toString());
    final List<AudioFileData> convertedSongs = [];

    for (final String item in songDataJsonList) {
      convertedSongs.add(AudioFileData.fromJson(item));
    }

    return convertedSongs;
  }
}
