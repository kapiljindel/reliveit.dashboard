class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String image;
  final String role;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.image,
    required this.role,
  });

  factory UserModel.fromMap(String uid, String role, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      role: role,
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      image: map['imageUrl'] ?? '',
    );
  }
}
