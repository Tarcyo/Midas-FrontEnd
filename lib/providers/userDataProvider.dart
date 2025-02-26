import 'package:flutter/foundation.dart';

class UserDataProvider with ChangeNotifier {
  List<dynamic> _variaveis = [];
  List<dynamic> _estrategias = [];
  List<dynamic> _commodities = [];
  List<dynamic> _sites = [];
  List<dynamic> _tokens = [];
  List<dynamic> _groups = [];

  // Getters
  List<dynamic> get variaveis => _variaveis;
  List<dynamic> get estrategias => _estrategias;
  List<dynamic> get commodities => _commodities;
  List<dynamic> get sites => _sites;
  List<dynamic> get tokens => _tokens;
  List<dynamic> get groups => _groups;

  // Setters
  set variaveis(List<dynamic> value) {
    _variaveis = value;
    notifyListeners();
  }

  set estrategias(List<dynamic> value) {
    _estrategias = value;
    notifyListeners();
  }

  set commodities(List<dynamic> value) {
    _commodities = value;
    notifyListeners();
  }

  set sites(List<dynamic> value) {
    _sites = value;
    notifyListeners();
  }

  set tokens(List<dynamic> value) {
    _tokens = value;
    notifyListeners();
  }

  set groups(List<dynamic> value) {
    _groups = value;
    notifyListeners();
  }

  // Métodos para adicionar itens
  void addVariavel(dynamic item) {
    _variaveis.add(item);
    notifyListeners();
  }

  void addEstrategia(dynamic item) {
    _estrategias.add(item);
    notifyListeners();
  }

  void addCommodity(dynamic item) {
    _commodities.add(item);
    notifyListeners();
  }

  void addSite(dynamic item) {
    _sites.add(item);
    notifyListeners();
  }

  void addToken(dynamic item) {
    _tokens.add(item);
    notifyListeners();
  }

  void addGroup(dynamic item) {
    _groups.add(item);
    notifyListeners();
  }

  // Métodos para limpar
  void cleanVariaveis() {
    _variaveis.clear();
    notifyListeners();
  }

  void cleanEstrategias() {
    _estrategias.clear();
    notifyListeners();
  }

  void cleanCommodities() {
    _commodities.clear();
    notifyListeners();
  }

  void cleanSites() {
    _sites.clear();
    notifyListeners();
  }

  void cleanTokens() {
    _tokens.clear();
    notifyListeners();
  }

  void cleanGroups() {
    _groups.clear();
    notifyListeners();
  }
}
