class AdminModel {
  final String uid;
  final String displayName;
  final String email;
  final String password;
  final String imageUrl;
  final Map<String, dynamic>? permissions;

  AdminModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.password,
    required this.imageUrl,
    this.permissions,
  });

  factory AdminModel.fromMap(String uid, Map<String, dynamic> map) {
    return AdminModel(
      uid: uid,
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      permissions: map['permissions'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'password': password,
      'imageUrl': imageUrl,
      'permissions': permissions,
    };
  }

  AdminModel copyWith({
    String? displayName,
    String? email,
    String? password,
    String? imageUrl,
    Map<String, dynamic>? permissions,
  }) {
    return AdminModel(
      uid: uid,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
      permissions: permissions ?? this.permissions,
    );
  }
}
