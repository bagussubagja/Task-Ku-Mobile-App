import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              Text(
                'About Us',
                style: titleBlackStyle,
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Lottie.network(
                    'https://assets8.lottiefiles.com/packages/lf20_ogsy6fuk.json'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Task-Ku Mobile App is a mobile-based application that can make it easy for you to organize and remember the tasks you have!',
                textAlign: TextAlign.center,
                style: regularBlackStyle,
              )
            ],
          ),
        ),
      )),
    );
  }
}
