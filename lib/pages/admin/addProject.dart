import 'package:devoteam/services/projetService.dart';
import 'package:devoteam/widgets/textfield_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/userModel.dart';
import '../../services/userService.dart';


class AddProject extends StatefulWidget {


  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final clientController =TextEditingController();
  final descriptionController =TextEditingController();
  final durationController =TextEditingController();
  final titleController =TextEditingController();
  String managerValue = "Choisir le manager";
  UserService userService = UserService();
  ProjetService projetService = ProjetService();
  List<String> managerList = ["Choisir le manager"];
  late List<UserModel> usersList;

  @override
  void initState() {

    super.initState();
   fetch();
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

    return Container(
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
            const SizedBox(height: 30,),
            Container(
              margin: const EdgeInsets.only(left: 40.0, bottom: 10.0),
              child: Center(
                child: Text(
                  'Ajouter un projet',
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
                TextFieldContainer(0.1, 18, Colors.blueGrey.shade50, 1, "Titre", "Saisir le titre de projet", Feather.bookmark, titleController),
                TextFieldContainer(0.1, 18, Colors.blueGrey.shade50, 1, "Client", "Saisir le client", Feather.user, clientController),
                TextFieldContainer(0.1, 18, Colors.blueGrey.shade50, 1, "Durée", "Saisir la durée", Feather.calendar, durationController),
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
              ],
            ),
            const SizedBox(height: 24,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                TextFieldContainer(0.5, 18, Colors.blueGrey.shade50, 7, "Description", "Saisir la description", Feather.file_text, descriptionController),

              ],
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                MaterialButton(onPressed: (){
                  projetService.addProjet(durationController.text, titleController.text,
                      managerValue, descriptionController.text, clientController.text, context);
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
