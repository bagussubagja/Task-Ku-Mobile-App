import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/main.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/signin_screen.dart';
import 'package:task_ku_mobile_app/screens/page_state.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/utils/utils.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Utils.hideKeyboard();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Register',
                        style: titleStyle,
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
                        height: 275,
                        width: double.infinity,
                        child: Lottie.network(
                            'https://assets1.lottiefiles.com/packages/lf20_jcikwtux.json'),
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
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: emailController.text.isNotEmpty &&
                                    passwordController.text.isNotEmpty
                                ? () async {
                                    await signUp();
                                  }
                                : null,
                            child: Text(
                              'Register',
                              style: regularStyle,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Already have an account?',
                            style: regularStyle.copyWith(
                                color: greyColor, fontSize: 14),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const SignInScreen();
                                }));
                              },
                              child: const Text('Login Now!')),
                        ],
                      ),
                      const Divider(),
                      Text(
                        'or register with',
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
                                color: Colors.transparent),
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
      ),
    );
  }

  Future signUp() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    } finally {
      if (mounted) {
        Navigator.pop(context);
      }
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
