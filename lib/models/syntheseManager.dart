
import 'dart:convert';

SyntheseManager syntheseManagerJson(String str)=> SyntheseManager.fromJson(json.decode(str));
class SyntheseManager{

  late int id;
  late String performance ;
  late String notePerformance ;
  late String contribution ;
  late String  noteContribution;
  late String rank;
  late String noteRank;
  late String user;

  SyntheseManager(
  {
    required this.id,
    required this.performance,
    required this.notePerformance,
    required this.contribution,
    required this.noteContribution,
    required this.rank,
    required this.noteRank,
    required this.user
  }
  );

  factory SyntheseManager.fromJson(Map<String,dynamic>json) =>SyntheseManager(id: json["id"], performance: json["performance"],
      notePerformance: json["notePerformance"], contribution: json["contribution"], noteContribution: json["noteContribution"],
      rank: json["rank"], noteRank: json["noteRank"], user: json["user"]["username"]);

  @override
  String toString() {
    return 'SyntheseManager{id: $id, performance: $performance, notePerformance: $notePerformance, contribution: $contribution, noteContribution: $noteContribution, rank: $rank, noteRank: $noteRank, user: $user}';
  }
}