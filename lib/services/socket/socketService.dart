import 'package:midas/providers/authProvider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:flutter/material.dart';

class SocketService extends ChangeNotifier {
  static final SocketService _instance = SocketService._internal();
  factory SocketService(AuthProvider authProvider) {
    _instance._init(authProvider);
    return _instance;
  }

  late io.Socket _socket;
  bool _isConnected = false;
  Map<String, dynamic>? currentUser;
  String? socketId;
  String? userName;
  void updateConnectionStatus(bool status) {
    _isConnected = status;
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }

  SocketService._internal();

  void _init(AuthProvider authProvider) {
    print("tokennn ${authProvider.token}");

    if (userName == null) {
      // Para evitar re-inicialização
      print("aquiiiiii ${authProvider.email}");
      userName = authProvider.email;
      _connect();
    }
  }

  void _connect() {
    _socket = io.io('http://127.0.0.1:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      _isConnected = true;
      socketId = _socket.id;
      print('✅ Conectado ao servidor com ID: $socketId');
      print('👤 Meu Nome: $userName');

      _socket.emit("getUser", {
        "user": {
          "name": userName,
          "socketId": socketId,
        },
      });

      notifyListeners();
    });

    _socket.on('getUser', (userData) {
      print("Usuário recebido: $userData");
      currentUser = userData;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      print('❌ Desconectado do servidor');
      notifyListeners();
    });
  }

  void onMessageReceived(Function(Map<String, dynamic>) callback) {
    if (!_isConnected) {
      _connect();
    }

    _socket.on("sendChat", (data) {
      if (data is Map<String, dynamic>) {
        // 🔹 Certifica que os dados têm a estrutura esperada
        print("📩 Mensagem recebida: $data");
        callback(data);
      } else {
        print("⚠️ Erro: Formato inesperado da mensagem recebida: $data");
      }
    });
  }

  void sendMessage(String message, String roomName) {
    if (_isConnected) {
      _socket.emit("chat", {
        "message": message,
        "roomName": roomName,
      });
    } else {
      print("⚠️ Erro: Não conectado ao servidor.");
    }
  }

  void createRoom(String roomName) {
    if (_isConnected) {
      _socket.emit("createRoom", roomName);
    } else {
      print("⚠️ Erro: Não conectado ao servidor.");
    }
  }

  void printMensagens() {
    print("Messagems");
  }

  void joinRoom(String roomName) {
    if (_isConnected) {
      _socket.emit("joinRoom", roomName);
    } else {
      print("⚠️ Erro: Não conectado ao servidor.");
    }
  }

  void listenToMessages(Function(String, String) callback) {
    _socket.on("sendChat", (data) {
      print("entroi na funcao");
      if (data is Map &&
          data.containsKey("message") &&
          data.containsKey("socketId")) {
        callback(data["message"].toString(), data["socketId"].toString());
      }
    });
  }

  void disconnect() {
    _socket.disconnect();
    _isConnected = false;
  }
}
