import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/screens/intro_screen/intro_screen_two.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/1.jpg'),
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
                  colors: [Colors.black, Colors.black26],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.white),
                  )),
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
                              color: bluePrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
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
                              color: greyColor,
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
                                return ScreenTwo();
                              }));
                            },
                            child: Text(
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
