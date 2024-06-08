import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
import 'package:task_ku_mobile_app/widgets/input_field.dart';

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
        title: Text(
          'Forgot Password',
          style: titleStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
          child: Column(
            children: [
              Text(
                'Welcome to Task-ku Mobile App!\nAn application that can make your task easier.',
                textAlign: TextAlign.center,
                style: regularStyle.copyWith(color: greyColor),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Lottie.network(
                    'https://assets2.lottiefiles.com/packages/lf20_teaf529w.json'),
              ),
              const SizedBox(height: 20),
              InputField(
                titleText: '',
                controller: emailController,
                hintText: "Enter your email...",
              ),
              const Spacer(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: emailController.text.isNotEmpty
                        ? () async {
                            resetPassword();
                          }
                        : null,
                    child: Text(
                      'Reset Password',
                      style: regularStyle,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message.toString())));
      }
    }
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Check your email to reset your password!')));
    }
  }
}
