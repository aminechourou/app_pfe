import 'package:devoteam/pages/Dashboard/Dashboard.dart';
import 'package:devoteam/pages/admin/addUser.dart';
import 'package:devoteam/pages/login/login.dart';
import 'package:devoteam/pages/navigation/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'navigationBarItem.dart';


class NavBar extends StatefulWidget {

  late Widget body ;
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  List<bool> selected = [true, false, false, false, false];
  List<Widget> selectedBody = [Dashboard(),CompanyName()];
  late Widget body= selectedBody[0];
  void select(int n) {
    for (int i = 0; i < 5; i++) {
      if (i != n) {
        selected[i] = false;

      } else {
        selected[i] = true;

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      child: Column(
        children: [
          NavBarItem(
            icon: Feather.home,
            active: selected[0],
            touched: () {
              setState(() {
                select(0);
                body = selectedBody[0];

              });
            }, text: 'Home',
          ),
          NavBarItem(
            icon: Feather.list,
            active: selected[1],
            touched: () {
              setState(() {
                select(1);
                widget.body = selectedBody[1];

              });
            }, text: 'User List',
          ),
          NavBarItem(
            icon: Feather.user_plus,
            active: selected[2],
            touched: () {
              setState(() {
                select(2);
              });
            }, text: 'add user',
          ),
          NavBarItem(
            icon: Feather.message_square,
            active: selected[3],
            touched: () {
              setState(() {
                select(3);
              });
            }, text: 'message',
          ),
          NavBarItem(
            icon: Feather.settings,
            active: selected[4],
            touched: () {
              setState(() {
                select(4);
              });
            }, text: 'settings',
          ),
        ],
      ),
    );
  }
}