import 'package:devoteam/models/EvalComite.dart';
import 'package:devoteam/models/userModel.dart';
import 'package:devoteam/services/EvalComiteService.dart';
import 'package:devoteam/services/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class EvalComiteForm extends StatefulWidget {
 late String user;
 late bool role;


 EvalComiteForm({required this.user, required this.role});

  @override
  _EvalComiteFormState createState() => _EvalComiteFormState();
}

class _EvalComiteFormState extends State<EvalComiteForm> {

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  EvalComiteService evalComiteService = EvalComiteService();
  UserService userService = UserService();
  late Future<EvalComite?> eval;
  @override
  void initState() {
    eval = evalComiteService.getEvalComite(widget.user, context);
    eval.then((value) {
      if (value != null) {
        _controller1.text = value.mission;
        _controller2.text = value.attenduVSrank;
        _controller3.text = value.contributions;
        _controller4.text = value.appreciation;
        _controller5.text = value.synthese_globale;
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: eval,
        builder: (BuildContext context, AsyncSnapshot snapshot){
      if(!snapshot.hasData)
      {
        return Center(
          child: InkWell(
            onTap: (){
              setState(() {
                eval = evalComiteService.add(widget.user, context);
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.2,
              height: MediaQuery.of(context).size.height*0.05,
              decoration: BoxDecoration(
                  color: Colors.redAccent[400],
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,


                children:  [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Feather.edit,color: Colors.white,),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Expanded(child: Text("Create Eval Comité Form",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.014),textAlign: TextAlign.center,)),
                  )

                ],
              ),
            ),
          ),
        );
      }
      else {
        return Scaffold(
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.080),
            child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.1,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.redAccent,
                          width: MediaQuery.of(context).size.width*0.24,
                          height: MediaQuery.of(context).size.height*0.15,
                          child: const Center(

                            child: Text("Évaluation du comité carrière",style: TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.center),
                          ),

                        ),
                        Column(
                            children: [
                              Container(
                                color: Colors.redAccent,
                                width: MediaQuery.of(context).size.width*0.15,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Mission",style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold,
                                  ),textAlign: TextAlign.center),
                                ),
                              ),
                              (widget.role)?Text(snapshot.data.mission,style: const TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold,
                              ),textAlign: TextAlign.center)
                                  :Container(
                                color: Colors.white,
                                width: MediaQuery.of(context).size.width*0.15,
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration:  const InputDecoration(
                                      focusColor: Colors.white,

                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                      )
                                  ),
                                  controller: _controller1,
                                  maxLines: 2,
                                ),
                              )

                            ],

                        ),
                        Column(
                          children: [
                            Container(
                              color: Colors.redAccent,
                              width: MediaQuery.of(context).size.width*0.15,
                              height: MediaQuery.of(context).size.height*0.05,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("attendu VS rank",style: TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold,
                                ),textAlign: TextAlign.center),
                              ),
                            ),
                            (widget.role)?Text(snapshot.data.attenduVSrank,style: const TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.center)
                                :Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width*0.15,
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(


                                decoration:  const InputDecoration(
                                    focusColor: Colors.white,

                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    )
                                ),
                                controller: _controller2,
                                maxLines: 2,
                              ),
                            )

                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              color: Colors.redAccent,
                              width: MediaQuery.of(context).size.width*0.15,
                              height: MediaQuery.of(context).size.height*0.05,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("contributions",style: TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold,
                                ),textAlign: TextAlign.center),
                              ),
                            ),
                            (widget.role)?Text(snapshot.data.contributions,style: const TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.center)
                                :Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width*0.15,
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(

                                decoration:  const InputDecoration(
                                    focusColor: Colors.white,

                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    )
                                ),
                                controller: _controller3,
                                maxLines: 2,
                              ),
                            )

                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              color: Colors.redAccent,
                              width: MediaQuery.of(context).size.width*0.15,
                              height: MediaQuery.of(context).size.height*0.05,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("appreciation globale",style: TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold,
                                ),textAlign: TextAlign.center),
                              ),
                            ),
                            (widget.role)?Text(snapshot.data.appreciation,style: const TextStyle(
                              fontSize: 20,fontWeight: FontWeight.bold,
                            ),textAlign: TextAlign.center)
                                :Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width*0.15,
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(

                                decoration:  const InputDecoration(
                                    focusColor: Colors.white,

                                    hintStyle: TextStyle(
                                      color: Colors.white,
                                    )
                                ),
                                controller: _controller4,
                                maxLines: 2,
                              ),
                            )

                          ],
                        ),


                      ],
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      color: Colors.redAccent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.05,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Bilan",style: TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold,
                        ),textAlign: TextAlign.center),
                      ),
                    ),
                    Container(
                      color: Colors.blueAccent,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height*0.15,
                      child:  Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  (widget.role)
                            ?Text(snapshot.data.synthese_globale,style: const TextStyle(
                          fontSize: 20,fontWeight: FontWeight.bold,
                        ),textAlign: TextAlign.center)
                            :Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(

                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration:  const InputDecoration(
                                focusColor: Colors.white,

                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )


                            ),
                            controller: _controller5,
                            maxLines: 4,
                          ),
                        ),
                      ),
                    ),
                     (widget.role)? const Text("")
                            :Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(

                          onTap: (){
                                  showDialog(context: context,
                                      builder: (BuildContext context) {
                                        return confirmDialog();
                                      });
                          },
                          child: Container(
                                  width: MediaQuery.of(context).size.width*0.08,
                                  height: MediaQuery.of(context).size.height*0.05,
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent[400],
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,


                                    children:  [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8.0),
                                        child: Icon(Feather.save,color: Colors.white,),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 18.0),
                                        child: Expanded(child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.014),textAlign: TextAlign.center,)),
                                      )

                                    ],
                                  ),
                          ),
                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8,bottom: 8, left: 8, right: 13),
                                  child: InkWell(

                                    onTap: (){
                                      showDialog(context: context,
                                          builder: (BuildContext context) {
                                            return updateRankDialog();
                                          });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width*0.13,
                                      height: MediaQuery.of(context).size.height*0.05,
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent[400],
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,


                                        children:  [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Icon(Feather.edit,color: Colors.white,),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                                            child: Expanded(child: Text("update Rank",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.014),textAlign: TextAlign.center,)),
                                          )

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )

                  ],
                )


          ),
        );
      }
        },


    );
  }
  Widget confirmDialog() {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width*0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text('Warning !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    const Text("Submit Retour Comité", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          setState(() {
                            eval = evalComiteService.update(widget.user, _controller1.text,
                                _controller2.text, _controller3.text, _controller4.text, _controller5 .text, context);
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
                                TextSpan(text: 'submit ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


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
  Widget updateRankDialog() {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width*0.3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text('Warning !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    const SizedBox(height: 5,),
                    const Text("Rank up", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                          userService.updateRank(widget.user, context);
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
                                TextSpan(text: 'submit ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


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
}
