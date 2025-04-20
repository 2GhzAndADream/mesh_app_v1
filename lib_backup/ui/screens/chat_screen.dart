import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mesh_app/models/message.dart';
import 'package:mesh_app/models/peer_device.dart';
import 'package:mesh_app/services/message_service.dart';
import 'package:mesh_app/services/file_service.dart';
import 'package:mesh_app/widgets/file_picker.dart';

class ChatScreen extends StatefulWidget {
  final PeerDevice peer;
  const ChatScreen({super.key, required this.peer});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final MessageService _messageService = MessageService();

  Future<void> _sendFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    final file = result.files.first;
    final compressedFile = await FileService.compressFile(File(file.path!));

    _messageService.sendMessage(Message(
      content: compressedFile.path,
      sender: 'Me',
      timestamp: DateTime.now(),
      isFile: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.peer.name)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _messageService.messagesStream,
              builder: (ctx, snapshot) {
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    final msg = messages[index];
                    return ListTile(
                      title: msg.isFile
                          ? Image.file(File(msg.content))
                          : Text(msg.content),
                      subtitle: Text('${msg.sender} • ${msg.timestamp.hour}:${msg.timestamp.minute}'),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                FilePickerButton(onFileSelected: (file) => _sendFile()),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Type message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isEmpty) return;
                    _messageService.sendMessage(Message(
                      content: _controller.text,
                      sender: 'Me',
                      timestamp: DateTime.now(),
                    ));
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}