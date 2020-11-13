

import 'package:flutter/material.dart';

class MyBottomNavigator extends StatefulWidget {
  MyBottomNavigator({Key key, this.selectedIndex}) : super(key: key);

  final Function selectedIndex;
  @override
  _MyBottomNavigatorState createState() => _MyBottomNavigatorState();
}

class _MyBottomNavigatorState extends State<MyBottomNavigator> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm_on),
          label: 'Time',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.drafts),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Group',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'More',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey[700],
      showUnselectedLabels: true,
      showSelectedLabels: true,
      onTap: _onItemTapped,
    );
  }
  void _onItemTapped(int index) async{
    _selectedIndex = index;
    widget.selectedIndex(_selectedIndex);
  }
}