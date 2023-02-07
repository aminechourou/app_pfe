import 'package:devoteam/pages/Dashboard/ManagerAndUserDashboard.dart';
import 'package:devoteam/pages/manager/userListManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commun pages/UserProfile.dart';
import '../login/login.dart';
import '../navigation/company.dart';
import '../navigation/navigationBarItem.dart';

class ManagerPanel extends StatefulWidget {
  late int index;


  ManagerPanel({Key? key, required this.index}) : super(key: key);

  @override
  _ManagerPanelState createState() => _ManagerPanelState();
}

class _ManagerPanelState extends State<ManagerPanel> {
  List<bool> selected = [true, false, false];
  List<Widget> selectedBody = [ManagerAndUserDashboard(),UserListManager(),UserProfile()];
  late Widget body ;
  @override
  void initState() {
    body = selectedBody[widget.index];
    select(widget.index);
    super.initState();
  }
  void select(int n) {
    for (int i = 0; i < 3; i++) {
      if (i != n) {
        selected[i] = false;

      } else {
        selected[i] = true;
        body= selectedBody[i];

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.07,
              color: Colors.grey.shade200,
              child: Stack(
                children: [
                  CompanyName(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 350.0,
                      child: Column(
                        children: [
                          NavBarItem(
                            icon: Feather.home,
                            active: selected[0],
                            touched: () {
                              setState(() {
                                select(0);


                              });
                            }, text: 'Home',
                          ),
                          NavBarItem(
                            icon: Feather.list,
                            active: selected[1],
                            touched: () {
                              setState(() {
                                select(1);


                              });
                            }, text: 'User List',
                          ),
                          NavBarItem(
                            icon: Feather.user,
                            active: selected[2],
                            touched: () {
                              setState(() {
                                select(2);

                              });
                            }, text: 'Profile',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: NavBarItem(
                      icon: Feather.log_out,
                      active: false, touched: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.clear();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {

                            return LoginPage();
                          },
                        ),
                      );
                    }, text: 'logout',
                    ),
                  ),
                ],
              ),
            ),
          ),
          body
        ],
      ),
    );
  }
}
