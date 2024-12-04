import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';

  // Getter para o token
  String get token => _token;

  // Função para definir o token
  void setToken(String newToken) {
    _token = newToken;
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  // Função para limpar o token
  void clearToken() {
    _token = '';
    notifyListeners();
  }

  // Função para verificar se o usuário está autenticado
  bool get isAuthenticated => _token.isNotEmpty;
}