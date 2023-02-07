
import 'dart:convert';

DomaineCompetence projetJson(String str) =>
    DomaineCompetence.fromJson(json.decode(str));
class DomaineCompetence{
  late int id;
  late String titre;
  late String sousTitre;
  late String posture;
  late String autoEval;
  late String feedBack;
  late String user;

  DomaineCompetence({required this.id, required this.titre, required this.sousTitre, required this.posture,
    required this.autoEval,required this.feedBack,required this.user});
  
  factory DomaineCompetence.fromJson(Map<String,dynamic>json) => DomaineCompetence(id: json["id"], titre: json["titre"],
      sousTitre: json["sousTitre"], posture: json["posture"], autoEval: json["autoEval"], feedBack: json["managerEval"],
      user: json["user"]["username"]);

  @override
  String toString() {
    return 'DomaineCompetence{id: $id, titre: $titre, sousTitre: $sousTitre, posture: $posture, autoEval: $autoEval, feedBack: $feedBack, user: $user}';
  }
}