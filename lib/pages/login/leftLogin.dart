import 'package:devoteam/pages/admin/adminPanel.dart';
import 'package:devoteam/services/userService.dart';
import 'package:devoteam/widgets/otpDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class LoginPageLeftSide extends StatefulWidget {


  @override
  _LoginPageLeftSideState createState() => _LoginPageLeftSideState();
}

class _LoginPageLeftSideState extends State<LoginPageLeftSide> {
  UserService service = UserService();
  TextEditingController usernameController= TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(120.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('logo.png', width: 300,),
                const Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),),
                const SizedBox(height: 12,),

                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    label: Text("username"),
                    hintText: "Please write your user name",

                  ),

                ),
                TextField(
                  obscureText: visible,
                  controller: passwordController,
                  decoration:  InputDecoration(
                    label: Text("password"),
                    hintText: "Please write your password",
                    suffixIcon: IconButton(onPressed: (){
                       setState(() {
                         visible = !visible;
                       });
                    }, icon: Icon(visible ? Feather.eye : Feather.eye_off)),

                  ),
                ),
                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.topRight,
                  child: MaterialButton(child: const Text("Forget password?"), onPressed: (){
                    showDialog(context: context,
                        builder: (BuildContext context) {
                          return OtpDialog();
                        });
                  },),
                ),
                const SizedBox(height: 24),

                MaterialButton(onPressed: (){
                  service.registerEmployees(usernameController.text, passwordController.text, context);

                  print(usernameController.text);
                },child: Text("Login"),
                  minWidth: double.infinity,
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
          ),
        ));
  }
}






