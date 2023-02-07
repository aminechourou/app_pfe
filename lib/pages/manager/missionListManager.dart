import 'package:devoteam/models/MissionModel.dart';
import 'package:devoteam/services/missionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../models/userModel.dart';
import '../../services/userService.dart';

class MissionListManager extends StatefulWidget {
  late int idProject;

  MissionListManager({required this.idProject});

  @override
  _MissionListManagerState createState() => _MissionListManagerState();
}

class _MissionListManagerState extends State<MissionListManager> {
  MissionService missionService = MissionService();
  //late Future<List<Mission>> list;
  List<Mission> listMission=[];
  bool etat =false;
  TextEditingController controller =TextEditingController();
  UserService userService =UserService();
  List<String> userNameList = ["Choisir le responsable"];
  late List<UserModel> usersList;
  String userNameValue = "Choisir le responsable";

  void fetch(){

    userService.getListUsersByManager("").then((value){
      setState(() {
        usersList= value;
        userNameList = ["Choisir le responsable"];
        userNameList.addAll(userService.getUsersNamesByManager(usersList));
      });

    });
  }


  @override
  void initState() {
    missionService.getMissionByProjects(widget.idProject).then((value) {
      setState(() {
        listMission =value;
      });
    });
    fetch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(

                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                                dataRowHeight: MediaQuery.of(context).size.height*0.2,
                                decoration:  BoxDecoration(
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
                              DataColumn(label: Text("delete")),

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
                                    DataCell(InkWell(
                                      child:
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Expanded(
                                          child: RichText(
                                            text: TextSpan(

                                              children:
                                              [ TextSpan(text: data.realisation),
                                                const WidgetSpan(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                    child: Icon(Feather.edit),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        setState(() {
                                          showDialog(context: context,
                                              builder: (BuildContext context) {
                                                return updateMissionDialog('Realisation',controller,data);
                                              });
                                        });
                                      },
                                    ),),
                                    DataCell(Text(data.autoEval)),
                                    DataCell(InkWell(
                                      child:
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children:
                                              [ TextSpan(text: data.feedBackManager),
                                                const WidgetSpan(
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                    child: Icon(Feather.edit),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      onTap: (){
                                        if(data.etat.compareTo("done")==0){

                                          showDialog(context: context,
                                              builder: (BuildContext context) {
                                                return updateMissionDialog('FeedBack',controller,data);

                                              });
                                        }
                                        else {
                                          const snackBar = SnackBar(content: Text("Mission must be done first"),);
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }

                                      },
                                    ),),
                                    DataCell((etat)
                                        ? const Icon(
                                      Icons.verified_user,
                                      color: Colors.green,
                                    )
                                        :  InkWell(
                                             child: const Icon(Icons.cancel, color: Colors.red),
                                             onTap:(){
                                               showDialog(context: context,
                                                   builder: (BuildContext context) {
                                                     return updateMissionEtatDialog( data);
                                                   });



                                             } ,)),
                                    DataCell(InkWell(
                                      child: const Icon(Feather.trash_2,color: Colors.redAccent),
                                      onTap: (){
                                        showDialog(context: context,
                                            builder: (BuildContext context) {
                                              return deleteMissionDialog(data);
                                            });
                                      },
                                    ))
                                  ]

                              );
                            }
                            ).toList(),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Align(alignment: Alignment.bottomCenter,
                            child: FloatingActionButton.extended(
                              onPressed: (){showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return addMissionDialog();
                                  });},
                              backgroundColor: Colors.white,
                              icon: const Icon(Feather.plus,color: Colors.redAccent,),
                              label: const Text("Add mission",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
                            ),)
                      ],
                    ),
                  ),
                ),
  );}

  Widget updateMissionDialog(String type,TextEditingController controller,Mission m ){
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height *0.5 ,
              width: MediaQuery.of(context).size.width *0.5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('Update your '+type+' !!!', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),


                    Container(
                      width: MediaQuery.of(context).size.width *0.4,
                      child: TextField(
                        controller: controller,
                        maxLines: 5,
                        decoration:  InputDecoration(
                          label: Text(type),
                          hintText: "Please give the "+type,


                        ),

                      ),
                    ),


                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          if(type.compareTo("FeedBack")==0){

                            missionService.updateFeedbackMission(m.id, controller.text, context).then((value)
                            {setState(() {
                              int index = listMission.indexOf(m);
                              listMission[index] = value!;

                            });

                            });

                          }
                          else if(type.compareTo("Realisation")==0){
                            missionService.updateRealisationMission(m.id, controller.text, context).then((value)
                            {setState(() {
                              int index = listMission.indexOf(m);
                              listMission[index] = value!;

                            });

                            });}
                          Navigator.of(context).pop();
                          controller.text="";
                        },

                          color: Colors.greenAccent,
                          child: RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.check),
                                  ),
                                ),
                                TextSpan(text: 'update ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                        RaisedButton(onPressed: () {
                          Navigator.of(context).pop();
                          controller.text="";
                        },
                          color: Colors.redAccent,
                          child: RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.x),
                                  ),
                                ),
                                TextSpan(text: 'cancel ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 60,
                  child: Icon(Icons.error_rounded, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
  Widget updateMissionEtatDialog(Mission m){
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width*0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text('Warning !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    const Text("Do you want to mark this mission as done", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          missionService.updateEtatMission(m.id, context).then((value)
                          {setState(() {
                            int index = listMission.indexOf(m);
                            listMission[index] = value!;


                          });

                          });
                          Navigator.of(context).pop();
                        },
                          color: Colors.greenAccent,
                          child:  RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.check),
                                  ),
                                ),
                                TextSpan(text: 'mark as done ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                        RaisedButton(onPressed: () {
                          Navigator.of(context).pop();
                        },
                          color: Colors.redAccent,
                          child: RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.x),
                                  ),
                                ),
                                TextSpan(text: 'cancel ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 60,
                  child: Icon(Icons.error_rounded, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
  Widget deleteMissionDialog(Mission m ) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width*0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text('Warning !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    const Text("Do you want to delete this mission", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          missionService.deleteMission(m.id, context);
                          setState(() {
                            listMission.remove(m);
                          });
                          Navigator.of(context).pop();
                        },
                          color: Colors.greenAccent,
                          child:  RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.check),
                                  ),
                                ),
                                TextSpan(text: 'delete ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                        RaisedButton(onPressed: () {
                          Navigator.of(context).pop();
                        },
                          color: Colors.redAccent,
                          child: RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.x),
                                  ),
                                ),
                                TextSpan(text: 'cancel ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(Icons.error_rounded, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
  Widget addMissionDialog(){
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height *0.5 ,
              width: MediaQuery.of(context).size.width *0.5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text('Add a mission to this project  !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    DropdownButton<String>(
                      value: userNameValue,
                      icon: const Icon(Feather.arrow_down),
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,

                        color: Colors.grey,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          userNameValue = newValue!;
                        });
                      },
                      items: userNameList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      width: MediaQuery.of(context).size.width *0.4,
                      child: TextField(
                        controller: controller,
                        maxLines: 5,
                        decoration:  const InputDecoration(
                          label: Text("Realisations"),
                          hintText: "Please type the tasks ",


                        ),

                      ),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          missionService.addMission(widget.idProject, controller.text, userNameValue, context).then((value){
                            setState(() {
                             listMission.add(value!);
                            });
                          });
                          Navigator.of(context).pop();
                          controller.text="";
                        },

                          color: Colors.greenAccent,
                          child: RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.plus_circle,color: Colors.white),
                                  ),
                                ),
                                TextSpan(text: 'add mission ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                        RaisedButton(onPressed: () {
                          Navigator.of(context).pop();
                          controller.text="";
                        },
                          color: Colors.redAccent,
                          child: RichText(
                            text: const TextSpan(

                              children:
                              [
                                WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.x,color: Colors.white),
                                  ),
                                ),
                                TextSpan(text: 'cancel ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 60,
                  child: Icon(Icons.error_rounded, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
}
