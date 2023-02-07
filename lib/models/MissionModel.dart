
import 'dart:convert';

Mission projetJson(String str) =>
    Mission.fromJson(json.decode(str));
class Mission{
 late int id;
 late String realisation;
 late String autoEval;
 late String feedBackManager;
 late String etat;
 late String user;
 late String projet;

 Mission({required this.id, required this.realisation, required this.autoEval, required this.feedBackManager,
   required this.etat,required this.user,required this.projet});
 factory Mission.fromJson(json)=>Mission(id: json["id"], realisation: json["realisation"], autoEval: json["autoEval"],
     feedBackManager: json["feedBackManager"], etat: json["etat"],user: json["user"]["username"],projet: json["projet"]["titre"]);
 
}