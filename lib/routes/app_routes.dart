import 'package:task_ku_mobile_app/screens/auth_screen/signin_screen.dart';
import 'package:task_ku_mobile_app/screens/body_screen/body_screen.dart';
import 'package:task_ku_mobile_app/screens/intro_screen/intro_screen_one.dart';
import 'package:task_ku_mobile_app/screens/intro_screen/intro_screen_three.dart';
import 'package:task_ku_mobile_app/screens/intro_screen/intro_screen_two.dart';
import 'package:task_ku_mobile_app/shared/page_state.dart';

class AppRoute {
  static const String IntroScreenOneRoute = '/one';
  static const String IntroScreenTwoRoute = '/two';
  static const String IntroScreenFinalRoute = '/three';
  static const String LoginRoute = '/login';
  static const String HomeRoute = '/home';
  static const String AuthRoute = '/auth';

  static final routes = {
    IntroScreenOneRoute: (context) => ScreenOne(),
    IntroScreenTwoRoute: (context) => ScreenTwo(),
    IntroScreenFinalRoute: (context) => ScreenThree(),
    LoginRoute: (context) => SignInScreen(),
    HomeRoute: (context) => BodyScreen(),
    AuthRoute: (context) => PageState()
  };
}
