import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/main.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/routes/app_routes.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/forgotpw_screen.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/register_screen.dart';
import 'package:task_ku_mobile_app/shared/page_state.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: titleStyle.copyWith(color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Selamat datang di Task-ku!\nAplikasi yang dapat membuat tugasmu lebih mudah.',
                      textAlign: TextAlign.center,
                      style: regularStyle.copyWith(color: greyColor),
                    ),
                    Container(
                      height: 275,
                      width: double.infinity,
                      child: Lottie.network(
                          'https://assets3.lottiefiles.com/private_files/lf30_fw6h59eu.json'),
                    ),
                    InputField(
                      titleText: '',
                      controller: emailController,
                      hintText: "Enter your email...",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InputField(
                      titleText: '',
                      obsecureText: true,
                      controller: passwordController,
                      hintText: "Enter your password...",
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ForgotPasswordScreen();
                            }));
                          },
                          child: Text(
                            'Recovery Password',
                            style: TextStyle(fontSize: 12),
                          )),
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () async {
                            signIn();
                          },
                          child: Text(
                            'Sign In',
                            style: regularStyle,
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Dont have an account yet?',
                          style: regularStyle.copyWith(
                              color: greyColor, fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignUpScreen();
                              }));
                            },
                            child: Text('Register Now!')),
                      ],
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 1,
                          width: 120,
                          color: greyColor,
                        ),
                        Text('or'),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 1,
                          width: 120,
                          color: greyColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        // final provider = Provider.of<GoogleSignInProvider>(
                        //     context,
                        //     listen: false);
                        // provider.googleLogin();
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     AppRoute.HomeRoute, (route) => false);
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PageState();
                        }));
                      },
                      child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: bluePrimaryColor),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/google-logo.png',
                                scale: 35,
                              ),
                              Text(
                                'Login With Google',
                              )
                            ],
                          )),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (mounted) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      }
    } on FirebaseAuthException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
