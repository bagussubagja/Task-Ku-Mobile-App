import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/signin_screen.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.black26])),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 350, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get Productive Now!',
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Task-ku will be a friend who always accompanies you!',
                        style: regularStyle.copyWith(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: greyColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 15.0,
                            height: 15.0,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: bluePrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: SizedBox(
                        height: 50,
                        width: 220,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const SignInScreen();
                              }));
                            },
                            child: const Text(
                              'Get Started',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
