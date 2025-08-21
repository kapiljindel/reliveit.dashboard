import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/models/category_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditCategoryController extends GetxController {
  final Rx<CategoryModel> category = Rx<CategoryModel>(
    CategoryModel(
      id: '',
      name: '',
      parentCategory: '',
      featured: false,
      date: '',
      imageUrl: '',
    ),
  );

  final nameController = TextEditingController();
  final parentCategoryController = TextEditingController();
  final imageUrlController = TextEditingController();
  final RxBool isFeatured = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Fetch category data
  void loadCategoryData(String categoryId) async {
    try {
      final doc =
          await firestore
              .collection('config')
              .doc('categories')
              .collection('details')
              .doc(categoryId)
              .get();

      if (doc.exists) {
        final categoryData = CategoryModel.fromMap(doc.id, doc.data()!);

        category.value = categoryData;
        nameController.text = categoryData.name;
        parentCategoryController.text = categoryData.parentCategory ?? '';
        imageUrlController.text = categoryData.imageUrl;
        isFeatured.value = categoryData.featured;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load category');
    }
  }

  // Update category data
  Future<void> updateCategory() async {
    if (!formKey.currentState!.validate()) return;

    final updatedCategory = CategoryModel(
      id: category.value.id,
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
          .doc(updatedCategory.id)
          .update(updatedCategory.toJson());

      Get.snackbar('Success', 'Category updated successfully');
      clearForm();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update category');
    }
  }

  // Clear form after submission
  void clearForm() {
    nameController.clear();
    parentCategoryController.clear();
    imageUrlController.clear();
    isFeatured.value = false;
  }
}
