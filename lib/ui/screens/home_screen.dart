import 'package:flutter/material.dart';
import 'package:mesh_app/services/network_service.dart';
import 'package:mesh_app/models/peer_device.dart';
import 'pairing_screen.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NetworkService _networkService = NetworkService();
  final List<PeerDevice> _peers = [];

  @override
  void initState() {
    super.initState();
    _initNetwork();
  }

  Future<void> _initNetwork() async {
    await _networkService.initialize();
    _networkService.peersStream.listen((peers) {
      setState(() => _peers = peers);
    });
    await _networkService.discoverPeers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesh Network'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initNetwork,
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Available Devices', style: TextStyle(fontSize: 18)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _peers.length,
              itemBuilder: (context, index) {
                final peer = _peers[index];
                return ListTile(
                  leading: const Icon(Icons.devices),
                  title: Text(peer.name),
                  subtitle: Text(peer.ipAddress),
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/chat',
                    arguments: peer,
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/pair'),
            child: const Text('Pair with QR Code'),
          ),
        ],
      ),
    );
  }
}