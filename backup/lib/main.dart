import 'package:flutter/material.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/chat_screen.dart';
import 'ui/screens/pairing_screen.dart';
import 'models/peer_device.dart';

void main() {
  runApp(const MeshApp());
}

class MeshApp extends StatelessWidget {
  const MeshApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mesh Network',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/chat': (context) => ChatScreen(
              peer: ModalRoute.of(context)!.settings.arguments as PeerDevice,
            ),
        '/pair': (context) => const PairingScreen(),
      },
    );
  }
}