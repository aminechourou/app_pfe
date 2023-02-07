import 'package:devoteam/pages/commun%20pages/DomaineCompetenceForm.dart';
import 'package:devoteam/pages/commun%20pages/EvalComiteForm.dart';
import 'package:devoteam/pages/consultant/myMissions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../Dashboard/ManagerAndUserDashboard.dart';
import '../commun pages/ObjectivesUserAndManagerForm.dart';
import '../commun pages/TrajectoireMangerAndUser.dart';
import '../commun pages/UserProfile.dart';
import '../commun pages/synthese_auto_eval.dart';
import '../commun pages/synthese_manager.dart';
import '../login/login.dart';
import '../navigation/company.dart';
import '../navigation/navigationBarItem.dart';
class UserPanel extends StatefulWidget {
  late int index;
  late String connectedUser;
  late String job;


  UserPanel({Key? key, required this.index,required this.connectedUser,required this.job}) : super(key: key);

  @override
  _UserPanelState createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  List<bool> selected = [true, false, false, false, false,false,false,false,false,false];

  List<Widget> selectedBody = [ManagerAndUserDashboard(),MyMissions(),CompanyName(),CompanyName(),UserProfile()];
  late Widget body ;
  late Widget rank;




  void select(int n) {
    for (int i = 0; i < 10; i++) {
      if (i != n) {
        selected[i] = false;

      } else {
        selected[i] = true;
        if(i==2){
          body = DcForm(user: widget.connectedUser, test: true, type: "rank");
        }
        else if(i==3)
          {
            body = DcForm(user: widget.connectedUser, test: true, type: "contributions");
          }
        else if(i==4)
          {
            body = Synthese_auto_eval(user: widget.connectedUser,test: true,);
          }
        else if(i==5)
        {
          body = Synthese_Manager(user: widget.connectedUser, test: true);
        }
        else if(i==6)
        {
          body =  Expanded(child: ObjectivesUserAndManagerForm(user: widget.connectedUser, role: true));
        }
        else if(i==7)
        {
          body = TrajectoireForm(userName: widget.connectedUser, job: widget.job, role: true);
        }
        else if(i==8)
        {
          body = EvalComiteForm(user: widget.connectedUser, role: true);
        }
        else {body= selectedBody[i];}

      }
    }
  }

  @override
  void initState() {
    body = selectedBody[widget.index];
    select(widget.index);

    super.initState();
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
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.8,
                      child: ListView(
                        children: [
                          Column(
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
                                }, text: 'My Missions',
                              ),
                              NavBarItem(
                                icon: Feather.star,
                                active: selected[2],
                                touched: () {
                                  setState(() {
                                    select(2);
                                  });
                                }, text: 'Eval Rank',
                              ),
                              NavBarItem(
                                icon: Feather.list,
                                active: selected[3],
                                touched: () {
                                  setState(() {
                                    select(3);
                                  });
                                }, text: 'Contribution',
                              ),
                              NavBarItem(
                                  icon: Feather.percent,
                                  touched: (){
                                    setState(() {
                                      select(4);



                                    });
                                  },
                                  active: selected[4], text: "Synthése auto eval"),
                              NavBarItem(
                                  icon: Feather.command,
                                  touched: (){
                                    setState(() {
                                      select(5);


                                    });
                                  },
                                  active: selected[5], text: "Synthése manager"),
                              NavBarItem(
                                  icon: Feather.target,
                                  touched: (){
                                    setState(() {
                                      select(6);



                                    });
                                  },
                                  active: selected[6], text: "Objectives"),
                              NavBarItem(
                                  icon: Feather.arrow_up,
                                  touched: (){
                                    setState(() {
                                      select(7);



                                    });
                                  },
                                  active: selected[7], text: "Trajectoire"),
                              NavBarItem(
                                  icon: Feather.film,
                                  touched: (){
                                    setState(() {
                                      select(8);



                                    });
                                  },
                                  active: selected[8], text: "Retour Comite"),
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
                        ],
                      )
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
