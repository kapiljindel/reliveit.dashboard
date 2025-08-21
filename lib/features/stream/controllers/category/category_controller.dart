import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  // Fetch categories data from Firestore
  void fetchCategories() {
    firestore
        .collection('config')
        .doc('categories')
        .collection('details')
        .snapshots()
        .listen((snapshot) {
          final List<CategoryModel> loadedCategories = [];
          for (var doc in snapshot.docs) {
            loadedCategories.add(CategoryModel.fromMap(doc.id, doc.data()));
          }
          categories.assignAll(loadedCategories);
        });
  }

  // Toggle featured status of the category
  void toggleFeatured(String id, bool currentValue) async {
    try {
      await firestore
          .collection('config')
          .doc('categories')
          .collection('details')
          .doc(id)
          .update({'featured': !currentValue});
      Get.snackbar('Success', 'Featured status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update featured status');
    }
  }

  // Delete category
  Future<void> deleteCategory(String id) async {
    try {
      await firestore
          .collection('config')
          .doc('categories')
          .collection('details')
          .doc(id)
          .delete();
      Get.snackbar('Success', 'Category deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete category');
    }
  }
}
