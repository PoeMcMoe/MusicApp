import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class AudioFileData extends Equatable {
  final String name;
  final String genre;
  final int sizeInBytes;
  final Duration duration;
  final Uint8List? imageBytes;

  const AudioFileData({
    required this.name,
    required this.genre,
    required this.sizeInBytes,
    required this.duration,
    this.imageBytes,
  });

  @override
  List<Object?> get props => [
        name,
        genre,
        sizeInBytes,
        duration,
        imageBytes,
      ];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'genre': genre,
      'sizeInBytes': sizeInBytes,
      'duration': duration.inMilliseconds,
      'imageBytes': imageBytes != null
          ? String.fromCharCodes(imageBytes!.toList())
          : null,
    };
  }

  factory AudioFileData.fromMap(Map<String, dynamic> map) {
    return AudioFileData(
      name: map['name'],
      genre: map['genre'],
      sizeInBytes: map['sizeInBytes'],
      duration: Duration(milliseconds: map['duration']),
      imageBytes: map['imageBytes'] != null
          ? Uint8List.fromList((map['imageBytes'] as String).codeUnits)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AudioFileData.fromJson(String source) =>
      AudioFileData.fromMap(json.decode(source));
}
