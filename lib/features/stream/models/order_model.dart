class VideoItem {
  final String videoId;
  final String title;
  final String releaseDate;
  final String videoUrl;
  final String series;
  final String parent;
  final String thumbnail; // ← for Banner

  VideoItem({
    required this.videoId,
    required this.title,
    required this.releaseDate,
    required this.videoUrl,
    required this.series,
    required this.parent,
    required this.thumbnail,
  });

  factory VideoItem.fromMap(
    Map<String, dynamic> map,
    String parentDocId,
    String bannerUrl,
  ) {
    return VideoItem(
      videoId: map['videoId'] ?? '',
      title: map['title'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      series: map['series'] ?? '',
      parent: parentDocId, // ← we know it from path
      thumbnail: bannerUrl, // ← passed in from parent doc
    );
  }
}
