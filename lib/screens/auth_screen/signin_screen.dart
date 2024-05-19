import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/main.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
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
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: titleStyle.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Welcome to Task-ku Mobile App!\nAn application that can make your task easier.',
                      textAlign: TextAlign.center,
                      style: regularStyle.copyWith(color: greyColor),
                    ),
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Lottie.network(
                          'https://assets1.lottiefiles.com/packages/lf20_umqaz2yv.json'),
                    ),
                    InputField(
                      titleText: '',
                      controller: emailController,
                      hintText: "Enter your email...",
                    ),
                    const SizedBox(
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
                              return const ForgotPasswordScreen();
                            }));
                          },
                          child: const Text(
                            'Recovery Password',
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          )),
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue),
                          onPressed: () async {
                            signIn();
                          },
                          child: Text(
                            'Sign In',
                            style: regularWhiteStyle,
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
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.blue),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SignUpScreen();
                              }));
                            },
                            child: const Text('Register Now!')),
                      ],
                    ),
                    const Divider(),
                    Text(
                      'or sign in with',
                      style: regularBlackStyle.copyWith(
                          color: greyColor, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const PageState();
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/images/google-logo.png',
                                scale: 35,
                              ),
                              const Text(
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
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
