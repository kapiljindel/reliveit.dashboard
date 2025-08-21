import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/features/stream/models/brand_model.dart';
import 'package:flutter/material.dart';

class CreateProductController extends GetxController {
  // 🔹 Main Product Fields
  var title = ''.obs;
  var description = ''.obs;
  var thumbnailUrl = ''.obs;
  var visibility = ProductVisibility.public.obs;
  var password = ''.obs;

  // 🔹 Brand Fields
  final brandTextController = TextEditingController();
  final selectedBrand = Rxn<BrandModel>();
  final RxList<BrandModel> brands = <BrandModel>[].obs;

  // 🔹 Sub-Product Form Fields
  final imageController = TextEditingController();
  final titleController = TextEditingController();
  final videoIdController = TextEditingController();
  final seriesController = TextEditingController();
  final releaseDateController = TextEditingController();

  // 🔹 Dynamic Sub-Products List
  final RxList<Map<String, String>> subProducts = <Map<String, String>>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  /// 🔸 Fetch Studios / Brands from Firestore
  Future<void> fetchBrands() async {
    try {
      final snapshot =
          await firestore
              .collection('config')
              .doc('studios')
              .collection('details')
              .get();

      final fetchedBrands =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return BrandModel(
              id: doc.id,
              brand: data['Brand'] ?? '',
              icon: data['icon'] ?? '',
              banner: '',
              categories: [],
              date: '',
              featured: false,
            );
          }).toList();

      brands.assignAll(fetchedBrands);
    } catch (e) {
      print('❌ Error fetching brands: $e');
    }
  }

  /// 🔸 Add Sub-Product (Variation)
  void addSubProduct() {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Sub-product title is required');
      return;
    }

    final newSubProduct = {
      'image': imageController.text.trim(),
      'title': titleController.text.trim(),
      'videoId': videoIdController.text.trim(),
      'series': seriesController.text.trim(),
      'releaseDate': releaseDateController.text.trim(),
    };

    subProducts.add(newSubProduct);
    clearSubProductForm();
  }

  /// 🔸 Remove Variation
  void removeSubProduct(int index) {
    if (index >= 0 && index < subProducts.length) {
      subProducts.removeAt(index);
    }
  }

  /// 🔸 Clear Variation Form
  void clearSubProductForm() {
    imageController.clear();
    titleController.clear();
    videoIdController.clear();
    seriesController.clear();
    releaseDateController.clear();
  }

  /// 🔸 Clear All Variations
  void clearSubProducts() {
    subProducts.clear();
  }

  /// 🔸 Save Product + Variations to Firestore
  Future<void> saveProductWithDetails() async {
    final trimmedTitle = title.value.trim();

    if (trimmedTitle.isEmpty) {
      Get.snackbar('Error', 'Main product title is required');
      return;
    }

    if (visibility.value == ProductVisibility.unlisted &&
        password.value.trim().isEmpty) {
      Get.snackbar('Error', 'Password required for unlisted visibility');
      return;
    }

    final docRef = firestore.collection('Posts').doc(trimmedTitle);

    // Main Product Data
    final mainData = {
      'title': trimmedTitle,
      'description': description.value,
      'Banner': thumbnailUrl.value,
      'visibility': visibility.value.name,
      'Password':
          visibility.value == ProductVisibility.unlisted
              ? password.value.trim()
              : null,
      'Studio': selectedBrand.value?.brand ?? '',
      'StudioIcon': selectedBrand.value?.icon ?? '',
      'featured': false,
      'Show': "true",
      'category': "",
    };

    try {
      // 🔹 Save Main Document
      await docRef.set(mainData);

      // 🔹 Prepare Details Subcollection
      Map<String, Map<String, String>> detailsData = {
        'releaseDate': {},
        'series': {},
        'thumbnail': {},
        'titles': {},
        'videoUrl': {},
      };

      for (int i = 0; i < subProducts.length; i++) {
        final key = 'video${i + 1}';
        detailsData['releaseDate']![key] = subProducts[i]['releaseDate'] ?? '';
        detailsData['series']![key] = subProducts[i]['series'] ?? '';
        detailsData['thumbnail']![key] = subProducts[i]['image'] ?? '';
        detailsData['titles']![key] = subProducts[i]['title'] ?? '';
        detailsData['videoUrl']![key] = subProducts[i]['videoId'] ?? '';
      }

      final detailsCollection = docRef.collection('details');

      // 🔹 Save Each Detail Document
      for (var entry in detailsData.entries) {
        await detailsCollection.doc(entry.key).set(entry.value);
      }

      Get.snackbar('Success', 'Product and all variations saved');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save product: $e');
    }
  }

  /// 🔸 Save Series Only
  Future<void> saveSeries() async {
    final trimmedTitle = title.value.trim();
    if (trimmedTitle.isEmpty) {
      Get.snackbar('Error', 'Title cannot be empty');
      return;
    }

    if (visibility.value == ProductVisibility.unlisted &&
        password.value.trim().isEmpty) {
      Get.snackbar('Error', 'Password required for unlisted product');
      return;
    }

    final data = {
      'title': trimmedTitle,
      'description': description.value,
      'Banner': thumbnailUrl.value,
      'visibility': visibility.value.name,
      'Password':
          visibility.value == ProductVisibility.unlisted
              ? password.value.trim()
              : null,
      'Studio': selectedBrand.value?.brand ?? '',
      'StudioIcon': selectedBrand.value?.icon ?? '',
      'Year': '',
      'releaseDate': '',
      'featured': false,
    };

    try {
      await firestore.collection('Posts').doc(trimmedTitle).set(data);
      Get.snackbar('Success', 'Series saved successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save series: $e');
    }
  }

  /// 🔸 Reset Entire Form
  void resetForm() {
    title.value = '';
    description.value = '';
    thumbnailUrl.value = '';
    visibility.value = ProductVisibility.public;
    password.value = '';

    brandTextController.clear();
    selectedBrand.value = null;

    clearSubProductForm();
    subProducts.clear();
  }

  @override
  void onClose() {
    brandTextController.dispose();
    imageController.dispose();
    titleController.dispose();
    videoIdController.dispose();
    seriesController.dispose();
    releaseDateController.dispose();
    super.onClose();
  }
}
