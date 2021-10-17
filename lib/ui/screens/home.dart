import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/bloc/music/music_bloc.dart';
import 'package:flutter_boilerplate/constants/app_colors.dart';
import 'package:flutter_boilerplate/constants/dimens.dart';
import 'package:flutter_boilerplate/constants/strings.dart';
import 'package:flutter_boilerplate/models/audio_data_container.dart';
import 'package:flutter_boilerplate/models/music_data.dart';
import 'package:flutter_boilerplate/ui/screens/category_song_screen.dart';
import 'package:flutter_boilerplate/ui/screens/save_song_screen.dart';
import 'package:flutter_boilerplate/ui/widgets/util_widgets.dart';
import 'package:flutter_boilerplate/utils/device_utils.dart';
import 'package:flutter_boilerplate/utils/string_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MusicBloc? _musicBloc;

  @override
  void initState() {
    super.initState();

    _musicBloc = BlocProvider.of<MusicBloc>(context)..add(LoadMusicData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: BlocBuilder(
        bloc: _musicBloc,
        builder: (BuildContext context, state) {
          if (state is MusicDataLoaded ||
              _musicBloc!.audioDataContainer != null) {
            return _buildBodyListView(_musicBloc!.audioDataContainer!);
          }
          return UtilWidgets.buildLoading();
        },
      ),
    );
  }

  Widget _buildBodyListView(AudioDataContainer musicDataContainer) {
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.horizontal_padding / 2,
        vertical: Dimens.horizontal_padding / 2,
      ),
      children: [
        _buildCategories(musicDataContainer),
        _buildStorageLabel(),
        _buildStorageButtons()
      ],
    );
  }

  Widget _buildCategories(AudioDataContainer musicDataContainer) {
    final Map<String, List<AudioFileData>> genreFileMap =
        musicDataContainer.getGenreFileMap();

    if (genreFileMap.keys.isEmpty) {
      return UtilWidgets.buildNoContentText(
          text: 'No songs in assets folder detected...');
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: genreFileMap.keys.length,
      itemBuilder: (BuildContext context, int index) {
        final String genre = genreFileMap.keys.toList()[index];
        return _buildCategoryCard(genre, genreFileMap[genre]);
      },
    );
  }

  Widget _buildCategoryCard(String genreId, List<AudioFileData>? genreFileMap) {
    return Card(
      child: Column(
        children: [
          _buildCategoryCardHeader(genreId, genreFileMap),
          _buildCategoryCardInnerList(genreFileMap),
        ],
      ),
    );
  }

  Row _buildCategoryCardHeader(
      String genreId, List<AudioFileData>? genreFileMap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildGenreLabel(genreId),
        _buildSeeAllButton(genreFileMap, genreId),
      ],
    );
  }

  Padding _buildGenreLabel(String genreId) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimens.horizontal_padding),
      child: Text(
        genreId,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSeeAllButton(List<AudioFileData>? genreFileMap, String genreId) {
    return Padding(
      padding: const EdgeInsets.only(right: Dimens.horizontal_padding / 2),
      child: ElevatedButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CategorySongScreen(
                      audioData: genreFileMap!, genre: genreId))),
          child: const Text(
            Strings.seeAll,
            style: TextStyle(fontSize: 14),
          )),
    );
  }

  Widget _buildCategoryCardInnerList(List<AudioFileData>? genreFileMap) {
    final int listLength = _getCategoryCardInnerListLength(genreFileMap);
    final double cardHeight = DeviceUtils.getScaledHeight(context, scale: 0.25);
    final double cardWidth = DeviceUtils.getScaledWidth(context, scale: 0.4);

    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        itemCount: listLength,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _buildCategoryCardSongItem(
              genreFileMap![index], cardHeight, cardWidth);
        },
      ),
    );
  }

  int _getCategoryCardInnerListLength(List<AudioFileData>? genreFileMap) {
    int length = 0;
    if (genreFileMap?.length != null) {
      length = genreFileMap!.length <= 5 ? genreFileMap.length : 5;
    }
    return length;
  }

  Widget _buildCategoryCardSongItem(
      AudioFileData audioFileData, double cardHeight, double cardWidth) {
    final double imageHeight = cardHeight * 0.4;
    final double textHeight = cardHeight * 0.15;

    return SizedBox(
      width: cardWidth,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: const EdgeInsets.all(Dimens.default_margin / 4),
        elevation: 3,
        child: Column(
          children: [
            _buildCardImage(imageHeight, cardWidth, audioFileData.imageBytes),
            _buildSongTitle(audioFileData.name, textHeight),
            _buildSizeInfo(audioFileData.sizeInBytes, audioFileData.duration),
          ],
        ),
      ),
    );
  }

  Container _buildCardImage(
      double imageHeight, double imageWidth, Uint8List? imageBytes) {
    final bool hasImage = imageBytes != null;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primary.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      margin: const EdgeInsets.all(Dimens.cardContentPadding / 2),
      padding: !hasImage
          ? const EdgeInsets.all(Dimens.cardContentPadding / 2)
          : null,
      child: _getImage(imageBytes, imageHeight, imageWidth),
    );
  }

  Widget _buildSongTitle(String name, double textHeight) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimens.cardContentPadding / 2),
      child: LimitedBox(
        maxHeight: textHeight,
        child: Text(
          name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildSizeInfo(int sizeInBytes, Duration duration) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimens.cardContentPadding / 2,
            right: Dimens.cardContentPadding / 2,
            bottom: Dimens.cardContentPadding / 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(StringUtil.formatBytesToMegabytes(sizeInBytes)),
              Text(StringUtil.formatDuration(duration)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getImage(
      Uint8List? imageBytes, double imageHeight, double imageWidth) {
    if (imageBytes == null) {
      return Image.asset(
        Strings.placeholderImage,
        height: imageHeight - Dimens.cardContentPadding,
        width: imageWidth - Dimens.cardContentPadding,
      );
    } else {
      return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Image.memory(
          imageBytes,
          height: imageHeight,
          width: imageWidth,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget _buildStorageLabel() {
    return const Padding(
      padding: EdgeInsets.all(Dimens.default_margin),
      child: Text(
        Strings.storage,
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildStorageButtons() {
    return Column(
      children: ListTile.divideTiles(context: context, tiles: [
        _buildStorageChoiceButton(
          Strings.memory,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SaveSongScreen(
                saveToMemory: true,
              ),
            ),
          ),
          _getCombinedDuration(true),
        ),
        _buildStorageChoiceButton(
          Strings.filesystem,
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SaveSongScreen(
                saveToMemory: false,
              ),
            ),
          ),
          _getCombinedDuration(false),
        ),
      ]).toList(),
    );
  }

  Widget _buildStorageChoiceButton(
      String title, void Function()? onTap, Duration duration) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
          ),
        ],
      ),
      trailing: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                StringUtil.formatDuration(
                  duration,
                ),
              ),
              const Icon(
                Icons.chevron_right,
              ),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  Duration _getCombinedDuration(bool memory) {
    int durationInMs = 0;
    if (memory) {
      for (final AudioFileData data in _musicBloc!.songsInMemory) {
        durationInMs += data.duration.inMilliseconds;
      }
      return Duration(milliseconds: durationInMs);
    } else {
      for (final AudioFileData data in _musicBloc!.songsInFileSystem) {
        durationInMs += data.duration.inMilliseconds;
      }
      return Duration(milliseconds: durationInMs);
    }
  }
}
