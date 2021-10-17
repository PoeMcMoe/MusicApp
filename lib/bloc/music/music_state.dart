part of 'music_bloc.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicBlocInitial extends MusicState {}

class MusicDataLoading extends MusicState {}

class SavingMusicData extends MusicState {}

class SavedMusicData extends MusicState {}

class MusicDataLoaded extends MusicState {
  final AudioDataContainer? musicDataContainer;
  const MusicDataLoaded(this.musicDataContainer);

  @override
  List<Object> get props => [musicDataContainer!];
}
