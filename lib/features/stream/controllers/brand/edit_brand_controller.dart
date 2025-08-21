// ignore_for_file: invalid_use_of_protected_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/models/brand_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBrandController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final brandName = TextEditingController();
  final imageUrl = TextEditingController(); // <-- needed for icon
  final bannerUrl = TextEditingController(); // <-- for banner image

  final RxList<String> allCategories = <String>[].obs;
  final RxSet<String> selectedCategories = <String>{}.obs;
  final RxBool isFeatured = false.obs;

  final formKey = GlobalKey<FormState>();

  Future<void> loadCategories() async {
    try {
      final snapshot =
          await firestore
              .collection('config')
              .doc('categories')
              .collection('details')
              .get();

      allCategories.value =
          snapshot.docs
              .map((doc) => doc.data()['title']?.toString() ?? '')
              .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    }
  }

  void loadBrandData(BrandModel brand) {
    brandName.text = brand.brand;
    imageUrl.text = brand.icon; // <-- important
    bannerUrl.text = brand.banner;
    selectedCategories.value = Set.from(brand.categories);
    isFeatured.value = brand.featured;
  }

  Future<void> updateBrand(BrandModel brand) async {
    if (!formKey.currentState!.validate()) return;

    try {
      await firestore
          .collection('config')
          .doc('studios')
          .collection('details')
          .doc(brand.id)
          .update({
            'Brand': brandName.text.trim(),
            'icon': imageUrl.text.trim(),
            'banner': bannerUrl.text.trim(),
            'Categories': selectedCategories.join(','),
            'Featured': isFeatured.value,
            'Date': DateTime.now().toIso8601String(),
          });

      Get.snackbar('Success', 'Brand updated successfully');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update brand');
    }
  }
}
