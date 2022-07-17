//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sus_app/app_theme.dart';
import 'package:sus_app/models/models.dart';
import 'package:sus_app/navigation/app_router.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  /// Review: usages of [_appStateManager] and [_profileManager] are not necessary.
  /// Can just initialize them as properties of [_appRouter]
  /// E.g
  // late final AppRouter _appRouter;

  /// Review: This app router don't have to be initialized in [initState]
  /// It can be declear directly instead of [late].
  
  // @override
  // void initState() {
  //   _appRouter = AppRouter(
  //     appStateManager: AppStateManager(),
  //     profileManager: ProfileManager(),
  //   );
  //   super.initState();
  // }

  final AppRouter _appRouter = AppRouter(
      appStateManager: AppStateManager(),
      profileManager: ProfileManager(),
    );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppStateManager>(
          create: (context) => _appRouter.appStateManager,
        ),
        ChangeNotifierProvider<ProfileManager>(
          create: (context) => _appRouter.profileManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = AppTheme.dark();
          } else {
            theme = AppTheme.light();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'App',
            theme: theme,
            home: Router(
              routerDelegate: _appRouter,
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          );
        },
      ),
    );
  }
}
