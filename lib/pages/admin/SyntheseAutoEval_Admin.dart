import 'package:devoteam/services/SyntheseAutoEvalService.dart';
import 'package:flutter/material.dart';
import '../../models/SyntheseAutoEvalModel.dart';
class Synthese_auto_eval_Admin extends StatefulWidget {
  late String user;
  Synthese_auto_eval_Admin ({Key? key, required this.user}) : super(key: key);

  @override
  _Synthese_auto_eval_AdminState createState() => _Synthese_auto_eval_AdminState();
}

class _Synthese_auto_eval_AdminState extends State<Synthese_auto_eval_Admin> {
  SyntheseAutoEvalService syntheseAutoEvalService = SyntheseAutoEvalService();
  late Future<SyntheseAutoEvalModel?> syntheseAutoEvalForm;


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
            return const Align(
              alignment: Alignment.center,
              child:
                  CircularProgressIndicator(),

            );
          }
          else{
            return form(snapshot.data);
          }
        }
    );
  }

  Widget form(dynamic s){
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
                        child:Text(s.ptsForts,style: const TextStyle(color: Colors.black)),

                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.blueAccent,
                        child:Text(s.ptsFortsManager,style: const TextStyle(color: Colors.white))

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
                        child:Text(s.enseignements,style: const TextStyle(color: Colors.black)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.blueAccent,
                        child:Text(s.enseignementsManager,style: const TextStyle(color: Colors.white))

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
                        child:Text(s.axes,style: const TextStyle(color: Colors.black)),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.2,
                        color: Colors.blueAccent,
                        child:Text(s.axesManager,style: const TextStyle(color: Colors.white))

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
                        child:Text(s.satisfaction,style: const TextStyle(color: Colors.black)),
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
                        child:Text(s.attentes,style: const TextStyle(color: Colors.black)),
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

}
