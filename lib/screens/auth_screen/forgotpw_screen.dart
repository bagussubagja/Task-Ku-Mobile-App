import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';

import '../../main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              Text(
                'Forgot Password',
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
              SizedBox(height: 20),
              Container(
                height: 250,
                width: double.infinity,
                child: Lottie.network(
                    'https://assets2.lottiefiles.com/packages/lf20_teaf529w.json'),
              ),
              SizedBox(height: 20),
              InputField(
                titleText: '',
                controller: emailController,
                hintText: "Enter your email...",
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      resetPassword();
                    },
                    child: Text(
                      'Reset Password',
                      style: regularStyle,
                    )),
              ),
            ],
          ),
        ),
      )),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // if (mounted) {
      //   showDialog(
      //       context: context,
      //       barrierDismissible: false,
      //       builder: (context) => Center(
      //             child: CircularProgressIndicator(),
      //           ));
      // }
    } on FirebaseAuthException catch (e) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Check your email to reset your password!')));
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
