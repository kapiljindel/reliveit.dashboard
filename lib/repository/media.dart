import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/media/models/image_model.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage storage = FirebaseStorage.instance;

  /// Upload image file to Firebase Storage
  Future<ImageModel> uploadImageFileInStorage({
    required File file,
    required String path,
    required String imageName,
  }) async {
    try {
      // Reference to the storage location
      final Reference ref = storage.ref('$path/$imageName');

      // Upload file
      await ref.putFile(file);

      // Get download URL
      final String downloadURL = await ref.getDownloadURL();

      // Get metadata
      final FullMetadata metadata = await ref.getMetadata();

      // Return ImageModel
      return ImageModel.fromFirebaseMetadata(
        metadata,
        path,
        imageName,
        downloadURL,
      );
    } on FirebaseException catch (e) {
      throw e.message ?? "Firebase exception occurred";
    } on SocketException {
      throw "No internet connection";
    } on PlatformException catch (e) {
      throw e.message ?? "Platform exception occurred";
    } catch (e) {
      throw e.toString();
    }
  }

  /// Upload Image data in Firestore
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      final data = await FirebaseFirestore.instance
          .collection("Images")
          .add(image.toJson());
      return data.id;
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Fetch images from Firestore based on media category and load count
  Future<List<ImageModel>> fetchImagesFromDatabase(
    MediaCategory mediaCategory,
    int loadCount,
  ) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('Images')
              .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
              .orderBy('createdAt', descending: true)
              .limit(loadCount)
              .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Load more images from Firestore based on media category, load count, and last fetched date
  Future<List<ImageModel>> loadMoreImagesFromDatabase(
    MediaCategory mediaCategory,
    int loadCount,
    DateTime lastFetchedDate,
  ) async {
    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('Images')
              .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
              .orderBy('createdAt', descending: true)
              .startAfter([lastFetchedDate])
              .limit(loadCount)
              .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}
