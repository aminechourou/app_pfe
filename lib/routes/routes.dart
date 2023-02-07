import 'package:devoteam/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class MyRouter{
  final LoginState loginState;
  MyRouter(this.loginState);

  late final router = GoRouter(
  refreshListenable: loginState,
  debugLogDiagnostics: true,
  urlPathStrategy: UrlPathStrategy.path,
  routes: [
    GoRoute(
      name: loginRouteName,
      path: '/login',
      pageBuilder: (context, state) => MaterialPage<void>(
        key: state.pageKey,
        child: LoginPage(),
      ),
    ),
  ],

  );
}
class LoginState extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _loggedIn = false;

  LoginState(this.prefs) {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
  }

  bool get loggedIn => _loggedIn;
  set loggedIn(bool value) {
    _loggedIn = value;
    prefs.setBool(loggedInKey, value);
    notifyListeners();
  }

  void checkLoggedIn() {
    loggedIn = prefs.getBool(loggedInKey) ?? false;
  }
}