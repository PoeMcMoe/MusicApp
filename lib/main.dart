import 'package:flutter_boilerplate/di/app_injector.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boilerplate/constants/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../ui/screens/home.dart';
import 'bloc/music/music_bloc.dart';
import 'data/repository.dart';

GetIt getIt = GetIt.instance;
SharedPreferences? sharedPrefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppInjector.setupInjector();
  sharedPrefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => MusicBloc(
            sharedPrefs!,
            repository: getIt<Repository>(),
          ),
        )
      ],
      child: MaterialApp(
        theme: AppTheme.themeData,
        darkTheme: AppTheme.themeDataDark,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
      ),
    );
  }
}
