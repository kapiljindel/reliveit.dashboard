class ProductModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String visibility;
  final String? password;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.visibility,
    this.password,
  });

  factory ProductModel.fromMap(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      thumbnail: data['Banner'] ?? '',
      visibility: data['visibility'] ?? 'public',
      password: data['Password'],
    );
  }
}
