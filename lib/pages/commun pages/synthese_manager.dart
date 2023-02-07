
import 'package:devoteam/models/syntheseManager.dart';
import 'package:devoteam/services/SyntheseManagerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
class Synthese_Manager extends StatefulWidget {
  late String user;
  late bool test;
  Synthese_Manager({Key? key, required this.user,required this.test}) : super(key: key);

  @override
  _Synthese_ManagerState createState() => _Synthese_ManagerState();
}

class _Synthese_ManagerState extends State<Synthese_Manager> {
  SyntheseManagerService syntheseManagerService = SyntheseManagerService();
  TextEditingController controller = TextEditingController();
  late Future<SyntheseManager?> managerForm;
  late String value;
  late String rankValue;
  late List<String> managerEvalList ;
  late List<String> rankEvalList ;

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
  List<String> getRankValueList(String val){
    List<String> autoEvalValues =[] ;
    switch(val){
      case "1":
        rankValue ="1";
        autoEvalValues.add(rankValue);
        autoEvalValues.add("2");
        autoEvalValues.add("3");
        autoEvalValues.add("4");
        return autoEvalValues;
      case "2":
        rankValue ="2";
        autoEvalValues.add(rankValue);
        autoEvalValues.add("1");
        autoEvalValues.add("3");
        autoEvalValues.add("4");
        return autoEvalValues;
      case "3":
        rankValue ="3";
        autoEvalValues.add(rankValue);
        autoEvalValues.add("1");
        autoEvalValues.add("2");
        autoEvalValues.add("4");
        return autoEvalValues;
      case "4":
        rankValue ="4";
        autoEvalValues.add(rankValue);
        autoEvalValues.add("1");
        autoEvalValues.add("2");
        autoEvalValues.add("3");
        return autoEvalValues;
      default :
        autoEvalValues.add("1");
        autoEvalValues.add("2");
        autoEvalValues.add("3");
        autoEvalValues.add("4");
        return autoEvalValues;
    }


    return autoEvalValues;
  }


  @override
  void initState() {
    managerForm = syntheseManagerService.getByUser(widget.user, context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: managerForm,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData==false){
          return Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                (widget.test) ?const Text("")
                    : FloatingActionButton.extended(
                  onPressed: (){
                    showDialog(context: context,
                        builder: (BuildContext context) {
                          return AddForm();

                        });
                  },
                  backgroundColor: Colors.white,
                  icon: const Icon(Feather.plus,color: Colors.redAccent,),
                  label:  const Text("Create Auto Eval Form",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 2,),
                const CircularProgressIndicator(),
              ],
            ),
          );
        }
        else {
          return managerEvalForm(snapshot.data);
        }
      }
    );

  }


  Widget managerEvalForm(dynamic data) {
    return Container(
      margin: const EdgeInsets.only( top: 50, bottom: 10,),
      child: Expanded(
          child:
          Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5015,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,


                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.3,
                        color: Colors.redAccent,
                        child: Center(
                          child: Text("Synthèse réalisée par le Manager",style: TextStyle(color: Colors.white
                              ,decoration: TextDecoration.none,fontSize: MediaQuery.of(context).size.width*0.02),),
                        ),

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        decoration: BoxDecoration(border: Border.all(width: 0.5),color: Colors.redAccent,),
                        child: Center(
                          child: Text("Proposition d’appréciations",style: TextStyle(color: Colors.white
                              ,decoration: TextDecoration.none,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5015,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.redAccent,
                        child: Center(
                          child: Text("Performance mission",style: TextStyle(color: Colors.white
                              ,decoration: TextDecoration.none,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),


                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.3,
                        color: Colors.blueAccent,
                        child: (widget.test)
                            ?Text(data.performance,style: const TextStyle(color: Colors.white),)
                            :InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: data.performance),
                                const WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Feather.edit),
                                    ),
                                    style: TextStyle(color: Colors.black)
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return update("performance");

                                });
                          },
                        )

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.blueAccent,
                          child: (widget.test)
                              ?Text(data.notePerformance,style: const TextStyle(color: Colors.white),)
                              :InkWell(
                            child: RichText(
                              text: TextSpan(
                                children:
                                [ TextSpan(text: data.notePerformance),
                                  const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Feather.edit),
                                      ),
                                      style: TextStyle(color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                managerEvalList = getValueList(data.notePerformance);
                                value =managerEvalList[0];
                              });
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return updateManagerDialog("notePerformance");

                                  });
                            },
                          )
                      ),

                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5015,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.redAccent,
                        child: Center(
                          child: Text("Contributions",style: TextStyle(color: Colors.white
                              ,decoration: TextDecoration.none,fontSize: MediaQuery.of(context).size.width*0.014),),
                        ),


                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.3,
                        color: Colors.blueAccent,
                          child: (widget.test)
                              ?Text(data.contribution,style: const TextStyle(color: Colors.white),)
                              :InkWell(
                            child: RichText(
                              text: TextSpan(
                                children:
                                [ TextSpan(text: data.contribution),
                                  const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Feather.edit),
                                      ),
                                      style: TextStyle(color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return update("contribution");

                                  });
                            },
                          )

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.blueAccent,
                          child: (widget.test)
                              ?Text(data.noteContribution,style: const TextStyle(color: Colors.white),)
                              :InkWell(
                            child: RichText(
                              text: TextSpan(
                                children:
                                [ TextSpan(text: data.noteContribution),
                                  const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Feather.edit),
                                      ),
                                      style: TextStyle(color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                managerEvalList = getValueList(data.noteContribution);
                                value =managerEvalList[0];
                              });
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return updateManagerDialog("noteContribution");

                                  });
                            },
                          )
                      ),

                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5015,
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.redAccent,
                        child: Center(
                          child: Text("Rank (évaluation de l’attendu de ce rank)",style: TextStyle(color: Colors.white
                              ,decoration: TextDecoration.none,fontSize: MediaQuery.of(context).size.width*0.012),),
                        ),


                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.3,
                        color: Colors.blueAccent,
                          child: (widget.test)
                              ?Text(data.rank,style: const TextStyle(color: Colors.white),)
                              :InkWell(
                            child: RichText(
                              text: TextSpan(
                                children:
                                [ TextSpan(text: data.rank),
                                  const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Feather.edit),
                                      ),
                                      style: TextStyle(color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return update("rank");

                                  });
                            },
                          )

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.blueAccent,
                          child: (widget.test)
                              ?Text(data.noteRank,style: const TextStyle(color: Colors.white),)
                              :InkWell(
                            child: RichText(
                              text: TextSpan(
                                children:
                                [ TextSpan(text: data.noteRank),
                                  const WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 2.0),
                                        child: Icon(Feather.edit),
                                      ),
                                      style: TextStyle(color: Colors.black)
                                  ),
                                ],
                              ),
                            ),
                            onTap: (){
                              setState(() {
                                rankEvalList = getRankValueList(data.noteRank);
                                rankValue =rankEvalList[0];
                              });
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return updateManagerRankEvalDialog();

                                  });
                            },
                          )
                      ),

                    ],
                  ),
                ),
              ),



            ],
          )

      ),
    );
  }
  Widget AddForm(){
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
                    const Text("Do you want to creat Manager Form", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          setState(() {
                            managerForm = syntheseManagerService.add(widget.user, context);
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
  Widget update(String champ) {
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
                      Text('Update  '+champ+' !!!', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      const SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width *0.4,
                        child: TextField(
                          controller: controller,
                          maxLines: 5,
                          decoration:  InputDecoration(
                            label: Text(champ),
                            hintText: "Please give the "+champ,


                          ),

                        ),
                      ),

                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(onPressed: () {
                            setState(() {
                              managerForm = syntheseManagerService.update(widget.user, champ, controller.text, context);
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
  Widget updateManagerDialog(String champ){
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
                      const Text('A – Excellent, dépasse les attentes de manière significative / B – Bien, objectif atteint / C – Moyen,, Objectif partiellement atteint/ D – Insuffisant, performance attendue non atteinte',
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
                        items: managerEvalList
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
                           setState(() {
                             managerForm = syntheseManagerService.update(widget.user, champ, value, context);
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
  Widget updateManagerRankEvalDialog(){
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
                      const Text('1 –Fast-track / 2 – Progression rapide / 3 – Progression normale  / 4 – Progression insuffisante',
                        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),),
                      const SizedBox(height: 5,),
                      DropdownButton<String>(
                        value: rankValue,
                        icon: const Icon(Feather.arrow_down),
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,

                          color: Colors.grey,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            rankValue = newValue!;
                          });
                        },
                        items: rankEvalList
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
                            setState(() {
                              managerForm = syntheseManagerService.update(widget.user, "noteRank", rankValue, context);
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
