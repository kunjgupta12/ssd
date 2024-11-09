import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upskill/course.dart';
import 'package:upskill/dashboard.dart';
import 'package:upskill/dialog.dart';
import 'package:upskill/main.dart';
import 'package:upskill/profile.dart';

import 'floating_button.dart';
import 'homepage.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({super.key});

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Course(),
    DashBoard(),
    Profile()
//    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    //  Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    //   Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: <NavigationDestination>[
          NavigationDestination(
            // selectedIcon: Icon(Icons.person),
            icon: Image.asset('assets/home.png'),
            label: 'Home',
          ),
          NavigationDestination(
            // selectedIcon: Icon(Icons.engineering),
            icon: Image.asset('assets/e-learning.png'),

            label: 'Courses',
          ),
          NavigationDestination(
            //selectedIcon: Icon(Icons.bookmark),
            icon: Image.asset('assets/chart-histogram.png'),
            label: 'Dashboard',
          ),
          NavigationDestination(
            label: 'Profile',
            //  selectedIcon: Icon(Icons.bookmark),

            icon: GestureDetector(
                onTap: () {
                  if (_selectedIndex == 3) {
                    customShowDialog(context);
                  }
                },
                child: Image.asset('assets/square-plus 1.png')),
          ),
        ],
      ),
    );
  }
}
