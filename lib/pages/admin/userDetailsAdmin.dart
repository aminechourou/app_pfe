import 'package:devoteam/models/userModel.dart';
import 'package:devoteam/pages/admin/adminPanel.dart';
import 'package:devoteam/pages/admin/updateUser.dart';
import 'package:devoteam/pages/admin/usersList.dart';
import 'package:devoteam/services/userService.dart';
import 'package:devoteam/widgets/deleteAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class UserDetails extends StatefulWidget {
late UserModel user;


UserDetails({required this.user});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  UserService userService =UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: (){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=>AdminPanel(index: 1,)));
        }),
        title: const Center(child: Text("User details")),
        backgroundColor: Colors.white,
      ),
      body: Container(

      width: MediaQuery.of(context).size.width,
      color: Colors.redAccent,
      child: Container(
      height: MediaQuery.of(context).size.height*0.8,
      width: 240,
      margin: const EdgeInsets.only(left: 200, top: 20, bottom: 20,right: 200),
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
          Row(
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
                    MaterialButton(onPressed: (){
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return DeleteAlert(widget.user.username);
                          });
                    },child: RichText(
                      text: const TextSpan(

                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Feather.trash),
                            ),
                          ),
                          TextSpan(text: 'Supprimer ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                        ],
                      ),
                    ),
                      minWidth: MediaQuery.of(context).size.width*0.25,
                      height: 52,
                      elevation: 24,
                      color: Colors.redAccent.shade200,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                      ),
                    ),
                    const SizedBox(height: 20,),
                    MaterialButton(onPressed: (){
    Navigator.push(context,
    MaterialPageRoute(builder: (context)=>UpdateUser(user: widget.user,)));

                    },child: RichText(
                      text: const TextSpan(

                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Feather.edit),
                            ),
                          ),
                          TextSpan(text: 'Editer ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


                        ],
                      ),
                    ),
                      minWidth: MediaQuery.of(context).size.width*0.25,
                      height: 52,
                      elevation: 24,
                      color: Colors.greenAccent.shade200,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)
                      ),
                    ),


                  ],
                ),
              ),
            ],
          )
        ],
      ),
      ),
      ),
    );
  }
}
