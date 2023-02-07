import 'dart:convert';

import 'package:devoteam/models/Trajectoire.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alertDialog.dart';

class TrajectoireService{
  var baseUrl = "http://localhost:5000/trajectoire/";

  Future<Trajectoire?> add(String userName,BuildContext context)async{
    var url = baseUrl+"add";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {

      "user":userName,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: Text("Trajectoire added with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Trajectoire.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<Trajectoire?> update(String userName,String progression_visee, String progression_tech,String nextJob_visee, String nextJob_tech, String nextRank_visee,String nextRank_tech,String actions,BuildContext context)async{
    var url = baseUrl+"update";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "user":userName,
      "progression_visee": progression_visee,
      "progression_tech": progression_tech,
      "nextJob_visee": nextJob_visee,
      "nextJob_tech": nextJob_tech,
      "nextRank_visee": nextRank_visee,
      "nextRank_tech": nextRank_tech,
      "actions": actions,


    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: Text("Trajectoire updated with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Trajectoire.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<Trajectoire?> getTrajectoire(String userName,BuildContext context)async{
    var url = baseUrl+"getTrajectoire";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {

      "user":userName,

    };
    var response = await http.get(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){

      return Trajectoire.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
}