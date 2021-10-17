import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/constants/strings.dart';

class FileUtils {
  FileUtils._();

  static Future<List<String>> getMusicFilesPaths() async {
    final List<String> paths = [];

    final RegExp pathRegExp = RegExp(Strings.tracksPath);
    final String myAssets = await rootBundle.loadString(Strings.assetManifest);

    final Map<String, dynamic> map = json.decode(myAssets);
    map.removeWhere((key, value) =>
        !key.contains(pathRegExp)); //remove all keys that aren't desired files
    for (final String path in map.keys) {
      paths.add(path);
    }

    return paths;
  }
}
