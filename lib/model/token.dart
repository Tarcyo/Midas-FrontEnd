class Token {
  final String id;
  final String token;

  Token({required this.id, required this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(id: json['id'], token: json['token']);
  }
}