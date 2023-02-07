import 'package:devoteam/models/userModel.dart';

import 'package:devoteam/services/userService.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class UserDetailsManager extends StatefulWidget {
  late UserModel user;


  UserDetailsManager({required this.user});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetailsManager> {
  UserService userService =UserService();
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          height: MediaQuery.of(context).size.height*0.8,
          width: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.white,),
          child:Column(
            children: <Widget>[
              Stack( overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height*0.20,
                    child: CircleAvatar(
                      radius: 70,

                      backgroundImage: NetworkImage(widget.user.profileImageUrl),
                    ),
                  )


                ],
              ),

              Text(widget.user.username,style: const TextStyle(
                  color: Colors.black87,
                  decoration: TextDecoration.none
              )),
              const SizedBox(height: 1,),
              Text(widget.user.email,style: const TextStyle(
                color: Colors.black12,
                decoration: TextDecoration.none,
                fontSize: 20.0,

              )),
              const SizedBox(height: 30,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*0.55,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(20),),
                          border: Border.all(width: 1)
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'First name : ',
                                  style:const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.firstName, style:const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text:TextSpan(
                                  text: 'Last name : ',
                                  style:const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.lastName, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text:TextSpan(
                                  text: 'Rank : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.rank, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text:TextSpan(
                                  text: 'Job : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.job, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Offre : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.offre, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text:TextSpan(
                                  text: 'Offre preféré : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.prefoffre, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.55,
                      width: MediaQuery.of(context).size.width*0.3,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: const BorderRadius.all(Radius.circular(20),),
                          border: Border.all(width: 1)
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text:TextSpan(
                                  text: 'Experience : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.experience, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text:TextSpan(
                                  text: 'Manager : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.manager, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text:TextSpan(
                                  text: 'Join date : ',
                                  style: const TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: widget.user.joinDate, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width*0.25,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(60))
                            ),
                            child: Center(
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Number of projects worked on : ',
                                  style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.none,fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: '0', style: TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),



                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),


        ),
      ],
    );
  }
}
