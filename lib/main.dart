import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/routes/app_routes.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/signin_screen.dart';
import 'package:task_ku_mobile_app/screens/intro_screen/intro_screen_one.dart';
import 'package:task_ku_mobile_app/shared/page_state.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Ku Mobile App',
        theme: ThemeData(fontFamily: 'Poppins'),
        home: PageState(),
      ),
    );
  }
}
