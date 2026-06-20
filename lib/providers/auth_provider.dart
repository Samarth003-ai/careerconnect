import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  //listens to changes in state

  String? token;

  bool get isLoggedIn => //true or false
      token != null;

  void setToken(String newToken) {
    //store jwt token

    token = newToken;

    notifyListeners(); //tells flutter to rebuild ui
  }

  void logout() {
    token = null;

    notifyListeners();
  }
}
