import 'dart:convert';

import 'package:devoteam/models/SyntheseAutoEvalModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alertDialog.dart';

class SyntheseAutoEvalService{
  var baseUrl = "http://localhost:5000/autoEval/";

  Future<SyntheseAutoEvalModel?> add(String user,BuildContext context) async {
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
      final snackBar = SnackBar(content: Text("Synthése auto eval form created with success to user: "+user),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return SyntheseAutoEvalModel.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<SyntheseAutoEvalModel?> update(String user,String champ,String value,BuildContext context) async {
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

      return SyntheseAutoEvalModel.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }

  }
  Future<SyntheseAutoEvalModel?> getByUser(String user,BuildContext context) async {
    var url = baseUrl+"getAutoEvalByUser";
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

      return SyntheseAutoEvalModel.fromJson(responseJson);
    }


  }
}