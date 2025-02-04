import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';
  String _id = "";
  String _email = "";
  // Getter para o token
  String get token => _token;
  String get id => _id;
  String get email => _email;
  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  void setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void setId(String newId) {
    _id = newId;
    notifyListeners();
  }

  void clearToken() {
    _token = '';
    notifyListeners();
  }

  void clearEmail() {
    _email = '';
    notifyListeners();
  }

  void clearId() {
    _id = '';
    notifyListeners();
  }

  void cleanAll() {
    clearEmail();
    clearId();
    clearToken();
  }

  bool get isAuthenticated => _token.isNotEmpty;
}
