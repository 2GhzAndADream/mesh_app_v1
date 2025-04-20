class PeerDevice {
  final String id;
  final String name;
  final String ipAddress;
  final bool isConnected;

  const PeerDevice({
    required this.id,
    required this.name,
    required this.ipAddress,
    this.isConnected = false,
  });

  factory PeerDevice.fromJson(Map<String, dynamic> json) {
    return PeerDevice(
      id: json['id'],
      name: json['name'],
      ipAddress: json['ipAddress'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'ipAddress': ipAddress,
  };
}