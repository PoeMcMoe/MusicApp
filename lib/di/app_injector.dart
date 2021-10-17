import 'package:flutter_boilerplate/data/api/music_api.dart';
import 'package:get_it/get_it.dart';

import '../../data/repository.dart';

class AppInjector {
  static GetIt getIt = GetIt.instance;

  static void setupInjector() {
    _setupApis();
    _setupRepo();
  }

  static void _setupApis() {
    getIt.registerSingleton(MusicApi());
  }

  static void _setupRepo() {
    getIt.registerSingleton<Repository>(Repository(
      getIt<MusicApi>(),
    ));
  }
}
