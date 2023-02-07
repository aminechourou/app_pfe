import 'dart:convert';

Trajectoire projetJson(String str) =>
    Trajectoire.fromJson(json.decode(str));
class Trajectoire {
  late int id;
  late String progression_visee;
  late String progression_tech;
  late String nextJob_visee;
  late String nextJob_tech;
  late String nextRank_visee;
  late String nextRank_tech;
  late String actions;
  late String user;

  Trajectoire({ required this.id,
    required this.progression_visee,
    required this.progression_tech,
    required this.nextJob_visee,
    required this.nextJob_tech,
    required  this.nextRank_visee,
    required this.nextRank_tech,
    required this.actions,
    required this.user});

  factory Trajectoire.fromJson(json)=>Trajectoire(id: json["id"], progression_visee:  json["progression_visee"],
      progression_tech:  json["progression_tech"], nextJob_visee:  json["nextJob_visee"], nextJob_tech:  json["nextJob_tech"],
      nextRank_visee:  json["nextRank_visee"], nextRank_tech:  json["nextRank_tech"], actions:  json["actions"],
      user: json["user"]["username"]);

  @override
  String toString() {
    return 'Trajectoire{id: $id, progression_visee: $progression_visee, progression_tech: $progression_tech, nextJob_visee: $nextJob_visee, nextJob_tech: $nextJob_tech, nextRank_visee: $nextRank_visee, nextRank_tech: $nextRank_tech, actions: $actions, user: $user}';
  }
}