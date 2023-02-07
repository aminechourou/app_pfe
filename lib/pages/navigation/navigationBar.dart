import 'package:devoteam/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import 'company.dart';
import 'navBarController.dart';
import 'navigationBarItem.dart';


class NavigationBarr extends StatefulWidget {

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarr> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: 120.0,
        color: Colors.grey.shade200,
        child: Stack(
          children: [
            CompanyName(),
            Align(
              alignment: Alignment.center,
              child: NavBar(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: NavBarItem(
                icon: Feather.log_out,
                active: false, touched: ()=>{
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) {
              return LoginPage();
              },
              ),
              )
              }, text: 'logout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}