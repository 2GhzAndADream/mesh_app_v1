import 'package:wifi_direct/wifi_direct.dart';
import '../models/peer_device.dart';

class NetworkService {
  final WifiDirect _wifi = WifiDirect();
  final List<PeerDevice> _peers = [];
  bool _isDiscovering = false;

  Future<void> initialize() async {
    await _wifi.initialize();
    _wifi.peersStream.listen((devices) {
      _peers.clear();
      _peers.addAll(devices.map((d) => PeerDevice(
        id: d.deviceAddress,
        name: d.deviceName,
        ipAddress: d.deviceAddress,
      )));
    });
  }

  Future<void> discoverPeers() async {
    if (_isDiscovering) return;
    _isDiscovering = true;
    await _wifi.discoverPeers();
    _isDiscovering = false;
  }

  Future<bool> connect(PeerDevice peer) async {
    try {
      return await _wifi.connect(peer.ipAddress);
    } catch (e) {
      return false;
    }
  }

  Stream<List<PeerDevice>> get peersStream => _wifi.peersStream.map((devices) => 
    devices.map((d) => PeerDevice(
      id: d.deviceAddress,
      name: d.deviceName,
      ipAddress: d.deviceAddress,
    )).toList()
  );
}