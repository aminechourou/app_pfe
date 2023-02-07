import 'dart:convert';
import 'dart:typed_data';
import 'package:devoteam/pages/admin/adminPanel.dart';
import 'package:devoteam/pages/manager/managerPanel.dart';
import 'package:devoteam/widgets/alertDialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';
import '../models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../pages/consultant/consultantPanel.dart';


class UserService{
  var baseUrl = "http://localhost:5000/user/";
  late String code;
  late String ConnectedUser;
  late String job;





  Future<UserModel?> registerEmployees(String username, String password, BuildContext context) async {

    var Url = baseUrl+"login";
    var response = await http.post(Uri.parse(Url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(<String, String>{
          "username": username,
          "password": password,
        }));



    String? token = response.headers["jwt-token"];
    Map<String, dynamic> responseJson = json.decode(response.body);

    if (response.statusCode == 200) {

      Map<String, dynamic> responseJson = await jsonDecode(response.body.toString());

     String role =responseJson["role"];
     String manager = responseJson["manager"];
      final prefs = await SharedPreferences.getInstance();
     prefs.setString("jwt-token", token.toString());
     prefs.setString("user", responseJson["username"]);
     prefs.setString("role", role);
     prefs.setString("manager", manager);
     ConnectedUser = responseJson["username"].toString();
     job =  responseJson["job"].toString();
       Widget body=getPanel(role);



      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => body,
        ),
      );
      final snackBar = SnackBar(content: Text("Welcome: "+responseJson["username"]),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

     
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });


    }
  }
  Future<List<UserModel>> getListUsers(String search)async{
    List<UserModel> userList= [];
    var url = baseUrl+"list";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");


    var response = await http.get(Uri.parse(url),
    headers: <String,String>{

      "Authorization":"Bearer "+token!,

    },);

    if(response.statusCode == 200)
         {
        var jsons = jsonDecode(response.body);

        if(search.compareTo("")== 0){

           for(var json in jsons)
  {       String name = json["username"];

    if(name.contains("_")){
      userList.add(UserModel.fromJson(json));
    }

  }
           print(userList.length);
           print("userList.length");


}
        else if(search.compareTo("")!= 0){

  for(var json in jsons)

  { String name = json["username"];
    name = name.toUpperCase();

    if(name.contains(search.toUpperCase()))
    {
      userList.add(UserModel.fromJson(json));
    }

  }
}


         }

    else {

      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }

    print(userList.length+1);
      return userList;
  }

















  Future<Map<String,String>?> sendOTP(BuildContext context,String email,String code)async{
    var url = baseUrl+"sendotp";
    Map<String, String> params = {
      "email": email,
      "code": code,
    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),

    headers: <String, String>{"Content-Type": "application/json"},
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    print(responseJson["message"]);
    final snackBar = SnackBar(content: Text(responseJson["message"]),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);



    }
  Future<Map<String, dynamic>?> resetPassword(String email, BuildContext context)async{
    var url = baseUrl+"resetpassword/"+email;
    var response =await http.get(Uri.parse(url));
    Map<String, dynamic> responseJson = json.decode(response.body);
    final snackBar = SnackBar(content: Text(responseJson["message"]),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void addUser(String fn,String ln,String em,String rank,String job, String exp,String offre,String prefoffre,String manager, BuildContext context)async{
    var url = baseUrl+"add";
    String role = "ROLE_USER";
    if(rank.toUpperCase().contains("MANAGER"))
      {
        role = "ROLE_MANAGER";
      }
    Map<String,String> params = {
      "firstName": fn,
      "lastName": ln,
      "username": fn.toUpperCase()+"_"+ln.toUpperCase(),
      "email": em,
      "role": role,
      "rank": rank,
      "job": job,
      "offre": offre,
      "prefoffre": prefoffre,
      "experience": exp,
      "manager": manager,
      "isActive": "true",
      "isNonLocked": "true"
    };
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
      "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200)
      {
        final snackBar = SnackBar(content: Text(r"user "+responseJson["username"]+" added with success"),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }

   else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  List<String> getManagers(List<UserModel> users){

     List<String> manager=[];


    for(UserModel user in users){
      if(user.role.compareTo("ROLE_MANAGER")==0)
        { if(manager.contains(user.username)==false)
          {
            manager.add(user.username);
          }

        }
    }



    return manager;
   }
  void deleteUser(String userName, BuildContext context) async{
    var url = baseUrl+"delete/"+userName;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    var response =await http.delete(Uri.parse(url),headers: <String, String>{
      "Content-Type": "application/json",
      "Authorization":"Bearer "+token!,
    },);
    Map<String, dynamic> responseJson = json.decode(response.body);
    String message = responseJson["message"];
    final snackBar = SnackBar(content: Text(message),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if(message.compareTo("User deleted successfully")==0)
      {
        Navigator.push(context,
          MaterialPageRoute(
            builder: (context) => AdminPanel(index: 1),
          ),
        );
      }
}
  void updateUser(String currentUser,String fn,String ln,String em,String rank,String job, String exp,String offre,String prefoffre,String manager, BuildContext context)async{
    var url = baseUrl+"update";
    String role = "ROLE_USER";
    if(rank.toUpperCase().contains("MANAGER"))
    {
      role = "ROLE_MANAGER";
    }
    Map<String,String> params = {
      "currentUsername":currentUser,
      "firstName": fn,
      "lastName": ln,
      "username": fn.toUpperCase()+"_"+ln.toUpperCase(),
      "email": em,
      "role": role,
      "rank": rank,
      "job": job,
      "offre": offre,
      "prefoffre": prefoffre,
      "experience": exp,
      "manager": manager,
      "isActive": "true",
      "isNonLocked": "true"
    };
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200)
    {
      final snackBar = SnackBar(content: Text("user "+responseJson["username"]+" updated with success"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => AdminPanel(index: 1),
        ),
      );

    }

    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<UserModel?> getUser()async{
    final prefs = await SharedPreferences.getInstance();
    String? userName =prefs.getString("user");
    String? token = prefs.getString("jwt-token");
    var url = baseUrl+"find/"+userName!;
    var response = await  http.get(Uri.parse(url),headers: <String, String>{
    "Content-Type": "application/json",
    "Authorization":"Bearer "+token!,
  },);
    if (response.statusCode == 200) {

      Map<String, dynamic> responseJson = await jsonDecode(response.body.toString());


      final prefs = await SharedPreferences.getInstance();
      prefs.setString("jwt-token", token.toString());
      prefs.setString("user", responseJson["username"]);



      UserModel u = UserModel(userId: responseJson["userId"], firstName: responseJson["firstName"],
          lastName: responseJson["lastName"], username: responseJson["username"], email:responseJson ["email"],
          profileImageUrl:responseJson ["profileImageUrl"],

          joinDate:responseJson ["joinDate"], role: responseJson["role"],
          rank: responseJson["rank"],job: responseJson["job"],
          offre: responseJson["offre"], prefoffre: responseJson["prefOffre"],
          experience: responseJson["experience"],
          manager: responseJson["manager"]);
      return u;
    }

  }
  Future updateProfileImage(XFile image) async{
    var url = baseUrl+"updateProfileImage";
    final prefs = await SharedPreferences.getInstance();
    String? userName =prefs.getString("user");
    String? token = prefs.getString("jwt-token");
    Uint8List data = await image.readAsBytes();
    List<int> list = data.cast();

    var headers= <String, String>{
      "Content-Type":"multipart/form-data",
      "Authorization":"Bearer "+token!,
    };
    //Map<String,dynamic> params =;
    var request = http.MultipartRequest('POST', Uri.parse(url).replace(queryParameters:  {
      "username": userName!,
      "imagename":image.name,


    }));
    request.headers.addAll(headers);
    var picture = http.MultipartFile.fromBytes('profileImage',data,
        filename: "profileimage"+userName,contentType:MediaType("image","png") );
    request.files.add(picture);



    // Now we can make this call

    var response = await request.send();
    //We've made a post request...
    //Let's read response now

    response.stream.bytesToString().asStream().listen((event) {
      var parsedJson = json.decode(event);
      print(parsedJson);
      print(response.statusCode);

      //It's done...
    });

  }
  Future updatePassword(String oldPassword,String newPassword,BuildContext context)async{
    var url = baseUrl+"updatepassword";
    final prefs = await SharedPreferences.getInstance();
    String? userName =prefs.getString("user");
    String? token = prefs.getString("jwt-token");
    Map<String, String> params = {
      "newPassword": newPassword,
      "checkPassword": oldPassword,
      "user":userName!
    };
    var headers= <String, String>{
      "Content-Type":"application/json",
      "Authorization":"Bearer "+token!,
    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),headers: headers);
    Map<String, dynamic> responseJson = json.decode(response.body);
    final snackBar = SnackBar(content: Text(responseJson["message"]),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    if(responseJson["message"].compareTo("Password updated successfully")==0)
      {
        Navigator.of(context).pop();
      }


  }
  Future<List<UserModel>> getListUsersByManager(String search)async{
    List<UserModel> userList= [];
    var url = baseUrl+"list";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    String? userName =prefs.getString("user");
    var response = await http.get(Uri.parse(url),
      headers: <String,String>{

        "Authorization":"Bearer "+token!,

      },);

    if(response.statusCode == 200)
    {
      var jsons = jsonDecode(response.body);

      if(search.compareTo("")== 0){
        for(var json in jsons)
        { String manager =json["manager"];
        if(manager.toUpperCase().compareTo(userName!.toUpperCase())==0)
        {
          userList.add(UserModel.fromJson(json));
        }
        }


      }
      else {

        for(var json in jsons)

        { String name = json["username"];
        String manager =json["manager"];
        name = name.toUpperCase();
        if(manager.toUpperCase().compareTo(userName!.toUpperCase())==0){
          if(name.contains(search.toUpperCase()))
          {
            userList.add(UserModel.fromJson(json));
          }
        }


        }
      }


    }

    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }


    return userList;
  }
  List<String> getUsersNamesByManager(List<UserModel> users){
  List<String> userNames=[];


    for(UserModel user in users){
     userNames.add(user.username);
    }



    return userNames;
  }
  Widget getPanel(String role) {
    Widget body= ManagerPanel(index: 0,);
    switch(role.toUpperCase()){
      case "ROLE_USER": body = UserPanel(index: 0,connectedUser:ConnectedUser ,job: job,);
      break;
      case "ROLE_MANAGER": body = ManagerPanel(index: 0,);
      break;
      case "ROLE_ADMIN":body = AdminPanel(index: 0);
      break;
      case "ROLE_SUPER_ADMIN":body = AdminPanel(index: 0);

    }
    return body;
  }
  Future updateRank(String user,BuildContext context)async{
    var url =baseUrl+"updateRank";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,String> params = {
    "userName":user,};
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200)
      {
        final snackBar = SnackBar(content: Text("user :"+responseJson["username"]+"rank updated to "+ responseJson["rank"]+"with success"),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    else{
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
}

