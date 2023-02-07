import 'package:devoteam/services/SyntheseAutoEvalService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../models/SyntheseAutoEvalModel.dart';
class Synthese_auto_eval extends StatefulWidget {
  late String user;
  late bool test;
  Synthese_auto_eval({required this.user,required this.test});

  @override
  _Synthese_auto_evalState createState() => _Synthese_auto_evalState();
}

class _Synthese_auto_evalState extends State<Synthese_auto_eval> {
 SyntheseAutoEvalService syntheseAutoEvalService = SyntheseAutoEvalService();
 late Future<SyntheseAutoEvalModel?> syntheseAutoEvalForm;
 TextEditingController controller = TextEditingController();

@override
  void initState() {
    syntheseAutoEvalForm = syntheseAutoEvalService.getByUser(widget.user, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: syntheseAutoEvalForm,
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
        else{
          return Form(snapshot.data);
        }
        }
    );
  }

  Widget Form(dynamic s){
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
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.redAccent,
                        child: const Center(child: Text("Points Forts",style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 20),)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.white,
                        child: (widget.test)
                            ?InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.ptsForts),
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
                                  return update("ptsForts");

                                });
                          },
                        )
                            :Text(s.ptsForts,style: const TextStyle(color: Colors.black)),

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.blueAccent,
                        child:(widget.test) ?Text(s.ptsFortsManager,style: const TextStyle(color: Colors.white))
                                            :InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.ptsFortsManager,style: const TextStyle(color: Colors.white)),
                                const WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.edit,color: Colors.white,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return update("ptsFortsManger");

                                });
                          },
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
                        child: const Center(child: Text("Enseignements tirés",style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 20),)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.white,
                        child: (widget.test)
                            ?InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.enseignements),
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
                                  return update("enseignement");

                                });
                          },
                        )
                            :Text(s.enseignements,style: const TextStyle(color: Colors.black)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.blueAccent,
                        child: (widget.test) ?Text(s.enseignementsManager,style: const TextStyle(color: Colors.white))
                            :InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.enseignementsManager,style: const TextStyle(color: Colors.white)),
                                const WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.edit,color: Colors.white,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return update("enseignementManger");

                                });
                          },
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
                        child: const Center(child: Text("Axes d’amélioration",style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 20),)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.white,
                        child: (widget.test)
                            ?InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.axes),
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
                                  return update("axes");

                                });
                          },
                        )
                            :Text(s.axes,style: const TextStyle(color: Colors.black)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.blueAccent,
                        child:(widget.test) ?Text(s.axesManager,style: const TextStyle(color: Colors.white))
                            :InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.axesManager,style: const TextStyle(color: Colors.white)),
                                const WidgetSpan(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Icon(Feather.edit,color: Colors.white,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            showDialog(context: context,
                                builder: (BuildContext context) {
                                  return update("axesManager");

                                });
                          },
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
                        height: MediaQuery.of(context).size.height*0.17,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.redAccent,
                        child: const Center(child: Text("Satisfactions / Insatisfactions de la période évaluée et suggestions",
                          style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 20),)),

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.4,
                        color: Colors.white,
                        child: (widget.test)
                            ?InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.satisfaction),
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
                                  return update("satisfaction");

                                });
                          },
                        )
                            :Text(s.satisfaction,style: const TextStyle(color: Colors.black)),
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
                        child: const Center(child: Text("Attentes pour les deux années à venir",
                          style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 20),)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.4,
                        color: Colors.white,
                        child: (widget.test)
                            ?InkWell(
                          child: RichText(
                            text: TextSpan(
                              children:
                              [ TextSpan(text: s.attentes),
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
                                  return update("attentes");

                                });
                          },
                        )
                            :Text(s.attentes,style: const TextStyle(color: Colors.black)),
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
                    const Text("Do you want to creat Auto eval Form", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          setState(() {
                            syntheseAutoEvalForm = syntheseAutoEvalService.add(widget.user, context);
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
                            syntheseAutoEvalForm = syntheseAutoEvalService.update(widget.user, champ, controller.text, context);
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
