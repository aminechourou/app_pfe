import 'dart:convert';

import 'package:devoteam/models/SyntheseAutoEvalModel.dart';
import 'package:devoteam/models/syntheseManager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alertDialog.dart';

class SyntheseManagerService{
  var baseUrl = "http://localhost:5000/managerEval/";

  Future<SyntheseManager?> add(String user,BuildContext context) async {
    var url = baseUrl+"add";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "user":user,

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: Text("Synthése manager form created with success to user: "+user),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return SyntheseManager.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<SyntheseManager?> update(String user,String champ,String value,BuildContext context) async {
    var url = baseUrl+"update";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "user":user,
      "champ":champ,
      "value":value

    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){

      return SyntheseManager.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<SyntheseManager?> getByUser(String user,BuildContext context) async {
    var url = baseUrl+"getManagerEvalByUser";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "user":user,

    };
    var response = await http.get(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){

      return SyntheseManager.fromJson(responseJson);
    }


  }
}