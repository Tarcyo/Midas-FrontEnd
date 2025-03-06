import 'package:flutter/material.dart';
import 'package:midas/constants.dart';
import 'package:midas/services/socket/socketService.dart';
import 'package:provider/provider.dart';
import 'MyMessage.dart';
import 'OtherMessage.dart';

class GroupScreen extends StatefulWidget {
  final String name;
  GroupScreen(this.name);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _textController = TextEditingController();

  List<Widget> _mensagens = [];
  late final SocketService socketService;
  @override
  void initState() {
    super.initState();
    socketService = Provider.of<SocketService>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    // _mensagens.insert(0, OtherMessage("teste"));
    super.didChangeDependencies();

    socketService.onMessageReceived((Map<String, dynamic> messageData) {
      print("📩 Mensagem recebida: $messageData");

      final String message = messageData['message'] ?? '';
      final String sender = messageData['socketId'] ?? ''; // 🔹 Correção aqui

      if (mounted) {
        setState(() {
          print("🆕 Nova mensagem: $message");

          if (sender == socketService.currentUser?["socketId"]) {
            _mensagens.insert(0, MyMessage(message));
          } else {
            _mensagens.insert(0, OtherMessage(message));
          }

          _mensagens.insert(1, SizedBox(height: 30));
        });
      }
    });

    if (socketService.currentUser == null) {
      print("Erro: currentUser ainda não está definido.");
    }
  }

  void _sendMessage() {
    if (_textController.text.isNotEmpty) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      String roomName = widget.name;

      socketService.sendMessage(_textController.text, roomName);

      setState(() {
        _mensagens.insert(0, MyMessage(_textController.text));
        _textController.clear();
        _mensagens.insert(1, SizedBox(height: 30));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: secondaryColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: mainColor,
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: List.from(_mensagens.reversed),
              ),
            ),
          ),
          Container(
            color: mainColor,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: TextField(controller: _textController),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(8),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 25,
                      color: mainColor,
                    ),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
