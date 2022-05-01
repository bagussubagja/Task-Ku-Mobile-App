import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/provider/google_sign_in.dart';
import 'package:task_ku_mobile_app/screens/add_task_screen/add_task_screen.dart';
import 'package:task_ku_mobile_app/screens/body_screen/home.dart';
import 'package:task_ku_mobile_app/screens/body_screen/articles.dart';
import 'package:task_ku_mobile_app/widgets/nav_drawer.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ArticleScreen()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper), label: 'Article'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      drawer: NavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddTaskScreen();
          }));
        },
        child: const Icon(Icons.add),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(Icons.exit_to_app),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                final provider =
                                    Provider.of<GoogleSignInProvider>(context,
                                        listen: false);
                                provider.logout();
                              },
                              style:
                                  TextButton.styleFrom(primary: Colors.black),
                              child: const Text('Sign Out'),
                            ),
                          ],
                        ),
                      ),
                    ])
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
