// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditOrderController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final videoIdController = TextEditingController();
  final thumbnailUrlController = TextEditingController();
  final seriesNumberController = TextEditingController();

  final RxList<String> selectedCategories = <String>[].obs;
  final RxString parentId = ''.obs;
  final RxBool isLoading = true.obs;

  // Call this to load data for editing
  Future<void> loadOrder({
    required String parentDocId,
    required String videoId,
  }) async {
    try {
      isLoading.value = true;
      parentId.value = parentDocId;
      videoIdController.text = videoId;

      final parentRef = FirebaseFirestore.instance
          .collection('Posts')
          .doc(parentDocId);
      final detailsRef = parentRef.collection('details');
      final parentSnap = await parentRef.get();

      final titles = (await detailsRef.doc('titles').get()).data();
      final releaseDate = (await detailsRef.doc('releaseDate').get()).data();
      final series = (await detailsRef.doc('series').get()).data();
      final videoUrl = (await detailsRef.doc('videoUrl').get()).data();

      titleController.text = titles?[videoId] ?? '';
      descriptionController.text = releaseDate?[videoId] ?? '';
      seriesNumberController.text = series?[videoId] ?? '';
      thumbnailUrlController.text = parentSnap.data()?['Banner'] ?? '';
    } catch (e) {
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveChanges() async {
    final parent = parentId.value;
    final videoId = videoIdController.text.trim();

    if (parent.isEmpty || videoId.isEmpty) {
      Get.snackbar('Validation Error', 'Missing Parent or Video ID');
      return;
    }

    try {
      isLoading.value = true;

      final parentRef = FirebaseFirestore.instance
          .collection('Posts')
          .doc(parent);
      final detailsRef = parentRef.collection('details');
      final batch = FirebaseFirestore.instance.batch();

      batch.set(detailsRef.doc('titles'), {
        videoId: titleController.text.trim(),
      }, SetOptions(merge: true));
      batch.set(detailsRef.doc('releaseDate'), {
        videoId: descriptionController.text.trim(),
      }, SetOptions(merge: true));
      batch.set(detailsRef.doc('series'), {
        videoId: seriesNumberController.text.trim(),
      }, SetOptions(merge: true));
      batch.set(
        detailsRef.doc('videoUrl'),
        {videoId: 'https://your-video-url.com'}, // Replace if dynamic
        SetOptions(merge: true),
      );

      batch.update(parentRef, {'Banner': thumbnailUrlController.text.trim()});

      await batch.commit();

      Get.snackbar('Success', 'Order updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    videoIdController.dispose();
    thumbnailUrlController.dispose();
    seriesNumberController.dispose();
    super.onClose();
  }
}
