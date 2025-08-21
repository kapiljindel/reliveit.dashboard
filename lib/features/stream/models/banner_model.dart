class BannerModel {
  String id;
  String imageUrl;
  bool active;
  String target;

  BannerModel({
    required this.id,
    required this.imageUrl,
    required this.target,
    required this.active,
  });

  factory BannerModel.fromMap(String id, Map<String, dynamic> map) {
    return BannerModel(
      id: id,
      imageUrl: map['image_url'] ?? '',
      target: map['Target'] ?? '',
      active: map['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'image_url': imageUrl, 'Target': target, 'active': active};
  }
}
