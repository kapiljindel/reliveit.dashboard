import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/controllers/product/model.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  final title = ''.obs;
  final description = ''.obs;
  final thumbnailUrl = ''.obs;
  final visibility = ProductVisibility.public.obs;
  final password = ''.obs;
  final docId = ''.obs;

  /// Load product data into the form
  void loadProduct(ProductModel product) {
    docId.value = product.id;
    title.value = product.title;
    description.value = product.description;
    thumbnailUrl.value = product.thumbnail;

    // Convert string visibility to enum
    visibility.value = ProductVisibility.values.firstWhere(
      (v) => v.name == product.visibility,
      orElse: () => ProductVisibility.public,
    );

    password.value =
        visibility.value == ProductVisibility.unlisted
            ? product.password ?? ''
            : '';
  }

  Future<void> updateSeries() async {
    if (docId.isEmpty) return;

    try {
      final data = {
        "title": title.value,
        "description": description.value,
        "Banner": thumbnailUrl.value,
        "visibility": visibility.value.name,
      };

      if (visibility.value == ProductVisibility.unlisted) {
        data["Password"] = password.value;
      }

      await FirebaseFirestore.instance
          .collection("Posts")
          .doc(docId.value)
          .update(data);

      Get.snackbar("Success", "Product updated successfully.");
    } catch (e) {
      Get.snackbar("Error", "Failed to update: $e");
    }
  }
}
