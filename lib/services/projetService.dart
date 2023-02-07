import 'dart:convert';
import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/projectModel.dart';
import '../widgets/alertDialog.dart';
class ProjetService{
  var baseUrl = "http://localhost:5000/projet/";
  Future<void> addProjet(String dure,String titre,String chef,String description,String client, BuildContext context) async {
    var url = baseUrl+"add";
    Map<String,String> params = {
      "titre": titre,
      "etat": "regie",
      "duree": dure,
      "description": description,
      "chef":chef,
      "client":client,
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
        final snackBar = SnackBar(content: Text("Projet :"+titre+" added with success"),);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    else {

      showDialog(context: context,
          builder: (BuildContext context) {
            return AdvanceCustomAlert(responseJson["message"]);
          });
    }
  }
  Future<List<Projet>> getProjects()async{
    List<Projet> projects = [];
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

  print(jsons);
      for(var json in jsons)
      {
        projects.add(Projet.fromJson(json));

      }
      print(projects);

    }

    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }
    print("bbbbbbb");


    return projects;
  }
  Future<List<Projet>> getProjectsRegie(String search)async{
    List<Projet> projects = [];
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

      print("jsons");
      if (search.compareTo("") == 0) {
        print("case 1");
        for (var json in jsons) {
          String etat = json["etat"];
          if (etat.compareTo("regie") == 0) {
            print("case 2");
            projects.add(Projet.fromJson(json));
          }
        }
      }
      else {
        print("case 3");
        for (var json in jsons) {
          String etat = json["etat"];
          String client = json["client"].toString().toUpperCase();
          String manager = json["chef"].toString().toUpperCase();
          String titre = json["titre"].toString().toUpperCase();

          if (etat.compareTo("regie") == 0) {
            print("case 2--------------");
            if((client.contains(search.toUpperCase())==true)||(manager.contains(search.toUpperCase())==true)||(titre.contains(search.toUpperCase())==true))
            {
              projects.add(Projet.fromJson(json));
            }

          }
        }
      }


    }

    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }
    print("bbbbbbb");


    return projects;
  }
  Future<List<Projet>> getProjectsForfait(String search)async{
    List<Projet> projects = [];
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

      print("jsons");
      if (search.compareTo("") == 0) {
        print("case 1");
        for (var json in jsons) {
          String etat = json["etat"];
          if (etat.compareTo("forfait") == 0) {
            print("case 2");
            projects.add(Projet.fromJson(json));
          }
        }
      }
      else {
        print("case 3");
        for (var json in jsons) {
          String etat = json["etat"];
          String client = json["client"].toString().toUpperCase();
          String manager = json["chef"].toString().toUpperCase();
          String titre = json["titre"].toString().toUpperCase();

          if (etat.compareTo("forfait") == 0) {
            print("case 2--------------");
          if((client.contains(search.toUpperCase())==true)||(manager.contains(search.toUpperCase())==true)||(titre.contains(search.toUpperCase())==true))
            {
              projects.add(Projet.fromJson(json));
            }

          }
        }
      }


    }

    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }



    return projects;
  }
  Future<List<Projet>> getProjectsRegieByManager(String search)async{
    List<Projet> projects = [];
    var url = baseUrl+"list";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    String? userName =prefs.getString("user");
    String? m =prefs.getString("manager");
    String value;
    if(m!.compareTo("no manager")==0){value = userName!;}
    else{value = m;}


    var response = await http.get(Uri.parse(url),
      headers: <String,String>{

        "Authorization":"Bearer "+token!,

      },);


    if(response.statusCode == 200)
    {
      var jsons = jsonDecode(response.body);

      print("jsons");
      if (search.compareTo("") == 0) {
        print("case 1");
        for (var json in jsons) {
          String etat = json["etat"].toString();
          String manager = json["chef"]["username"].toString();

          if (etat.compareTo("regie") == 0) {
            print("case 2");
            if(manager.toUpperCase().compareTo(value.toUpperCase())==0){projects.add(Projet.fromJson(json));}

          }
        }
      }
      else {
        print("case 3");
        for (var json in jsons) {
          String etat = json["etat"].toString();
          String client = json["client"].toString().toUpperCase();
          String manager = json["chef"]["username"].toString().toUpperCase();
          String titre = json["titre"].toString().toUpperCase();

          if ((etat.compareTo("regie") == 0)) {
            print("case 2--------------");

            if((manager.compareTo(value.toString().toUpperCase())==0)){
              if((client.contains(search.toUpperCase())==true)||(titre.contains(search.toUpperCase())==true))
              {
                projects.add(Projet.fromJson(json));
              }
            }


          }
        }
      }


    }

    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }



    return projects;
  }




  Future<List<Projet>> getProjectsForfaitByManager(String search)async{
    List<Projet> projects = [];
    var url = baseUrl+"list";
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
    String? userName =prefs.getString("user");
    String? m =prefs.getString("manager");
    String value;
    if(m!.compareTo("no manager")==0){value = userName!;}
    else{value = m;}

    var response = await http.get(Uri.parse(url),
      headers: <String,String>{

        "Authorization":"Bearer "+token!,

      },);

    if(response.statusCode == 200)
    {
      var jsons = jsonDecode(response.body);

      print("jsons");
      if (search.compareTo("") == 0) {
        print("case 1");
        for (var json in jsons) {
          String etat = json["etat"].toString();
          String manager = json["chef"]["username"].toString();

          if (etat.compareTo("forfait") == 0) {
            print("case 2");
            if(manager.toUpperCase().compareTo(value.toUpperCase())==0){projects.add(Projet.fromJson(json));}

          }
        }
      }
      else {
        print("case 3");
        for (var json in jsons) {
          String etat = json["etat"].toString();
          String client = json["client"].toString().toUpperCase();
          String manager = json["chef"]["username"].toString().toUpperCase();
          String titre = json["titre"].toString().toUpperCase();

          if ((etat.compareTo("forfait") == 0)) {
            print("case 2--------------");

            if((manager.compareTo(value.toString().toUpperCase())==0)){
              if((client.contains(search.toUpperCase())==true)||(titre.contains(search.toUpperCase())==true))
              {
                projects.add(Projet.fromJson(json));
              }
            }


          }
        }
      }


    }

    else {
      var responseJson = jsonDecode(response.body.toString());
      print(responseJson["message"]);
    }



    return projects;
  }
  Future<Projet?> getProjectWithTitle(String titre)async{
    var url = baseUrl+titre;
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("jwt-token");
   var response = await http.get(Uri.parse(url),headers: <String,String>{

     "Authorization":"Bearer "+token!,

   },);
   if(response.statusCode == 200)
     { Map<String, dynamic> responseJson = await jsonDecode(response.body.toString());
       Projet p = Projet.fromJson(responseJson);
       return p;
     }

  }
}