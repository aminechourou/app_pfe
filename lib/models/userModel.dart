

import 'dart:convert';



import 'dart:core';


UserModel usereModelJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());
class UserModel {


  late  int id;
  late String userId;
  late String firstName;
  late String lastName;
  late String username;
  late String password;
  late String email;
  late String profileImageUrl;
  late String lastLoginDate;
  late String lastLoginDateDisplay;
  late String joinDate;
  late String role ;
  late String authorities;
  late bool isActive;
  late bool isNotLocked;
  late String rank;
  late String job;
  late String offre;
  late String prefoffre;
  late String experience;
   String manager ="no manager";


  UserModel(
  { required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.profileImageUrl,
    required this.joinDate,
    required this.role,
    required this.rank,
    required this.job,
    required this.offre,
    required this.prefoffre,
    required this.experience,
    required this.manager}
     );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel (
      userId:json["userId"] ,  firstName: json["firstName"], lastName: json["lastName"],
      username:json["username"],email: json["email"],profileImageUrl: json["profileImageUrl"],

      joinDate: json["joinDate"],role: json["role"],rank: json["rank"],job: json["job"],
      offre: json["offre"], prefoffre: json["prefOffre"],experience: json["experience"],
      manager: json["manager"],
        );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,

  };

  @override
  String toString() {
    return 'UserModel{ userId: $userId, firstName: $firstName, lastName: $lastName, username: $username, email: $email, profileImageUrl: $profileImageUrl joinDate: $joinDate, role: $role}';
  }
}