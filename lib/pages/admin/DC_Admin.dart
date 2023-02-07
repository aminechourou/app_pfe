import 'package:devoteam/models/DomaineCompetenceModel.dart';
import 'package:devoteam/services/domaineCompetenceService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DcFormAdmin extends StatefulWidget {
  late String user;
  late String type;
  DcFormAdmin({required this.user,required this.type});

  @override
  _RankFormState createState() => _RankFormState();
}


class _RankFormState extends State<DcFormAdmin> {
  DomaineCompetenceService domaineCompetenceService = DomaineCompetenceService();
  late Future<List<DomaineCompetence>> list;
  List<DomaineCompetence> listDc=[];
  @override
  void initState() {

    super.initState();
  }
  List<DataRow> getRows(){
    return listDc.map((data)
    {
      return DataRow(cells: [
        DataCell(Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Expanded(child: Text(data.sousTitre)))),
        DataCell(Container(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Expanded(child: Text(data.posture)))),
        DataCell(Text(data.autoEval),),
        DataCell(Text(data.feedBack))

      ]

      );
    }
    ).toList();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      list= domaineCompetenceService.getDcByUser(widget.type,widget.user);
      list.then((value) {
        setState(() {
          listDc.clear();
          listDc.addAll(value);
        });
      });
    });
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width*0.92 ,
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(left: 10, top: 50, bottom: 10,right: 10),
        child:
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10,bottom: 10),
              child: Center(
                child: Text(
                  'Form '+widget.type.toUpperCase(),
                  style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    decoration: TextDecoration.none,
                  ),

                ),
              ),
            ),
            const SizedBox(height: 2,),
            const Center(child:CircularProgressIndicator()),
            const SizedBox(height: 2,),
            Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          dataRowHeight: MediaQuery.of(context).size.height*0.2,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(30)
                          ),
                          columns: const [
                            DataColumn(label: Text("Domaine Compétence")),
                            DataColumn(label: Text("Posture Attendu")),
                            DataColumn(label: Text("Auto Eval")),
                            DataColumn(label: Text("FeedBack"),),
                          ],
                          rows: getRows(),


                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),



      ),
    );
  }

}
