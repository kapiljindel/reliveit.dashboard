import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:dashboard/features/stream/models/product_model.dart'; // or series_model.dart

class SeriesController extends GetxController {
  final RxList<ProductModel> seriesList = <ProductModel>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchSeries();
  }

  Future<String> fetchStudioIcon(String studioId) async {
    try {
      var doc =
          await firestore
              .collection('config')
              .doc('studios')
              .collection('details')
              .doc(studioId)
              .get();
      if (doc.exists) {
        return doc.data()?['icon'] ?? '';
      }
    } catch (e) {
      print('Error fetching studio icon: $e');
    }
    return '';
  }

  void fetchSeries() async {
    firestore.collection('Posts').snapshots().listen((snapshot) async {
      final List<ProductModel> loaded = [];
      for (var doc in snapshot.docs) {
        var data = doc.data();

        // studio id or name from series document
        String studioId = data['Studio'] ?? '';

        // fetch the studio icon from studios/details/{studioId}
        String icon = await fetchStudioIcon(studioId);

        // create series model with studio icon
        loaded.add(ProductModel.fromMap(doc.id, data, studioIcon: icon));
      }
      seriesList.assignAll(loaded);
    });
  }

  void toggleFeatured(String id, bool currentValue) async {
    try {
      await firestore.collection('Posts').doc(id).update({
        'featured': !currentValue,
      });
      Get.snackbar('Success', 'Featured status updated');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update featured');
    }
  }

  Future<void> deleteSeries(String id) async {
    try {
      await firestore.collection('Posts').doc(id).delete();
      Get.snackbar('Success', 'Series deleted');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete series');
    }
  }
}
