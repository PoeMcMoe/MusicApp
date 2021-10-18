import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/bloc/music/music_bloc.dart';
import 'package:flutter_boilerplate/constants/dimens.dart';
import 'package:flutter_boilerplate/constants/strings.dart';
import 'package:flutter_boilerplate/models/music_data.dart';
import 'package:flutter_boilerplate/ui/widgets/util_widgets.dart';
import 'package:flutter_boilerplate/utils/string_util.dart';

class SaveSongScreen extends StatefulWidget {
  final bool saveToMemory;
  const SaveSongScreen({required this.saveToMemory});

  @override
  _SaveSongScreenState createState() => _SaveSongScreenState();
}

class _SaveSongScreenState extends State<SaveSongScreen> {
  late final MusicBloc _musicBloc;

  @override
  void initState() {
    super.initState();
    _musicBloc = BlocProvider.of<MusicBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.saveToMemory ? Strings.memory : Strings.filesystem,
        ),
      ),
      body: _buildBody(),
    );
  }

  BlocBuilder<MusicBloc, MusicState> _buildBody() {
    return BlocBuilder<MusicBloc, MusicState>(
      builder: (context, state) {
        if (state is MusicDataLoaded || _musicBloc.audioDataContainer != null) {
          return SafeArea(
            child: _buildBodyColumn(),
          );
        } else {
          return UtilWidgets.buildLoading();
        }
      },
    );
  }

  Widget _buildBodyColumn() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMusicDataListView(widget.saveToMemory
              ? _musicBloc.audioDataContainer!.audioFileData
              : _musicBloc.audioDataContainer!.audioFileData),
        ],
      ),
    );
  }

  Widget _buildMusicDataListView(List<AudioFileData> audioFileData) {
    if (audioFileData.isEmpty) {
      return UtilWidgets.buildNoContentText();
    }
    return ListView.separated(
      shrinkWrap: true,
      itemCount: audioFileData.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return _buildAudioDataListItem(audioFileData[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 5,
        );
      },
    );
  }

  Widget _buildAudioDataListItem(AudioFileData audioFileData) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Text(
        audioFileData.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
          '${StringUtil.formatBytesToMegabytes(audioFileData.sizeInBytes)} - ${StringUtil.formatDuration(audioFileData.duration)}'),
      trailing: _buildSaveButton(audioFileData),
    );
  }

  void _saveSong(bool saveToMemory, AudioFileData audioFileData) {
    if (saveToMemory) {
      _musicBloc.add(StoreSongToMemory(audioFileData));
    } else {
      _musicBloc.add(StoreSongToFilesystem(audioFileData));
    }
  }

  Widget _buildSaveButton(AudioFileData audioFileData) {
    return BlocBuilder<MusicBloc, MusicState>(
      bloc: _musicBloc,
      builder: (context, state) {
        if (state is SavingMusicData) {
          return UtilWidgets.buildListTileTrailingLoading();
        }

        return IconButton(
            onPressed: () => _saveSong(widget.saveToMemory, audioFileData),
            icon: _buildSaveIcon(audioFileData));
      },
    );
  }

  Widget _buildSaveIcon(AudioFileData audioFileData) {
    final bool isSaved = widget.saveToMemory
        ? _musicBloc.songsInMemory.contains(audioFileData)
        : _musicBloc.songsInFileSystem.contains(audioFileData);
    return Icon(
      isSaved ? Icons.check : Icons.save,
      color: isSaved ? Colors.grey : Colors.blue,
    );
  }
}
