import 'package:devoteam/services/userService.dart';

import 'package:flutter/material.dart';

import 'package:random_string/random_string.dart';

class OtpDialog extends StatefulWidget {


  @override
  _OtpDialogState createState() => _OtpDialogState();

  OtpDialog();
}

class _OtpDialogState extends State<OtpDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  UserService userService = UserService();
  String code = "èè--çç";

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
                    Text('Enter your Email !!!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *0.4,
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              label: Text("email"),
                              hintText: "Please write your user email",

                            ),

                          ),
                        ),
                        RaisedButton(onPressed: (){
                          code = randomNumeric(4);
                          print(code);

                          userService.sendOTP(context,emailController.text, code);


                        },
                          color: Colors.blueGrey,
                        child: Text('send otp', style: TextStyle(color: Colors.white),
                        ),)
                      ],
                    ),
                    SizedBox(height: 25,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _textFieldOTP(first: true, last: false,cont: otpController1),
                        _textFieldOTP(first: false, last: false,cont: otpController2),
                        _textFieldOTP(first: false, last: false,cont: otpController3),
                        _textFieldOTP(first: false, last: true,cont: otpController4),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    RaisedButton(onPressed: () {
                      String verify= otpController1.text+otpController2.text+otpController3.text+otpController4.text;
                      if(code.compareTo(verify)==0)
                        {
                          print("code match");
                          code= "èè--çç";

                          userService.resetPassword(emailController.text,context);
                          Navigator.of(context).pop();
                        }
                      else {
                        print("code don t match");
                      }


                    },
                      color: Colors.redAccent,
                      child: Text('Okay', style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(Icons.error_rounded, color: Colors.white, size: 50,),
                )
            ),
          ],
        )
    );
  }


  Widget _textFieldOTP({required bool first, last,required TextEditingController cont}) {
    return Container(
      height: 85,
      width: 85,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: cont,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.redAccent),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}



