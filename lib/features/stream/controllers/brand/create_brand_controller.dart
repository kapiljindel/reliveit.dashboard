import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/features/stream/models/brand_model.dart';

class CreateBrandController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Form controllers
  final brandName = TextEditingController();
  final imageUrl = TextEditingController(); // Icon URL
  final bannerUrl = TextEditingController(); // Banner URL

  // Reactive selections
  final RxSet<String> selectedCategories = <String>{}.obs;
  final RxBool isFeatured = false.obs;

  // Reactive list for categories fetched from Firestore
  final RxList<String> allCategories = <String>[].obs;

  // Form key
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch categories dynamically from Firestore collection
  Future<void> fetchCategories() async {
    try {
      final snapshot =
          await firestore
              .collection('config')
              .doc('categories')
              .collection('details')
              .get();

      final categories =
          snapshot.docs
              .map((doc) => doc.data()['title']?.toString() ?? '')
              .where((title) => title.isNotEmpty)
              .toList();

      allCategories.assignAll(categories);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories');
    }
  }

  // Submit method
  Future<void> createBrand() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final brand = BrandModel(
        id: '', // Firestore will assign one
        brand: brandName.text.trim(),
        icon: imageUrl.text.trim(),
        banner: bannerUrl.text.trim(),
        categories: selectedCategories.toList(),
        featured: isFeatured.value,
        date: DateTime.now().toIso8601String(),
      );

      await firestore
          .collection('config')
          .doc('studios')
          .collection('details')
          .add({
            'Brand': brand.brand,
            'icon': brand.icon,
            'banner': brand.banner,
            'Categories': brand.categories.join(','),
            'Featured': brand.featured,
            'Date': brand.date,
          });

      Get.snackbar('Success', 'Brand created successfully');
      clearForm();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create brand');
    }
  }

  void clearForm() {
    brandName.clear();
    imageUrl.clear();
    bannerUrl.clear();
    selectedCategories.clear();
    isFeatured.value = false;
  }
}
