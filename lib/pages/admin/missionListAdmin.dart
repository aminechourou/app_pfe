import 'package:devoteam/models/MissionModel.dart';
import 'package:devoteam/services/missionService.dart';
import 'package:flutter/material.dart';

class AdminMissionList extends StatefulWidget {
  late int idProject;


  AdminMissionList({required this.idProject});

  @override
  _AdminMissionListState createState() => _AdminMissionListState();
}

class _AdminMissionListState extends State<AdminMissionList> {
  MissionService missionService = MissionService();
  late Future<List<Mission>> list;
  List<Mission> listMission=[];
  bool etat =false;
  @override
  void initState() {
   list = missionService.getMissionByProjects(widget.idProject);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: list,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          print(snapshot.data);
          if(snapshot.data == null){
            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(

              ),
            );
          }
          else {
            listMission =snapshot.data;
            return Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        dataRowHeight: MediaQuery.of(context).size.height*0.2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        columns: const [
                          DataColumn(label: Text("id_Mission")),
                          DataColumn(label: Text("user"),tooltip: "the user who work on the mission"),
                          DataColumn(label: Text("id_Mission"),tooltip: "the project that the mission belongs to"),
                          DataColumn(label: Text("realisation")),
                          DataColumn(label: Text("auto eval")),
                          DataColumn(label: Text("feedback manager")),
                          DataColumn(label: Text("etat")),

                        ],
                        rows: listMission.map((data){
                          if(data.etat.toString().compareTo("done")==0)
                            {etat = true;}
                          else {
                            etat =false;
                          }
                          return DataRow(
                              cells: [
                                DataCell(Text(data.id.toString())),
                                DataCell(Text(data.user)),
                                DataCell(Text(data.projet)),
                                DataCell(Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: Expanded(child: Text(data.realisation)))),
                                DataCell(Text(data.autoEval)),
                                DataCell(Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    child: Expanded(child: Text(data.feedBackManager)))),
                                DataCell((etat)
                                  ? const Icon(
                                  Icons.verified_user,
                                  color: Colors.green,
                                  )
                                  : const Icon(Icons.cancel, color: Colors.red)),
                              ]

                          );
                        }
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}
