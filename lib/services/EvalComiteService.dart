import 'dart:convert';

import 'package:devoteam/models/EvalComite.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alertDialog.dart';

class EvalComiteService{

  var baseUrl = "http://localhost:5000/evalComite/";
  Future<EvalComite?> add(String userName,BuildContext context)async{
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
      final snackBar = SnackBar(content: Text("Eval Comité form added with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return EvalComite.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<EvalComite?> update(String userName,String mission, String attenduVSrank,String contributions, String appreciation, String synthese_globale,BuildContext context)async{
    var url = baseUrl+"update";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    Map<String,dynamic> params = {
      "user":userName,
      "mission": mission,
      "attenduVSrank": attenduVSrank,
      "contributions": contributions,
      "appreciation": appreciation,
      "synthese_globale": synthese_globale,



    };
    var response = await http.post(Uri.parse(url).replace(queryParameters: params),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":"Bearer "+token!,
      },);
    Map<String,dynamic> responseJson = await jsonDecode(response.body);
    if(response.statusCode==200){
      final snackBar = SnackBar(content: Text("Eval Comité updated with success to user: "+userName),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return EvalComite.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<EvalComite?> getEvalComite(String userName,BuildContext context)async{
    var url = baseUrl+"getEvalComite";
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

      return EvalComite.fromJson(responseJson);
    }
    else {
      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
}