class Message {
  final String content;
  final String sender;
  final DateTime timestamp;
  final bool isFile;

  const Message({
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isFile = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
      sender: json['sender'],
      timestamp: DateTime.parse(json['timestamp']),
      isFile: json['isFile'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'content': content,
    'sender': sender,
    'timestamp': timestamp.toIso8601String(),
    'isFile': isFile,
  };
}