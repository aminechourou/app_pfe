
import 'dart:convert';

EvalComite projetJson(String str) =>
    EvalComite.fromJson(json.decode(str));
class EvalComite{
  late int id;
  late String mission;
  late String attenduVSrank;
  late String contributions;
  late String appreciation;
  late String synthese_globale;
  late String user;

  EvalComite({
    required this.id,required this.mission,required this.attenduVSrank,required this.contributions,
    required this.appreciation, required this.synthese_globale, required this.user
});

  factory EvalComite.fromJson(json)=>EvalComite(id: json["id"], mission: json["mission"], attenduVSrank: json["attenduVSrank"],
      contributions: json["contributions"], appreciation: json["appreciation"], synthese_globale: json["synthese_globale"],
      user: json["user"]["username"]);

  @override
  String toString() {
    return 'EvalComite{id: $id, mission: $mission, attenduVSrank: $attenduVSrank, contributions: $contributions, appreciation: $appreciation, synthese_globale: $synthese_globale, user: $user}';
  }
}