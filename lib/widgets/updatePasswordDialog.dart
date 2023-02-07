import 'package:devoteam/services/userService.dart';
import 'package:flutter/material.dart';

class UpdatePasswordDialog extends StatefulWidget {
  const UpdatePasswordDialog({Key? key}) : super(key: key);

  @override
  _UpdatePasswordDialogState createState() => _UpdatePasswordDialogState();
}

class _UpdatePasswordDialogState extends State<UpdatePasswordDialog> {
  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  UserService userService =UserService();
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)
        ),
        child: Stack(
          overflow: Overflow.visible,
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height *0.5 ,
              width: MediaQuery.of(context).size.width *0.5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text('Change Password !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 5,),


                    Container(
                          width: MediaQuery.of(context).size.width *0.4,
                          child: TextField(
                            controller: oldController,
                            decoration: const InputDecoration(
                              label: Text("Current Password"),
                              hintText: "Please write your current password",

                            ),

                          ),
                        ),
                    SizedBox(height: 25,),
                    Container(
                      width: MediaQuery.of(context).size.width *0.4,

                      child: TextField(
                        controller: newController,
                        decoration: const InputDecoration(
                          label: Text("New Password"),
                          hintText: "Please write your new password",


                        ),

                      ),
                    ),

                    const SizedBox(height: 20,),
                    RaisedButton(onPressed: () {
                      userService.updatePassword(oldController.text, newController.text, context);
                    },

                      color: Colors.greenAccent,
                      child: Text('Okay', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 60,
                  child: Icon(Icons.error_rounded, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }
}
