import 'dart:convert';

Objective projetJson(String str) =>
    Objective.fromJson(json.decode(str));
class Objective{
 late int id;
 late String description;
 late String etat;
 late String user;

 Objective({required this.id, required this.description,required this.etat, required this.user});

 factory Objective.fromJson(json)=>Objective(id: json["id"], description: json["description"], etat: json["etat"],
     user: json["user"]["username"]);

 @override
  String toString() {
    return 'Objective{id: $id, description: $description, etat: $etat, user: $user}';
 }
}