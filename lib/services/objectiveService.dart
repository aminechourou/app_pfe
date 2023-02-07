import 'dart:convert';

import 'package:devoteam/models/Objective.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alertDialog.dart';

class ObjectiveService{
  var baseUrl = "http://localhost:5000/objectives/";

  Future<Objective?> add(String userName,String description,String etat,BuildContext context)async{
    var url = baseUrl+"add";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "description":description,
      "etat":etat,
      "user":userName,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: Text("Objective added with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Objective.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<Objective?> updateEtat(int id,BuildContext context)async{
    var url = baseUrl+"updateEtat";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {

      "id":id,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      const snackBar =  SnackBar(content: Text("Objective Etat marked as approved with success"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Objective.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<Objective?> updateDescription(int id,String description,BuildContext context)async{
    var url = baseUrl+"updateDescription";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "description":description,
      "id":id.toString(),

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      const snackBar =  SnackBar(content: Text("Objective Description updated with success"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Objective.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future delete(int id,BuildContext context)async{
    var url = baseUrl+"delete";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "id":id.toString(),
    };
    var response = await http.delete(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      const snackBar =  SnackBar(content: Text("Objective deleted with success"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<List<Objective>?> getObjectives(String userName)async{
    var url = baseUrl+"list";
    List<Objective> list = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "user":userName,

    };
    var response = await http.get(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Authorization":"Bearer "+token!,
      },);

    if(response.statusCode == 200)
    {
      var jsons = jsonDecode(response.body);


      for(var json in jsons)
      {
        list.add(Objective.fromJson(json));

      }


    }
    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }
    return list;
  }

}