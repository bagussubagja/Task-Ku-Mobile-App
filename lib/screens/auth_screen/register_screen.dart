import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/signin_screen.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Register',
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
                          'https://assets1.lottiefiles.com/packages/lf20_jcikwtux.json'),
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
                      controller: passwordController,
                      hintText: "Enter your password...",
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
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
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInScreen();
                              }));
                            },
                            child: Text('Login Now!')),
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
                          width: 115,
                          color: greyColor,
                        ),
                        Text('or Sign up With'),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 1,
                          width: 115,
                          color: greyColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: bluePrimaryColor),
                                color: Colors.white),
                            child: Image.asset(
                              'assets/images/google-logo.png',
                              scale: 25,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: bluePrimaryColor),
                                color: Colors.white),
                            child: Image.asset(
                              'assets/images/google-logo.png',
                              scale: 25,
                            ),
                          ),
                        ),
                      ],
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
}
