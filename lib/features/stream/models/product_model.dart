class ProductModel {
  final String id;
  final String title;
  final String studio; // studio name or id from Product data
  final String studioIcon; // NEW: icon url from studios collection
  final String year;
  final String releaseDate;
  final String thumbnail;
  final bool featured;

  ProductModel({
    required this.id,
    required this.title,
    required this.studio,
    required this.studioIcon,
    required this.year,
    required this.releaseDate,
    required this.thumbnail,
    required this.featured,
  });

  factory ProductModel.fromMap(
    String id,
    Map<String, dynamic> data, {
    String studioIcon = '',
  }) {
    return ProductModel(
      id: id,
      title: data['title'] ?? id,
      studio: data['Studio'] ?? '',
      studioIcon: studioIcon, // pass icon here
      year: data['Year'] ?? '',
      releaseDate: data['releaseDate'] ?? '',
      thumbnail: data['Banner'] ?? '',
      featured: data['featured'] ?? false,
    );
  }
}
