import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/routes/app_routes.dart';
import 'package:task_ku_mobile_app/screens/auth_screen/signin_screen.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class ScreenThree extends StatelessWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/3.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.black26])),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
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
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Task-ku menawarkan layanan yang dapat membuat kamu menjadi lebih produktif\ndaripada sebelumnya!',
                        style: regularStyle.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: greyColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            width: 15.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: bluePrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Container(
                        height: 50,
                        width: 220,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInScreen();
                              }));
                            },
                            child: Text(
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
