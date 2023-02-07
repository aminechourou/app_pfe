import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/MissionModel.dart';
import '../widgets/alertDialog.dart';
class MissionService{
  var baseUrl = "http://localhost:5000/mission/";


  Future<Mission?> addMission(int idProject,String realisation,String userName,BuildContext context)async{
    var url = baseUrl+"add/"+idProject.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "realisation":realisation,
      "user":userName,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: Text("Mission added with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Mission.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<Mission?> updateAutoEvalMission(int idMission,String autoEval,BuildContext context)async{
    var url = baseUrl+"updateautoeval/"+idMission.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {

      "autoeval":autoEval,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: const Text("Auto Eval commited successfully"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Mission.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<Mission?> updateFeedbackMission(int idMission,String feedback,BuildContext context)async{
    var url = baseUrl+"updatefeedback/"+idMission.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {

      "feedback":feedback,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){

      final snackBar = SnackBar(content: const Text("Manager feedback commited successfully"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Mission.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<Mission?> updateRealisationMission(int idMission,String realisation,BuildContext context)async{
    var url = baseUrl+"updaterealisation/"+idMission.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "realisation":realisation,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: const Text("Mission realisation updated successfully"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Mission.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<Mission?> updateEtatMission(int idMission,BuildContext context)async{
    var url = baseUrl+"updateEtat/"+idMission.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");

    var response = await http.post(Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);


    if(response.statusCode==200){
      const snackBar = SnackBar(content: Text("Mission Marked as done successfully"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Mission.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  void deleteMission(int id,BuildContext context)async{
    var url =baseUrl+"delete/"+id.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    var response = await http.delete(Uri.parse(url),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    final snackBar = SnackBar(content:  Text(responseJson["message"]),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  Future<List<Mission>> getMissionByProjects(int idProject)async{
    List<Mission> list = [];
    var url = baseUrl+"listwithproject/"+idProject.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    var response = await http.get(Uri.parse(url),
      headers: <String, String>{

        "Authorization":"Bearer "+token!,
      },);
    if(response.statusCode == 200)
    {
      var jsons = jsonDecode(response.body);


      for(var json in jsons)
      {
        list.add(Mission.fromJson(json));

      }


    }
    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }
    return list;
  }
  Future<List<Mission>> getMissionByUser()async{
    List<Mission> list = [];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    String? userName = prefs.getString("user");
    var url = baseUrl+"listwithuser/"+userName!;

    var response = await http.get(Uri.parse(url),
      headers: <String, String>{

        "Authorization":"Bearer "+token!,
      },);
    if(response.statusCode == 200)
    {
      var jsons = jsonDecode(response.body);


      for(var json in jsons)
      {
        list.add(Mission.fromJson(json));

      }


    }
    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }
    return list;
  }


}