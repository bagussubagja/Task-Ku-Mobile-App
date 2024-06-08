// ignore_for_file: await_only_futures, unused_local_variable, must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/provider/theme_provider.dart';
import 'package:task_ku_mobile_app/screens/page_state.dart';

Future<void> _handleBGNotification(RemoteMessage message) async {}

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestPermission();
  FirebaseMessaging.onBackgroundMessage(_handleBGNotification);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final themeProvider = ThemeProvider();
  await themeProvider.loadThemePreference();
  runApp(MyApp(
    themeProvider: themeProvider,
  ));
}

Future<void> requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    if (kDebugMode) {
      print('User granted permission');
    }
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    if (kDebugMode) {
      print('User granted provisional permission');
    }
  } else {
    if (kDebugMode) {
      print('User declined or has not accepted permission');
    }
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.themeProvider}) : super(key: key);

  ThemeProvider? themeProvider;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final lightTheme = ThemeData(
      brightness: Brightness.light,
      fontFamily: 'Poppins',
      colorSchemeSeed: Colors.blue);

  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Poppins',
      colorSchemeSeed: Colors.blue);
  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Navigator.of(context).pushNamed('/pagestate');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GoogleSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => widget.themeProvider,
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            routes: {
              'pagestate': (context) => const PageState(),
            },
            title: 'Task Ku Mobile App',
            theme: widget.themeProvider!.themeMode == ThemeMode.light
                ? lightTheme
                : darkTheme,
            initialRoute: 'pagestate',
          );
        },
      ),
    );
  }
}
