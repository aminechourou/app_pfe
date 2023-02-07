import 'package:devoteam/models/syntheseManager.dart';
import 'package:devoteam/services/SyntheseManagerService.dart';
import 'package:flutter/material.dart';
class Synthese_Manager_Admin extends StatefulWidget {
  final String user;

  const Synthese_Manager_Admin({Key? key, required this.user}) : super(key: key);

  @override
  _Synthese_Manager_AdminState createState() => _Synthese_Manager_AdminState();
}

class _Synthese_Manager_AdminState extends State<Synthese_Manager_Admin> {
  SyntheseManagerService syntheseManagerService = SyntheseManagerService();
  late Future<SyntheseManager?> managerForm;



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
            return const Align(
              alignment: Alignment.center,

                child:  CircularProgressIndicator(),


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
                          child:Text(data.performance,style: const TextStyle(color: Colors.white),)


                      ),
                      Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.1,
                          color: Colors.blueAccent,
                          child:Text(data.notePerformance,style: const TextStyle(color: Colors.white),)

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
                          child:Text(data.contribution,style: const TextStyle(color: Colors.white),)


                      ),
                      Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.1,
                          color: Colors.blueAccent,
                          child:Text(data.noteContribution,style: const TextStyle(color: Colors.white),)

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
                          child:Text(data.rank,style: const TextStyle(color: Colors.white),)


                      ),
                      Container(
                          height: MediaQuery.of(context).size.height*0.1,
                          width: MediaQuery.of(context).size.width*0.1,
                          color: Colors.blueAccent,
                          child:Text(data.noteRank,style: const TextStyle(color: Colors.white),)

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
