import 'package:devoteam/models/MissionModel.dart';
import 'package:devoteam/services/missionService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MissionListUser extends StatefulWidget {
  late int idProject;


  MissionListUser({required this.idProject});

  @override
  _MissionListUserState createState() => _MissionListUserState();
}

class _MissionListUserState extends State<MissionListUser> {
  MissionService missionService = MissionService();
  late Future<List<Mission>> list;
  List<Mission> listMission=[];
  bool etat =false;
  bool check = false;
  late String connectedUser;
  late List<String> autoEvalList ;
  late String value;

  @override
  void initState() {
    list = missionService.getMissionByProjects(widget.idProject);
    getConnectedUser().then((value) {
      setState(() {
        connectedUser = value!;
      });
    });
    super.initState();
  }
  Future<String?> getConnectedUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userName =prefs.getString("user");
    return userName;
  }
  List<String> getValueList(String val){
    List<String> autoEvalValues =[] ;
    switch(val){
      case "A":
        value ="A";
        autoEvalValues.add(value);
        autoEvalValues.add("B");
        autoEvalValues.add("C");
        autoEvalValues.add("D");
        return autoEvalValues;
      case "B":
        value ="B";
        autoEvalValues.add(value);
        autoEvalValues.add("A");
        autoEvalValues.add("C");
        autoEvalValues.add("D");
        return autoEvalValues;
      case "C":
        value ="C";
        autoEvalValues.add(value);
        autoEvalValues.add("A");
        autoEvalValues.add("B");
        autoEvalValues.add("D");
        return autoEvalValues;
      case "D":
        value ="D";
        autoEvalValues.add(value);
        autoEvalValues.add("A");
        autoEvalValues.add("B");
        autoEvalValues.add("C");
        return autoEvalValues;
      default :
        autoEvalValues.add("A");
        autoEvalValues.add("B");
        autoEvalValues.add("C");
        autoEvalValues.add("D");
        return autoEvalValues;
    }


    return autoEvalValues;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: list,
        builder: (BuildContext context, AsyncSnapshot snapshot){

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
                    DataTable(
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
                        if(data.etat.toString().compareTo("done")==0){
                          etat = true;}
                        else {etat =false;}
                        if(data.user.compareTo(connectedUser)==0){
                          check =true;
                        }
                        else{check=false;}
                        return DataRow(
                            cells: [
                              DataCell(Text(data.id.toString())),
                              DataCell(Text(data.user)),
                              DataCell(Text(data.projet)),
                              DataCell(Container(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                  child: Expanded(child: Text(data.realisation)))),
                              DataCell((check)
                                        ?InkWell(
                                         child: RichText(
                                                text: TextSpan(
                                                       children:
                                                       [ TextSpan(text: data.autoEval),
                                                         const WidgetSpan(
                                                         child: Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                                child: Icon(Feather.edit),
                                                                       ),
                                                                          ),
                                                      ],
                                                                ),
                                                                ),
                                         onTap: (){
                                           setState(() {
                                             autoEvalList = getValueList(data.autoEval);
                                             value =autoEvalList[0];
                                           });
                                           if(data.etat.compareTo("done")==0)
                                             {
                                               showDialog(context: context,
                                                   builder: (BuildContext context) {
                                                     return updateAutoEvalDialog(data);

                                                   });
                                             }
                                           else {
                                             const snackBar = SnackBar(content: Text("Mission must be done first"),);
                                             ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                           }



                                         },
                                        )
                                        :Text(data.autoEval)),
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
                  ],
                ),
              ),
            );
          }
        }
    );
  }

  Widget updateAutoEvalDialog(Mission m){
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height *0.4 ,
              width: MediaQuery.of(context).size.width *0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text('Give your auto Evaluation !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    const Text('A – Excellent / B – Bonne maitrise de la compétence/ C – Moyen/ D – Insuffisant',
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),),
                    const SizedBox(height: 5,),
                    DropdownButton<String>(
                      value: value,
                      icon: const Icon(Feather.arrow_down),
                      elevation: 16,
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,

                        color: Colors.grey,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          value = newValue!;
                        });
                      },
                      items: autoEvalList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          missionService.updateAutoEvalMission(m.id, value, context).then((value){
                            setState(() {
                              int index = listMission.indexOf(m);
                              listMission[index] = value!;
                            });
                          });
                          Navigator.of(context).pop();

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
                                TextSpan(text: 'Update ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


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
