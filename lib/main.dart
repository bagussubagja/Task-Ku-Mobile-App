import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/screens/notif_screen/notif_firebase_screen.dart';
import 'package:task_ku_mobile_app/shared/page_state.dart';

Future<void> _handleBGNotification(RemoteMessage message) async {
  print("BACKGROUND NOTIF LISTENING");
  print(message.notification);
  print('-----------------------------');
  print("Handling a background message: ${message.messageId}");
}

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await requestPermission();
  FirebaseMessaging.onBackgroundMessage(_handleBGNotification);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  runApp(MyApp());
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
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState

    // ketika notif di klik dan keadaannya on terminated
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message.data);
        print(message.notification?.title);
        var _routeName = message.data['route'];
        print(_routeName);
        Navigator.of(context).pushNamed('/fcm-page');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        routes: {'/fcm-page': (_) => NotifFirebaseScreen()},
        title: 'Task Ku Mobile App',
        theme: ThemeData(fontFamily: 'Poppins'),
        home: PageState(),
      ),
    );
  }
}
