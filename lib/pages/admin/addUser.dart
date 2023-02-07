
import 'dart:async';
import 'dart:convert';

import 'package:devoteam/models/userModel.dart';
import 'package:devoteam/services/userService.dart';
import 'package:devoteam/widgets/textfield_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'adminPanel.dart';
class AddUser extends StatefulWidget {


  @override
  _State createState() {

    return _State();
  }
}

class _State extends State<AddUser> {
  final firstnameController =TextEditingController();
  final lastnameController =TextEditingController();
  final emailController =TextEditingController();
  final passwordController =TextEditingController();
  final exprienceController =TextEditingController();
  String rankValue = "Choisir le rank";
  String managerValue = "Choisir le manager";
  String jobValue = "Choisir le job";
  String offreValue = "Choisir le offre";
  String prefOffreValue = "Choisir le meilleur offre";
  UserService userService = UserService();
  List<String> managerList = ["Choisir le manager"];
   List<UserModel> usersList =[];

  @override
  void initState() {
    fetch();


    super.initState();

  }
void fetch(){

    userService.getListUsers("").then((value){
      setState(() {
      usersList= value;
      managerList = ["Choisir le manager"];
      managerList.addAll(userService.getManagers(usersList));
    });

  });
}

  @override
  Widget build(BuildContext context) {

    return   Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.92,
            color: Colors.redAccent,
            child: Container(
              height: 240,
              width: 240,
              margin: const EdgeInsets.only(left: 200, top: 100, bottom: 100,right: 200),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),color: Colors.white,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70,),
                  Container(
                    margin: const EdgeInsets.only(left: 40.0, top: 25.0, bottom: 10.0),
                    child: Center(
                      child: Text(
                        'Ajouter un consultant',
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          decoration: TextDecoration.none,
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(height: 80,),

                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      children: [
                        TextFieldContainer(0.2, 18, Colors.blueGrey.shade50, 1, "Nom", "Saisir le nom", Feather.user, firstnameController),
                        TextFieldContainer(0.2, 18, Colors.blueGrey.shade50, 1, "Prénom", "Saisir le prénom", Feather.user, lastnameController),
                      ],
                    ),

                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      TextFieldContainer(0.2, 18, Colors.blueGrey.shade50, 1, "Email", "Saisir le email", Feather.mail, emailController),
                      TextFieldContainer(0.2, 18, Colors.blueGrey.shade50, 1, "Experience", "Saisir le nombre d'année d'experience", Feather.user, exprienceController),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
    items: <String>["Choisir le rank",'Consultant 1', 'Consultant 2', 'Consultant 3', 'Manager']
        .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList(),
    ),
                      DropdownButton<String>(

                        value: jobValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                           jobValue = newValue!;
                          });
                        },
                        items: <String>["Choisir le job",'Dev', 'Buisness Intelligence', 'Cloud', 'Cyber Security']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(

                        value: offreValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            offreValue = newValue!;
                          });
                        },
                        items: <String>["Choisir le offre",'Dev', 'Buisness Intelligence', 'Cloud', 'Cyber Security']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(

                        value: prefOffreValue,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            prefOffreValue = newValue!;
                          });
                        },
                        items: <String>["Choisir le meilleur offre",'Dev', 'Buisness Intelligence', 'Cloud', 'Cyber Security']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),

                    ],
                  ),
                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      DropdownButton<String>(
                        value: managerValue,
                        icon: const Icon(Feather.arrow_down),
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,

                          color: Colors.grey,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            managerValue = newValue!;

                          });
                        },
                        items: managerList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      MaterialButton(onPressed: (){
                       userService.addUser(firstnameController.text, lastnameController.text,
                           emailController.text, rankValue, jobValue, exprienceController.text, offreValue,
                           prefOffreValue, managerValue, context);


                      },
                        child: const Text("Ajouter"),
                        minWidth: MediaQuery.of(context).size.width*0.2,
                        height: 52,
                        elevation: 24,
                        color: Colors.redAccent.shade200,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)
                        ),

                      )
                    ],
                  ),

                ],
              ),
            ),



    );
  }
}
