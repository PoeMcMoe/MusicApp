import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/constants/dimens.dart';
import 'package:flutter_boilerplate/models/music_data.dart';
import 'package:flutter_boilerplate/utils/string_util.dart';

class CategorySongScreen extends StatefulWidget {
  final List<AudioFileData> audioData;
  final String genre;
  const CategorySongScreen({required this.audioData, required this.genre});

  @override
  _CategorySongScreenState createState() => _CategorySongScreenState();
}

class _CategorySongScreenState extends State<CategorySongScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.genre),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(widget.genre),
          _buildSongsList(widget.audioData),
        ],
      ),
    );
  }

  Widget _buildHeader(String genre) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.afterAppBarTopPadding),
      child: Text(
        genre,
        style: TextStyle(fontSize: 22),
      ),
    );
  }

  Widget _buildSongsList(List<AudioFileData> audioData) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: audioData.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildSongListItem(audioData[index]);
      },
    );
  }

  Widget _buildSongListItem(AudioFileData audioData) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Text(
        audioData.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
          '${StringUtil.formatBytesToMegabytes(audioData.sizeInBytes)} - ${StringUtil.formatDuration(audioData.duration)}'),
    );
  }
}
