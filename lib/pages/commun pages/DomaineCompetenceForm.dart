import 'package:devoteam/models/DomaineCompetenceModel.dart';
import 'package:devoteam/services/domaineCompetenceService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
class DcForm extends StatefulWidget {
  late String user;
  late bool test;
  late String type;
  DcForm({required this.user,required this.test,required this.type});

  @override
  _RankFormState createState() => _RankFormState();
}


class _RankFormState extends State<DcForm> {
  DomaineCompetenceService domaineCompetenceService = DomaineCompetenceService();
  late Future<List<DomaineCompetence>> list;
  List<DomaineCompetence> listDc=[];
  late List<String> autoEvalList ;
  late String value;
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
        DataCell((widget.test)
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
            if(data.feedBack.compareTo("not submitted")==0)
            {
              showDialog(context: context,
                  builder: (BuildContext context) {
                    return updateAutoEvalDialog(data);

                  });
            }
            else {
              const snackBar = SnackBar(content: Text("you can not update it "),);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }



          },
        ) :Text(data.autoEval),
        ),
        DataCell((widget.test)
            ?Text(data.feedBack)
            :InkWell(
          child: RichText(
            text: TextSpan(
              children:
              [ TextSpan(text: data.feedBack),
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

            showDialog(context: context,
                builder: (BuildContext context) {
                  return updateFeedBackDialog(data);

                });





          },
        ),
        )

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
                  Center(child: (widget.test)?const Text("")
                  :FloatingActionButton.extended(
                    onPressed: (){
                      if(listDc.isEmpty){
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CreateDcForm();

                          });
                    }
                      else{
                        final snackBar = SnackBar(content: Text("You already Created a "+widget.type+" Form"),);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      },
                    backgroundColor: Colors.white,
                    icon: const Icon(Feather.plus,color: Colors.redAccent,),
                    label:  Text("Create "+widget.type+" Form",style: const TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
                  ),
                  ),
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
  Widget updateAutoEvalDialog(DomaineCompetence m){
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
                          domaineCompetenceService.updateAutoEval(value,m.id, context).then((value){
                            setState(() {
                              int index = listDc.indexOf(m);
                              listDc[index] = value!;
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
  Widget updateFeedBackDialog(DomaineCompetence m){
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
                    const Text('Give your FeedBack !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                          domaineCompetenceService.updateFeedBack(value,m.id, context).then((value){
                            setState(() {
                              int index = listDc.indexOf(m);
                              listDc[index] = value!;
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
  Widget CreateDcForm(){
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
                    Text("Do you want to creat "+widget.type+" Form", style: const TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {

                             if(widget.type.compareTo("rank")==0){
                               domaineCompetenceService.createRank(widget.user, context).then((value){
                                 setState(() {
                                   list = domaineCompetenceService.getDcByUser("rank", widget.user);
                                   list.then((value){
                                     listDc = value;
                                     getRows();
                                   } );
                                 });

                               });
                             }
                             else if(widget.type.compareTo("contributions")==0) {
                               domaineCompetenceService.createContribution(widget.user, context).then((value){
                                 setState(() {

                                   list = domaineCompetenceService.getDcByUser("contributions", widget.user);
                                   list.then((value){
                                     listDc.clear();
                                     listDc = value;
                                   } );
                                 });

                               });
                             }




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
                                TextSpan(text: 'Create ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


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
}
