import 'dart:html';
import 'dart:ui';

import 'package:devoteam/pages/admin/adminPanel.dart';
import 'package:devoteam/widgets/updatePasswordDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/userModel.dart';
import '../../services/userService.dart';
import 'dart:html' as html;


class UserProfile extends StatefulWidget {





  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  UserService userService =UserService();

late String path;
@override
  void initState() {
  userService.getUser().then((value) {
    setState(() {
      UserModel u = value!;
      path= u.profileImageUrl;
    });
  });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: userService.getUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot)
      {
    print(snapshot.data);
    if(snapshot.data == null){
    return const Align(
    alignment: Alignment.center,
    child: CircularProgressIndicator(

    ),
    );
    }
    else {

      return ChangeNotifierProvider<MyProvider>(
      create: (context) => MyProvider(snapshot.data.profileImageUrl),
    child: Consumer<MyProvider>(
    builder: (context, provider, child) {

        return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width*0.92,
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
          backgroundImage: NetworkImage(path),
        ),
        ),

        Positioned(
        bottom: 0,
        right: -4,
        child: MaterialButton(onPressed: ()async{
          var image = await ImagePicker()
              .pickImage(source: ImageSource.gallery);
          provider.setImage(image);
          print(userService.getUser());

          userService.updateProfileImage(provider.image);
          setState(() {
            String im= image!.path;
            path = im;
          });









        },child: RichText(
        text: const TextSpan(

        children: [
        WidgetSpan(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Icon(Feather.camera),
        ),
        ),


        ],
        ),
        ),
        minWidth: MediaQuery.of(context).size.width*0.06,
        height: MediaQuery.of(context).size.height*0.06,
        elevation: 24,
        color: Colors.blueAccent,
        textColor: Colors.white,
        shape:CircleBorder(),
        ),
        ),


        ],
        ),

        Text(snapshot.data.username,style: const TextStyle(
        color: Colors.black87,
        decoration: TextDecoration.none
        )),
        const SizedBox(height: 1,),
        Text(snapshot.data.email,style: const TextStyle(
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
        TextSpan(text: snapshot.data.firstName, style:const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text: snapshot.data.lastName, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text: snapshot.data.rank, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text:snapshot.data.job, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text: snapshot.data.offre, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text: snapshot.data.prefoffre, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text: snapshot.data.experience, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text: snapshot.data.manager, style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        TextSpan(text: snapshot.data.joinDate.toString().substring(0,10), style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black87)),

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
        const SizedBox(height: 40,),
        MaterialButton(onPressed: (){
          showDialog(context: context,
              builder: (BuildContext context) {
                return UpdatePasswordDialog();
              });

        },child: RichText(
        text: const TextSpan(

        children: [
        WidgetSpan(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.0),
        child: Icon(Feather.edit),
        ),
        ),
        TextSpan(text: 'Editer Mot de passe ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),


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

        );
        })
              );
    }
      },
    );
  }
}
class MyProvider extends ChangeNotifier {
  var image;
  late String path ;


  MyProvider(this.path);

  Future setImage(img) async {
    this.image = img;
    this.path = "";
     this.path = img.path;
    this.notifyListeners();
  }

}


