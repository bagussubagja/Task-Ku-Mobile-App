import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_ku_mobile_app/provider/theme_provider.dart';
import 'package:task_ku_mobile_app/screens/add_task_screen/add_task_screen.dart';
import 'package:task_ku_mobile_app/screens/body_screen/home.dart';
import 'package:task_ku_mobile_app/screens/article/articles.dart';
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
      drawer: NavDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AddTaskScreen(
              isEdit: false,
            );
          }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          leading: Consumer<ThemeProvider>(
            builder: (context, value, child) {
              return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(
                    Icons.menu,
                    color: value.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ));
            },
          ),
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, value, child) {
                return IconButton(
                    onPressed: () {
                      value.toggleTheme();
                    },
                    icon: value.themeMode == ThemeMode.light
                        ? const Icon(Icons.dark_mode)
                        : const Icon(
                            Icons.light_mode,
                            color: Colors.white,
                          ));
              },
            )
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
