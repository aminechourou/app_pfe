import 'package:devoteam/pages/admin/DC_Admin.dart';
import 'package:devoteam/pages/admin/adminPanel.dart';
import 'package:devoteam/pages/admin/userDetailsAdmin.dart';
import 'package:devoteam/pages/commun%20pages/EvalComiteForm.dart';
import 'package:devoteam/pages/commun%20pages/TrajectoireMangerAndUser.dart';
import 'package:devoteam/pages/manager/userDetailsManager.dart';
import 'package:devoteam/widgets/navBarItemUserEval.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../models/userModel.dart';
import 'Objective_Admin.dart';
import 'SyntheseAutoEval_Admin.dart';
import 'SyntheseManager_Admin.dart';


class UserEvalAdmin extends StatefulWidget {
  final UserModel user;
  const UserEvalAdmin({Key? key, required this.user}) : super(key: key);


  @override
  _UserEvalAdminState createState() => _UserEvalAdminState();
}

class _UserEvalAdminState extends State<UserEvalAdmin> {
  List<bool> selected = [true, false, false, false, false,false,false,false];
  // List<Widget> selectedBody = [UserDetailsManager(user: widget.user),CompanyName(),CompanyName(),CompanyName(),CompanyName(),CompanyName()];
  late Widget body;
  void select(int n) {
    for (int i = 0; i < 8; i++) {
      if (i != n) {
        selected[i] = false;

      } else {
        selected[i] = true;


      }
    }
  }
  @override
  void initState() {
    body = UserDetailsManager(user: widget.user);
    select(0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=>AdminPanel(index: 1,)));
        }),
        title: const Center(child: Text("User Eval")),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height*0.12,
              width: MediaQuery.of(context).size.width*0.57,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Stack(
                children: [
                  Center(

                      child: ListView(children: [Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NavBarItemUserEval(
                              icon: Feather.user,
                              touched: (){setState(() {
                                select(0);
                                body = UserDetails(user: widget.user);


                              });},
                              active: selected[0], text: "User Deatails"),
                          NavBarItemUserEval(
                              icon: Feather.star,
                              touched: (){
                                setState(() {
                                  select(1);
                                  body = DcFormAdmin(user: widget.user.username,type: "rank");


                                });
                              },
                              active: selected[1], text: "Rank"),
                          NavBarItemUserEval(
                              icon: Feather.list,
                              touched: (){
                                setState(() {
                                  select(2);
                                  body = DcFormAdmin(user: widget.user.username,type: "contributions");


                                });
                              },
                              active: selected[2], text: "contributions"),
                          NavBarItemUserEval(
                              icon: Feather.percent,
                              touched: (){
                                setState(() {
                                  select(3);
                                  body = Synthese_auto_eval_Admin(user: widget.user.username,);


                                });
                              },
                              active: selected[3], text: "Synthése auto eval"),
                          NavBarItemUserEval(
                              icon: Feather.command,
                              touched: (){
                                setState(() {
                                  select(4);
                                  body = Synthese_Manager_Admin (user: widget.user.username);

                                });
                              },
                              active: selected[4], text: "Synthése manager"),
                          NavBarItemUserEval(
                              icon: Feather.target,
                              touched: (){
                                setState(() {
                                  select(5);
                                  body =  ObjectivesAdmin(user: widget.user.username);


                                });
                              },
                              active: selected[5], text: "Objectives"),
                          NavBarItemUserEval(
                              icon: Feather.arrow_up,
                              touched: (){
                                setState(() {
                                  select(6);
                                  body = TrajectoireForm(userName: widget.user.username, job: widget.user.job, role: true);


                                });
                              },
                              active: selected[6], text: "Trajectoire"),
                          NavBarItemUserEval(
                              icon: Feather.film,
                              touched: (){
                                setState(() {
                                  select(7);
                                  body = EvalComiteForm(user: widget.user.username, role: false);


                                });
                              },
                              active: selected[7], text: "Eval Comité"),


                        ],
                      ),],)
                  )
                ],
              ),
            ),
          ),
          Expanded(child: body)

        ],
      ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;

  const Choice({required this.title, required this.icon});
}
