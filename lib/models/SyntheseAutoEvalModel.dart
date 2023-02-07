
import 'dart:convert';

SyntheseAutoEvalModel SyntheseJson(String str)=> SyntheseAutoEvalModel.fromJson(json.decode(str));
class SyntheseAutoEvalModel{
  late int id;
  late String ptsForts;
  late String ptsFortsManager;
  late String enseignements;
  late String enseignementsManager;
  late String axes;
  late String axesManager;
  late String satisfaction;
  late String attentes;
  late String userName;

  SyntheseAutoEvalModel({
    required this.id,
    required this.ptsForts,
    required this.ptsFortsManager,
    required this.enseignements,
    required this.enseignementsManager,
    required this.axes,
    required this.axesManager,
    required this.satisfaction,
    required this.attentes,
    required this.userName});

  factory SyntheseAutoEvalModel.fromJson(Map<String,dynamic>json)=>SyntheseAutoEvalModel(id: json["id"],
      ptsForts: json["ptsForts"], ptsFortsManager: json["ptsFortsManger"], enseignements: json["enseignements"],
      enseignementsManager: json["enseignementsManager"], axes: json["axesAmeliorations"],
      axesManager: json["axesAmeliorationsManager"], satisfaction: json["satisfaction"], attentes: json["attentes"],
      userName: json["user"]["username"]);

  @override
  String toString() {
    return 'SyntheseAutoEvalModel{id: $id, ptsForts: $ptsForts, ptsFortsManager: $ptsFortsManager, enseignements: $enseignements, enseignementsManager: $enseignementsManager, axes: $axes, axesManager: $axesManager, satisfaction: $satisfaction, attentes: $attentes, userName: $userName}';
  }
}