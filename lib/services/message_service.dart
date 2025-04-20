import 'dart:async';
import 'package:mesh_app/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageService {
  final List<Message> _messages = [];
  final StreamController<List<Message>> _controller = 
      StreamController<List<Message>>.broadcast();

  MessageService() {
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final messagesJson = prefs.getStringList('messages') ?? [];
    _messages.addAll(messagesJson.map((json) => Message.fromJson(json)));
    _updateStream();
  }

  Future<void> sendMessage(Message message) async {
    _messages.add(message);
    _updateStream();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'messages',
      _messages.map((msg) => msg.toJson()).toList(),
    );
  }

  void _updateStream() {
    _controller.add(List<Message>.from(_messages));
  }

  Stream<List<Message>> get messagesStream => _controller.stream;
}