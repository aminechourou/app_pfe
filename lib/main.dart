import 'package:devoteam/models/Trajectoire.dart';
import 'package:devoteam/pages/commun%20pages/TrajectoireMangerAndUser.dart';
import 'package:devoteam/pages/login/login.dart';
import 'package:devoteam/pages/manager/managerPanel.dart';
import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEVOTEAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,

      ),
      home: LoginPage()
    );
  }
}
