class HeaderUserModel {
  final String displayName;
  final String imageUrl;
  final String email;

  HeaderUserModel({
    required this.displayName,
    required this.imageUrl,
    required this.email,
  });

  factory HeaderUserModel.fromMap(Map<String, dynamic> map) {
    return HeaderUserModel(
      displayName: map['displayName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
