import 'package:devoteam/models/projectModel.dart';
import 'package:devoteam/pages/commun%20pages/projectDetails.dart';
import 'package:devoteam/pages/consultant/missionListUser.dart';
import 'package:devoteam/services/missionService.dart';
import 'package:flutter/material.dart';

class ProjectAndMissionUser extends StatefulWidget {
  late Projet projet ;

  ProjectAndMissionUser({required this.projet});

  @override
  _ProjectAndMissionUserState createState() => _ProjectAndMissionUserState();
}

class _ProjectAndMissionUserState extends State<ProjectAndMissionUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Center(child: Text("Project details")),
        backgroundColor: Colors.white,


      ),
      body: Container(
        color: Colors.redAccent,
        child: Expanded(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05,),
              ProjectDetails(projet: widget.projet),
              SizedBox(height: MediaQuery.of(context).size.height*0.07,),
              MissionListUser(idProject: widget.projet.id,),
            ],
          ),
        ),
      ),

    );
  }
}
