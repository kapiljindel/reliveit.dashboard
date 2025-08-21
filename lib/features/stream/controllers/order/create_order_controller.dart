import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:dashboard/features/stream/models/order_model.dart'; // your VideoItem model

class CreateVideoItemController extends GetxController {
  // Rx variables for form inputs
  final videoId = ''.obs;
  final title = ''.obs;
  final releaseDate = ''.obs;
  final series = ''.obs;
  final videoUrl = ''.obs;
  final parent = ''.obs;
  final thumbnail = ''.obs;

  final isLoading = false.obs;

  // Validation method (optional)
  bool validate() {
    if (videoId.value.isEmpty ||
        title.value.isEmpty ||
        releaseDate.value.isEmpty ||
        series.value.isEmpty ||
        videoUrl.value.isEmpty ||
        parent.value.isEmpty) {
      return false;
    }
    return true;
  }

  // Method to create new VideoItem in Firestore
  Future<void> createVideoItem() async {
    if (!validate()) {
      throw Exception('Please fill all required fields');
    }

    isLoading.value = true;

    try {
      final newItem = VideoItem(
        videoId: videoId.value,
        title: title.value,
        releaseDate: releaseDate.value,
        series: series.value,
        videoUrl: videoUrl.value,
        parent: parent.value,
        thumbnail: thumbnail.value,
      );

      final detailsRef = FirebaseFirestore.instance
          .collection('Posts')
          .doc(newItem.parent)
          .collection('details');

      await Future.wait([
        detailsRef.doc('titles').set({
          newItem.videoId: newItem.title,
        }, SetOptions(merge: true)),
        detailsRef.doc('releaseDate').set({
          newItem.videoId: newItem.releaseDate,
        }, SetOptions(merge: true)),
        detailsRef.doc('series').set({
          newItem.videoId: newItem.series,
        }, SetOptions(merge: true)),
        detailsRef.doc('videoUrl').set({
          newItem.videoId: newItem.videoUrl,
        }, SetOptions(merge: true)),
      ]);

      // Optionally update banner in parent document
      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(newItem.parent)
          .set({'Banner': newItem.thumbnail}, SetOptions(merge: true));

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      rethrow; // Let the UI handle the error display
    }
  }
}
