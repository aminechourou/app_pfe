import 'package:devoteam/models/Objective.dart';
import 'package:devoteam/services/objectiveService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ObjectivesUserAndManagerForm extends StatefulWidget {
  late bool role;
  late String user;
   ObjectivesUserAndManagerForm({Key? key,required this.role,required this.user}) : super(key: key);

  @override
  _ObjectivesUserAndManagerFormState createState() => _ObjectivesUserAndManagerFormState();
}

class _ObjectivesUserAndManagerFormState extends State<ObjectivesUserAndManagerForm> {
  late List<Objective> list;
  late bool etat;
  late bool test;
  ObjectiveService objectiveService = ObjectiveService();
   List<DataRow> rows = [];
 List<DataColumn> columns = [
  const DataColumn(label: Text("description")),
  const DataColumn(label: Text("etat")),
 ];
 late List<DataCell> listCells;

  TextEditingController  controller = TextEditingController();
 List<DataCell> getCells(Objective data){
   return [
     DataCell((etat)?Text(data.description)
         :InkWell(
       child:
       Container(
         width: MediaQuery.of(context).size.width * 0.2,
         child: Expanded(
           child:RichText(
             text: TextSpan(

               children:
               [ TextSpan(text: data.description),
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
         showDialog(context: context,
             builder: (BuildContext context) {
               return updateObjectiveDialog(controller, data);
             });
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
        if(widget.role==false)
          {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return updateEtatDialog( data);
                });
          }



       } ,)),
   ];
 }
 List<DataRow> getRows(List<Objective> list){

   return list.map((data)
    {
     if(data.etat.toString().compareTo("approved")==0)
     {etat = true;}
     else {
       etat =false;
     }
     listCells = getCells(data);
     if(widget.role==false)
       {
         listCells.add(
             DataCell(InkWell(
               child: const Icon(Feather.trash_2,color: Colors.redAccent),
               onTap: (){
                 showDialog(context: context,
                     builder: (BuildContext context) {
                       return deleteMissionDialog(data);
                     });
               },
             ))
         );
       }

     return DataRow(cells: listCells);
   }).toList();
 }
 @override
  void initState() {
   print("hhhhhhhhhhhh "+widget.user);
    if(widget.role == false)
      {
        columns.add(const DataColumn(label: Text("delete")));

      }
    objectiveService.getObjectives(widget.user).then((value) {
      setState(() {
        list = value!;
        rows = getRows(list);
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:  FloatingActionButton.extended(
        onPressed: (){showDialog(context: context,
            builder: (BuildContext context) {
              return addObjectiveDialog(controller);
            });},
        backgroundColor: Colors.white,
        icon: const Icon(Feather.plus,color: Colors.redAccent,),
        label: const Text("Add an Objective",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width*0.8,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                DataTable(columns: columns, rows: rows)
              ],
            )
          ],
        ),
      )
    );
  }

  Widget updateEtatDialog(Objective m){
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
                    const Text("Do you want to approve", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          objectiveService.updateEtat(m.id, context).then((value)
                          {setState(() {
                            int index = list.indexOf(m);
                            list.remove(m);
                            list.insert(index, value!);

                            rows =getRows(list);
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
                                TextSpan(text: 'mark as approved ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


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
  Widget deleteMissionDialog(Objective m ) {
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
                    const Text("Do you want to delete this objective", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          objectiveService.delete(m.id, context);
                          setState(() {
                            list.remove(m);
                            rows = getRows(list);
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
  Widget addObjectiveDialog(TextEditingController controller){
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
                    const Text('add an objective  !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),


                    Container(
                      width: MediaQuery.of(context).size.width *0.4,
                      child: TextField(
                        controller: controller,
                        maxLines: 5,
                        decoration:  const InputDecoration(
                          label: Text("description"),
                          hintText: "Please give the description",


                        ),

                      ),
                    ),


                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          String etat = "not approved";
                          if(widget.role==false)
                            {
                              etat = "approved";
                            }

                            objectiveService.add(widget.user, controller.text,etat, context).then((value)
                            {setState(() {
                              list.add(value!);
                               rows =getRows(list);
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
  Widget updateObjectiveDialog(TextEditingController controller,Objective m ){
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
                    const Text('update description  !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),


                    Container(
                      width: MediaQuery.of(context).size.width *0.4,
                      child: TextField(
                        controller: controller,
                        maxLines: 5,
                        decoration:  const InputDecoration(
                          label: Text("description"),
                          hintText: "Please give the description",


                        ),

                      ),
                    ),


                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {


                          objectiveService.updateDescription(m.id, controller.text, context).then((value)
                          {setState(() {
                            int index = list.indexOf(m);
                            list.remove(m);
                            list.insert(index, value!);

                            rows =getRows(list);
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
}
