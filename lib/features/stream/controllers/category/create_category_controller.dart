import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/models/category_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CreateCategoryController extends GetxController {
  // Form controllers
  final nameController = TextEditingController();
  final imageUrlController = TextEditingController();
  final parentCategoryController = TextEditingController();

  // Reactive variables for featured status
  final RxBool isFeatured = false.obs;

  // Categories list for dropdown
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  // Validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch categories for the parent category dropdown
  void fetchCategories() async {
    try {
      final snapshot =
          await firestore
              .collection('config')
              .doc('categories')
              .collection('details')
              .get();

      final loadedCategories =
          snapshot.docs
              .map((doc) => CategoryModel.fromMap(doc.id, doc.data()))
              .toList();

      allCategories.assignAll(loadedCategories); // Updating the categories list
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch categories');
    }
  }

  // Submit category data to Firestore
  Future<void> createCategory() async {
    if (!formKey.currentState!.validate()) return;

    final category = CategoryModel(
      id: '', // Firestore will generate an id
      name: nameController.text.trim(),
      parentCategory: parentCategoryController.text.trim(),
      featured: isFeatured.value,
      date: DateTime.now().toIso8601String(),
      imageUrl: imageUrlController.text.trim(),
    );

    try {
      await firestore
          .collection('config')
          .doc('categories')
          .collection('details')
          .add(category.toJson());
      Get.snackbar('Success', 'Category created successfully');
      clearForm();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create category');
    }
  }

  // Clear form fields after submission
  void clearForm() {
    nameController.clear();
    imageUrlController.clear();
    parentCategoryController.clear();
    isFeatured.value = false;
  }
}
