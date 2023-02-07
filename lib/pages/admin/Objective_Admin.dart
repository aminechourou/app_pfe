import 'package:devoteam/models/Objective.dart';
import 'package:devoteam/services/objectiveService.dart';
import 'package:flutter/material.dart';


class ObjectivesAdmin extends StatefulWidget {

  late String user;
  ObjectivesAdmin({Key? key,required this.user}) : super(key: key);

  @override
  _ObjectivesAdminState createState() => _ObjectivesAdminState();
}

class _ObjectivesAdminState extends State<ObjectivesAdmin> {
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
      DataCell(Text(data.description)),
      DataCell((etat)
          ? const Icon(
        Icons.verified_user,
        color: Colors.green,
      )
          :  InkWell(
        child: const Icon(Icons.cancel, color: Colors.red),
        onTap:(){
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


      return DataRow(cells: listCells);
    }).toList();
  }
  @override
  void initState() {

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
        body: SizedBox(
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


}
