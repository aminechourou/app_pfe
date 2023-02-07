import 'package:devoteam/models/projectModel.dart';
import 'package:devoteam/pages/commun%20pages/projectDetails.dart';
import 'package:flutter/material.dart';

import 'missionListManager.dart';
class ProjectAndMissionManager extends StatefulWidget {
  late Projet projet ;
  ProjectAndMissionManager({required this.projet});

  @override
  _ProjectAndMissionManagerState createState() => _ProjectAndMissionManagerState();
}

class _ProjectAndMissionManagerState extends State<ProjectAndMissionManager> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
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
              MissionListManager(idProject: widget.projet.id,),
            ],
          ),
        ),
      ),

    );
  }
}
