import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/signin_screen.dart';
import 'package:task_ku_mobile_app/screens/intro_screen/intro_screen_three.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/2.jpg'),
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
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const SignInScreen();
                    }));
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.white),
                  )),
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
                        'Organize it like never before!',
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Task-ku will help you organize and remember your tasks!',
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
                            decoration: BoxDecoration(
                              color: bluePrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: greyColor,
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
                                return const ScreenThree();
                              }));
                            },
                            child: const Text(
                              'Next',
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
