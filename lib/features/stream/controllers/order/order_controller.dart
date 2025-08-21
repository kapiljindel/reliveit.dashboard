import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/models/order_model.dart';
import 'package:get/get.dart';

class VideoItemController extends GetxController {
  final RxList<VideoItem> videoItems = <VideoItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllVideoItems();
  }

  Future<void> deleteVideoItem(VideoItem item) async {
    try {
      final batch = FirebaseFirestore.instance.batch();
      final basePath = FirebaseFirestore.instance
          .collection('Posts')
          .doc(item.parent)
          .collection('details');

      final keysToDelete = ['titles', 'releaseDate', 'series', 'videoUrl'];

      for (var docName in keysToDelete) {
        final docRef = basePath.doc(docName);
        batch.update(docRef, {item.videoId: FieldValue.delete()});
      }

      await batch.commit();

      // Remove from local list
      videoItems.removeWhere(
        (v) => v.videoId == item.videoId && v.parent == item.parent,
      );

      print("Deleted successfully");
    } catch (e) {
      print("Error deleting video item: $e");
    }
  }

  Future<void> fetchAllVideoItems() async {
    try {
      final postsSnapshot =
          await FirebaseFirestore.instance.collection('Posts').get();

      List<VideoItem> allItems = [];

      for (var postDoc in postsSnapshot.docs) {
        final postId = postDoc.id;
        final bannerUrl = postDoc.data()['Banner'] ?? ''; // ✅ Get Banner

        final detailsRef = FirebaseFirestore.instance
            .collection('Posts')
            .doc(postId)
            .collection('details');

        final titlesDoc = await detailsRef.doc('titles').get();
        final releaseDateDoc = await detailsRef.doc('releaseDate').get();
        final seriesDoc = await detailsRef.doc('series').get();
        final videoUrlDoc = await detailsRef.doc('videoUrl').get();

        final titlesData = titlesDoc.data() ?? {};
        final releaseDateData = releaseDateDoc.data() ?? {};
        final seriesData = seriesDoc.data() ?? {};
        final videoUrlData = videoUrlDoc.data() ?? {};

        for (var key in titlesData.keys) {
          allItems.add(
            VideoItem(
              videoId: key,
              title: titlesData[key] ?? '',
              releaseDate: releaseDateData[key] ?? '',
              series: seriesData[key] ?? '',
              parent: postId,
              videoUrl: videoUrlData[key] ?? '',
              thumbnail: bannerUrl, // ✅ Use Banner
            ),
          );
        }
      }

      videoItems.assignAll(allItems);
    } catch (e) {
      print('Error fetching video items: $e');
    }
  }
}
