import 'package:devoteam/pages/Dashboard/src/ProjectProgressCard.dart';
import 'package:devoteam/pages/Dashboard/src/ProjectStatisticsCards.dart';
import 'package:devoteam/pages/Dashboard/src/SubHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/projectModel.dart';
import '../../services/projetService.dart';

class ManagerAndUserDashboard extends StatefulWidget {


  @override
  _ManagerAndUserDashboardState createState() => _ManagerAndUserDashboardState();
}

class _ManagerAndUserDashboardState extends State<ManagerAndUserDashboard> {
  ProjetService projetService = ProjetService();
  late Future<List<Projet>> projetsF;
  late Future<List<Projet>> projetsR;
  TextEditingController editingController =TextEditingController();
  int nbrForfait =0;
  int nbrRegie = 0;
  @override
  void initState() {
    projetsF = projetService.getProjectsForfaitByManager("");
    projetsR = projetService.getProjectsRegieByManager("");
    projetsR.then((value) {
      setState(() {
        nbrRegie = value.length;
      });
    });
    projetsF.then((value) {
      setState(() {
        nbrForfait = value.length;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.92 ,
        color: Colors.white,
        child: ListView(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10,bottom: 10),
                child: Center(
                  child: Text(
                    'Projects',
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      decoration: TextDecoration.none,
                    ),

                  ),
                ),
              ),
              TextFieldContainer(0.2, 18, Colors.blueGrey.shade50, 1, "Search", "Search", Feather.search, editingController),
              const SizedBox(height: 5,),
              Container(
                margin: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'Projets Régie',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      decoration: TextDecoration.none,
                      color: Colors.greenAccent
                  ),

                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 40.0),
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width * 0.62,
                  child: projectList(projetsR, context)
              ),
              const SizedBox(height: 5,),
              Container(
                margin: const EdgeInsets.only(left: 40.0),
                child: Text(
                  'Projets Forfait',
                  style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      decoration: TextDecoration.none,
                      color: Colors.redAccent
                  ),

                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 40.0),
                  height: MediaQuery.of(context).size.height*0.3,
                  width: MediaQuery.of(context).size.width * 0.62,
                  child: projectList(projetsF, context)
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    SubHeader(
                      title: 'Project Statistics',
                    ),
                    ProjectStatisticsCards(nbrF: nbrForfait,nbrR: nbrRegie,),
                  ],
                ),
              ),


            ],
          ),],
        ),
      );
  }
  Widget projectList(Future<List<Projet>> list,BuildContext context){
    return Column(

      children: [
        const SizedBox(height: 10,),
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.92,
            child: FutureBuilder(

              future: list,
              builder: (BuildContext context, AsyncSnapshot snapshot){

                if(snapshot.data == null){
                  return const Align(
                    alignment: Alignment.topCenter,
                    child: CircularProgressIndicator(

                    ),
                  );
                }
                else {



                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index){
                        Projet projet =  Projet(id: snapshot.data[index].id, titre: snapshot.data[index].titre, description: snapshot.data[index].description,
                            dure: snapshot.data[index].dure, etat: snapshot.data[index].etat, client: snapshot.data[index].client, chef: snapshot.data[index].chef);
                        return Row(
                          children: [
                            const SizedBox(width: 10,),
                        ProjectProgressCard(progressIndicatorColor: Color(0xff6C6CE5), percentComplete: "10",
                        projet:projet , icon: Feather.moon,
                        ),

                          ],
                        );}
                  );
                }
              },
            ),


          ),
        ),
      ],

    );
  }
  Widget TextFieldContainer( double width, double radius, Color color, int maxLines, String label, String hintText, IconData icon, TextEditingController controller){
    return Center(
      child: Container(

        width: MediaQuery.of(context).size.width*width,

        decoration:  BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius),),
            color: color
        ),

        child:  TextField(
          maxLines: maxLines,
          controller: controller,
          decoration: InputDecoration(

            label: Text(label),
            hintText: hintText,
            prefixIcon: Icon(icon),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius),
                borderSide: BorderSide(color: color,)


              // borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
            ),



          ),
          onChanged: (value){

            setState(() {
              projetsF = projetService.getProjectsForfaitByManager(value);
              projetsR = projetService.getProjectsRegieByManager(value);

            });
          },



        ),
      ),
    );
  }
}
