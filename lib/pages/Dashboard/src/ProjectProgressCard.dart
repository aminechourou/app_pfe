import 'package:devoteam/pages/admin/projectAndMissionsAdmin.dart';
import 'package:devoteam/pages/consultant/projectAndMissionUser.dart';
import 'package:devoteam/pages/manager/projectAndMissionManager.dart';
import 'package:devoteam/services/missionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/MissionModel.dart';
import '../../../models/projectModel.dart';

class ProjectProgressCard extends StatefulWidget {

  final Color progressIndicatorColor;
  final Projet projet;
  final String percentComplete;
  final IconData icon;

  ProjectProgressCard({

    required this.progressIndicatorColor,
    required this.percentComplete,
    required this.projet,
    required this.icon

  });
  @override
  _ProjectProgressCardState createState() => _ProjectProgressCardState();
}

class _ProjectProgressCardState extends State<ProjectProgressCard> {
  bool hovered = false;
  Color color = Colors.redAccent;
  MissionService missionService = MissionService();
  int count =0;
  double percent = 00.1;
  bool test =false;
  List<Mission> list =[];
  late String role;
  late Widget body;




  @override
  void initState() {
    if(widget.projet.etat.compareTo("regie")==0) {
      color =Colors.greenAccent;

      }
    missionService.getMissionByProjects(widget.projet.id).then((value) {
      list.addAll(value);
      for(Mission m in list)
      {
      if(m.etat.compareTo("done")==0){

        count=count+1;

      }
      percent = (count/list.length)*100;

      if(percent!=0){test=true;}
      }
    });
    getRole().then((value) {
    setState(() {
      role =value!;
      switch(role.toUpperCase()){
        case "ROLE_USER": body = ProjectAndMissionUser(projet: widget.projet);
             break;
        case "ROLE_MANAGER": body = ProjectAndMissionManager(projet: widget.projet);
             break;
        case "ROLE_ADMIN":body = ProjectAndMissionsAdmin(projet: widget.projet);
             break;
        case "ROLE_SUPER_ADMIN":body = ProjectAndMissionsAdmin(projet: widget.projet);

      }
    });
    });


    super.initState();
  }
  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    String? role =prefs.getString("role");
    return role;
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>body));
      },
      child: MouseRegion(
        onEnter: (value) {
          setState(() {
            hovered = true;
          });
        },
        onExit: (value) {
          setState(() {
            hovered = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 275),
          height: hovered ? 160.0 : 155.0,
          width: hovered ? 200.0 : 195.0,
          decoration: BoxDecoration(
              color: hovered ? color : Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  spreadRadius: 5.0,
                ),
              ]),

          child: Center(
            child: ListView(
              children: [Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18.0,
                      ),
                      Container(
                        height: 30.0,
                        width: 30.0,
                        child: Icon(
                          widget.icon,
                          color: !hovered ? Colors.white : Colors.black,
                          size: 16.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: hovered ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 13.0,
                      ),
                      Container(
                        child: Text(
                          widget.projet.titre,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: hovered ? Colors.white : Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 18.0,
                      ),
                      Container(
                        height: 13.0,
                        width: 13.0,
                        child: Icon(
                          Feather.user,
                          size: 13.0,
                          color: hovered ? Colors.white : Colors.black,

                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        child: Text(
                          'Client: '+widget.projet.client,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.0,
                            color: hovered ? Colors.white : Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18.0,
                      ),
                      Container(
                        height: 13.0,
                        width: 13.0,
                        child: Icon(
                          Feather.clock,
                          size: 13.0,
                          color: hovered ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        child: Text(
                          "durée: "+widget.projet.dure,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.0,
                            color: hovered ? Colors.white : Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 18.0,
                      ),
                      Container(
                        height: 13.0,
                        width: 13.0,
                        child: Icon(
                          Feather.server,
                          size: 13.0,
                          color: hovered ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Container(
                        child: Text(
                          "chef: "+widget.projet.chef,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.0,
                            color: hovered ? Colors.white : Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0, left: 135.0),
                    child: Text(
                      count.toString()+"/"+list.length.toString(),
                      style: GoogleFonts.quicksand(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5,
                        color: hovered ? Colors.white : Colors.black,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 275),
                    margin: EdgeInsets.only(top: 5.0),
                    height: 6.0,
                    width: 160.0,
                    decoration: BoxDecoration(
                      color: hovered
                          ? widget.progressIndicatorColor
                          : Color(0xffF5F6FA),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 275),
                        height: 6.0,
                        width:(test)
                            ? (double.parse(percent.toString().substring(0, 1)) / 10) * 160.0
                            : 0.1,
                        decoration: BoxDecoration(
                          color: hovered ? Colors.white : color,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),],
            )
          ),
        ),
      ),
    );
  }
}
