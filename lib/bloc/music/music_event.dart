part of 'music_bloc.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class LoadMusicData extends MusicEvent {}

class StoreSongToMemory extends MusicEvent {
  final AudioFileData data;
  const StoreSongToMemory(this.data);

  @override
  List<Object> get props => [data];
}

class StoreSongToFilesystem extends MusicEvent {
  final AudioFileData data;

  const StoreSongToFilesystem(this.data);

  @override
  List<Object> get props => [data];
}
