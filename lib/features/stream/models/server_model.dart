class ServerModel {
  String id;
  String imageUrl;
  bool active;
  String target;
  String server_id;
  String storageUsedBytes;

  ServerModel({
    required this.id,
    required this.imageUrl,
    required this.target,
    required this.server_id,
    required this.storageUsedBytes,
    required this.active,
  });

  factory ServerModel.fromMap(String id, Map<String, dynamic> map) {
    return ServerModel(
      id: id,
      imageUrl: map['image_url'] ?? '',
      target: map['bucket'] ?? '',
      server_id: map['server_id'] ?? '',
      storageUsedBytes: map['storageUsedBytes'] ?? '',
      active: map['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_url': imageUrl,
      'server_id': server_id,
      'storageUsedBytes': storageUsedBytes,
      'Target': target,
      'active': active,
    };
  }
}
