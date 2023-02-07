import 'package:devoteam/models/projectModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ProjectDetails extends StatefulWidget {
late Projet projet;


ProjectDetails({required this.projet});

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height*0.2,
            margin: const EdgeInsets.only( top: 10,left: 80,right: 80 ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.grey.shade200,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.18,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.25,
                          margin: EdgeInsets.only(top: 10),

                          child: Center(
                            child: RichText(
                              text:TextSpan(
                                text: 'Project Id : ',
                                style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(text: widget.projet.id.toString(), style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.25,
                          decoration: const BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(60))
                          ),
                          child: Center(
                            child: RichText(
                              text:TextSpan(
                                text: 'Title : ',
                                style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(text: widget.projet.titre, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.25,
                          decoration: const BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(60))
                          ),
                          child: Center(
                            child: RichText(
                              text:TextSpan(
                                text: 'Chef : ',
                                style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(text: widget.projet.chef, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.18,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.29,
                          margin: EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(60))
                          ),
                          child: Center(
                            child: RichText(
                              text:TextSpan(
                                text: 'Client : ',
                                style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(text: widget.projet.client, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.25,
                          decoration: const BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(60))
                          ),
                          child: Center(
                            child: RichText(
                              text:TextSpan(
                                text: 'Durée : ',
                                style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(text: widget.projet.dure, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.25,
                          decoration: const BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(60))
                          ),
                          child: Center(
                            child: RichText(
                              text:TextSpan(
                                text: 'Etat : ',
                                style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(text: widget.projet.etat, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.18,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.25,
                          margin: EdgeInsets.only(top: 10),
                          decoration: const BoxDecoration(

                              borderRadius: BorderRadius.all(Radius.circular(60))
                          ),
                          child: Center(
                            child: RichText(
                              text:TextSpan(
                                text: 'Description : ',
                                style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(text: widget.projet.description, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),

          );



  }
}