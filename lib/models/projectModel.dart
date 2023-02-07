

import 'dart:convert';

Projet projetJson(String str) =>
    Projet.fromJson(json.decode(str));



class Projet{
  late int id;
  late String titre;
  late String description;
  late String dure;
  late String etat;
  late String client;
  late String chef;

  Projet({required this.id,required this.titre,required this.description,required this.dure,required this.etat,
   required this.client,required this.chef});

  factory Projet.fromJson(Map<String,dynamic>json)=>Projet(id: json["id"], titre: json["titre"],
      description: json["description"], dure: json["dure"], etat: json["etat"],
      client: json["client"], chef: json["chef"]["username"]);

  @override
  String toString() {
    return 'Projet{id: $id, titre: $titre, description: $description, dure: $dure, etat: $etat, client: $client, chef: $chef}';
  }
}
