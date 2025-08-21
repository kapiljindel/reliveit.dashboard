class BrandModel {
  final String id;
  final String brand;
  final String icon;
  final String banner;
  final List<String> categories;
  final bool featured;
  final String date;

  BrandModel({
    required this.id,
    required this.brand,
    required this.icon,
    required this.banner,
    required this.categories,
    required this.featured,
    required this.date,
  });

  factory BrandModel.fromMap(String id, Map<String, dynamic> map) {
    return BrandModel(
      id: id,
      brand: map['Brand'] ?? '',
      icon: map['icon'] ?? '',
      banner: map['banner'] ?? '',
      categories:
          (map['Categories'] ?? '')
              .toString()
              .split(',')
              .map((e) => e.trim())
              .toList(),
      featured: map['Featured'] ?? false,
      date: map['Date'] ?? '',
    );
  }
}
