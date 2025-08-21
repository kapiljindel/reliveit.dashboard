// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../models/banner_model.dart';

class BannerController extends GetxController {
  final banners = <BannerModel>[].obs;

  final _firestore = FirebaseFirestore.instance;
  final _configDoc = FirebaseFirestore.instance
      .collection('config')
      .doc('banner');

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    final doc = await _configDoc.get();
    final data = doc.data() ?? {};
    banners.clear();

    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        banners.add(BannerModel.fromMap(key, value));
      }
    });
  }

  Future<void> toggleBannerActiveStatus(String id, bool newStatus) async {
    await _configDoc.update({'$id.active': newStatus});
    final index = banners.indexWhere((b) => b.id == id);
    if (index != -1) {
      banners[index] = BannerModel(
        id: banners[index].id,
        imageUrl: banners[index].imageUrl,
        target: banners[index].target,
        active: newStatus,
      );
      banners.refresh();
    }
  }

  /*
  // Call this once to fetch banners from Firestore
  Future<void> fetchBanners() async {
    final doc = await _firestore.collection('config').doc('banner').get();
    if (doc.exists) {
      final data = doc.data() ?? {};
      final List<BannerModel> loadedBanners = [];
      data.forEach((key, value) {
        loadedBanners.add(
          BannerModel.fromMap(key, Map<String, dynamic>.from(value)),
        );
      });
      banners.assignAll(loadedBanners);
    }
  }
*/
  // Update a banner inside the map field of 'config/banner'
  Future<void> updateBanner(BannerModel updatedBanner) async {
    try {
      await _firestore.collection('config').doc('banner').update({
        updatedBanner.id: updatedBanner.toJson(),
      });

      // Update local list and refresh UI
      final index = banners.indexWhere((b) => b.id == updatedBanner.id);
      if (index != -1) {
        banners[index] = updatedBanner;
        banners.refresh();
      }

      Get.snackbar('Success', 'Banner updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update banner: $e');
    }
  }

  Future<void> deleteBannerById(String id) async {
    await _configDoc.update({id: FieldValue.delete()});
    banners.removeWhere((b) => b.id == id);
  }
}
