
import 'package:devoteam/pages/Dashboard/Dashboard.dart';
import 'package:devoteam/pages/admin/addProject.dart';
import 'package:devoteam/pages/admin/addUser.dart';
import 'package:devoteam/pages/admin/usersList.dart';
import 'package:devoteam/pages/commun%20pages/UserProfile.dart';
import 'package:devoteam/pages/navigation/company.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login/login.dart';
import '../navigation/navigationBarItem.dart';
class AdminPanel extends StatefulWidget {
final int index;



const AdminPanel({Key? key, required this.index}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  

  List<bool> selected = [true, false, false, false, false];
  List<Widget> selectedBody = [Dashboard(),UserList(),AddUser(),AddProject(),UserProfile()];
   late Widget body ;
   @override
  void initState() {
    body = selectedBody[widget.index];
    select(widget.index);
    super.initState();
  }
  void select(int n) {
    for (int i = 0; i < 5; i++) {
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
                    child: SizedBox(
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
                            icon: Feather.user_plus,
                            active: selected[2],
                            touched: () {
                              setState(() {
                                select(2);
                              });
                            }, text: 'add user',
                          ),
                          NavBarItem(
                            icon: Feather.file_plus,
                            active: selected[3],
                            touched: () {
                              setState(() {
                                select(3);
                              });
                            }, text: 'add project',
                          ),
                          NavBarItem(
                            icon: Feather.user,
                            active: selected[4],
                            touched: () {
                              setState(() {
                                select(4);

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
