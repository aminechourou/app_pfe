import 'dart:convert';

import 'package:devoteam/models/DomaineCompetenceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alertDialog.dart';

class DomaineCompetenceService{
  var baseUrl = "http://localhost:5000/domainecompetence/";

   createRank(String userName,BuildContext context) async {
    var url = baseUrl+"createRank";
    print("hhhhhhhhhhh "+userName);
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
    print(responseJson);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: Text("Rank Eval Form created with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<void> createContribution(String userName,BuildContext context) async {
    var url = baseUrl+"createContribution";
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
      final snackBar = SnackBar(content: Text("Contribution Eval Form created with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<List<DomaineCompetence>> getDcByUser(String titre,String user)async{
    List<DomaineCompetence> list=[];
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");


    var url = baseUrl+"listwithuser";

    Map<String,dynamic> params = {
      "titre":titre,
      "user":user

    };
    var response = await http.get(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);


    var jsons = jsonDecode(response.body.toString());
    if(response.statusCode==200){

      for(var json in jsons)
        {
          list.add(DomaineCompetence.fromJson(json));
        }
      print("size"+list.length.toString());
      return list;
    }
    else{

      print(jsons["message"]);
    }


    return list;
  }
  Future<DomaineCompetence?> updateAutoEval(String value,int id,BuildContext context) async {
    var url = baseUrl+"updateAutoEval/"+id.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "autoEval":value,

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
      return DomaineCompetence.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<DomaineCompetence?> updateFeedBack(String value,int id,BuildContext context) async {
    var url = baseUrl+"updateFeedBack/"+id.toString();
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "feedback":value,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: const Text("FeedBack commited successfully"),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return DomaineCompetence.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }

}