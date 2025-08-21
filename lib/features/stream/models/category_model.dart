class CategoryModel {
  final String id;
  final String name;
  final String? parentCategory;
  final bool featured;
  final String date;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    this.parentCategory,
    required this.featured,
    required this.date,
    required this.imageUrl,
  });

  factory CategoryModel.fromMap(String id, Map<String, dynamic> map) {
    return CategoryModel(
      id: id,
      name: map['name'] ?? '',
      parentCategory: map['parentCategory'],
      featured: map['featured'] ?? false,
      date: map['date'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'parentCategory': parentCategory,
      'featured': featured,
      'date': date,
      'imageUrl': imageUrl,
    };
  }
}
