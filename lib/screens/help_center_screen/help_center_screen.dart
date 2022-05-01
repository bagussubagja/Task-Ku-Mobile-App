import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

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
                'Help Center',
                style: titleBlackStyle,
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: Lottie.network(
                    'https://assets1.lottiefiles.com/packages/lf20_oxhfz0em.json'),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
