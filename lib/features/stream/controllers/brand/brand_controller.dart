import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/models/brand_model.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  final RxList<BrandModel> brands = <BrandModel>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
  }

  void fetchBrands() {
    firestore
        .collection('config')
        .doc('studios')
        .collection('details')
        .snapshots()
        .listen((snapshot) {
          final List<BrandModel> loadedBrands = [];
          for (var doc in snapshot.docs) {
            loadedBrands.add(BrandModel.fromMap(doc.id, doc.data()));
          }
          brands.assignAll(loadedBrands);
        });
  }

  void toggleFeatured(String id, bool currentValue) async {
    try {
      await firestore
          .collection('config')
          .doc('studios')
          .collection('details')
          .doc(id)
          .update({'Featured': !currentValue});
      Get.snackbar('Success', 'Featured status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update featured status');
    }
  }

  void deleteBrand(String id) async {
    try {
      await firestore
          .collection('config')
          .doc('studios')
          .collection('details')
          .doc(id)
          .delete();
      Get.snackbar('Success', 'Brand deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete brand');
    }
  }
}
