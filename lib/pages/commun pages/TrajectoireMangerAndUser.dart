import 'package:devoteam/services/TrajectoireService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import '../../models/Trajectoire.dart';

class TrajectoireForm extends StatefulWidget {
  late String userName;
  late String job;
  late bool role;


  TrajectoireForm({required this.userName, required this.job,required this.role});

  @override
  _TrajectoireFormState createState() => _TrajectoireFormState();
}

class _TrajectoireFormState extends State<TrajectoireForm> {

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final TextEditingController _controller6 = TextEditingController();
  final TextEditingController _controller7 = TextEditingController();

  TrajectoireService trajectoireService = TrajectoireService();
  late Future<Trajectoire?> trajectoire;



  @override
  void initState() {
    trajectoire = trajectoireService.getTrajectoire(widget.userName, context);
    trajectoire.then((value){
      if(value!=null)
      {
        _controller1.text = value.progression_visee;
        _controller2.text = value.nextJob_visee;
        _controller3.text = value.nextRank_visee;
        _controller4.text = value.progression_tech;
        _controller5.text = value.nextJob_tech;
        _controller6.text = value.nextJob_tech;
        _controller7.text = value.actions;
      }

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: trajectoire,
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData)
            {
              return Center(
                child: (widget.role) ?const CircularProgressIndicator()
                    :InkWell(
                  onTap: (){
                    setState(() {
                      trajectoire = trajectoireService.add(widget.userName, context);
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.19,
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
                          child: Expanded(child: Text("Create trajectoire Form",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.014),textAlign: TextAlign.center,)),
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
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.099),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30,),
                      Container(
                        color: Colors.grey[100],
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Job actuel: "+widget.job,
                              style: const TextStyle(
                                fontSize: 20,fontWeight: FontWeight.bold,
                              ),textAlign: TextAlign.start),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                      Container(
                        color: Colors.redAccent,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Trajectoire de 1 à 2 ans",style: TextStyle(
                            fontSize: 20,fontWeight: FontWeight.bold,
                          ),textAlign: TextAlign.center),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.redAccent,
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.height*0.05,

                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.height*0.15,
                                child: const Center(

                                  child: Text("Progression sur le  Job actuel :",style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold,
                                  ),textAlign: TextAlign.center),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.height*0.15,
                                child: const Center(

                                  child: Text("Prochain “Job” (s’il y a lieu) :",style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold,
                                  ),textAlign: TextAlign.center),
                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.2,
                                height: MediaQuery.of(context).size.height*0.15,
                                child :const Center(
                                  child: Text("Prochain rank visé (s’il y a lieu) :",style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold,
                                  ),textAlign: TextAlign.center),

                                ),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height*0.001,),
                            ],
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.001,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.redAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: const Center(

                                  child: Text("Echéance visée :",style: TextStyle(
                                    fontSize: 20,fontWeight: FontWeight.bold,
                                  ),textAlign: TextAlign.center),
                                ),

                              ),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.15,
                                child: Center(

                                    child: (widget.role)
                                        ?Text(snapshot.data.progression_visee,style: const TextStyle(
                                      fontSize: 20,fontWeight: FontWeight.bold,
                                    ),textAlign: TextAlign.center)
                                        :Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextField(

                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration:  InputDecoration(
                                            focusColor: Colors.white,

                                            hintStyle: const TextStyle(
                                              color: Colors.white,
                                            )


                                        ),
                                        controller: _controller1,
                                        maxLines: 4,
                                      ),
                                    )
                                ),
                              ),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.15,
                                child: Center(

                                    child: (widget.role)
                                        ?Text(snapshot.data.nextJob_visee,style: const TextStyle(
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
                                        controller: _controller2,
                                        maxLines: 4,
                                      ),
                                    )
                                ),
                              ),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.15,
                                child :Center(
                                    child:(widget.role) ?Text(snapshot.data.nextRank_visee,style: const TextStyle(
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
                                        controller: _controller3,
                                        maxLines: 4,
                                      ),
                                    )

                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.001,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.redAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.05,
                                child: const Center(

                                  child: Text("Compétences / technologies à développer (pour chacun des items) :",style: TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.bold,
                                  ),textAlign: TextAlign.center),
                                ),
                              ),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.15,
                                child: Center(
                                    child:(widget.role) ?Text(snapshot.data.progression_tech,style: const TextStyle(
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
                                        controller: _controller4,
                                        maxLines: 4,
                                      ),
                                    )

                                ),
                              ),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.15,
                                child: Center(
                                    child:(widget.role) ?Text(snapshot.data.nextJob_tech,style: const TextStyle(
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
                                    )

                                ),
                              ),
                              Container(
                                color: Colors.blueAccent,
                                width: MediaQuery.of(context).size.width*0.3,
                                height: MediaQuery.of(context).size.height*0.15,
                                child :Center(
                                    child:(widget.role) ?Text(snapshot.data.nextRank_tech,style: const TextStyle(
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
                                        controller: _controller6,
                                        maxLines: 4,
                                      ),
                                    )

                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                      Container(
                        color: Colors.redAccent,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.05,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Actions à mener pour y parvenir",style: TextStyle(
                            fontSize: 20,fontWeight: FontWeight.bold,
                          ),textAlign: TextAlign.center),
                        ),
                      ),
                      Container(
                        color: Colors.blueAccent,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.15,
                        child: Center(
                            child:(widget.role) ?Text(snapshot.data.actions,style: const TextStyle(
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
                                controller: _controller7,
                                maxLines: 4,
                              ),
                            )

                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Center(
                        child: (widget.role)? const Text("")
                                            :InkWell(
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
                                  child: Icon(Feather.edit,color: Colors.white,),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                                  child: Expanded(child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width*0.014),textAlign: TextAlign.center,)),
                                )

                              ],
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ],
              ),
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
                    const Text("Submit trajectoire", style: TextStyle(fontSize: 20),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(onPressed: () {
                         setState(() {
                           trajectoire = trajectoireService.update(widget.userName, _controller1.text,
                               _controller4.text, _controller2.text, _controller5.text, _controller3.text, _controller6.text,
                               _controller7.text, context);
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
}



