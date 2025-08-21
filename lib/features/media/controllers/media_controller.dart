import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:universal_html/html.dart' as html;

import 'package:dashboard/features/media/models/image_model.dart';
import 'package:dashboard/utils/constants/enums.dart';

/// Controller for managing media operations
class MediaController extends GetxController {
  static MediaController get instance => Get.find();

  late DropzoneViewController dropzoneController;

  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  /// Select and load images using Dropzone
  Future<void> selectLocalImages() async {
    final files = await dropzoneController.pickFiles(
      multiple: true,
      mime: ['image/jpeg', 'image/png'],
    );

    if (files.isNotEmpty) {
      for (var file in files) {
        if (file is html.File) {
          final bytes = await dropzoneController.getFileData(file);

          final image = ImageModel(
            url: '',
            folder: '',
            filename: file.name,
            file: file,
            localImageToDisplay: Uint8List.fromList(bytes),
          );

          selectedImagesToUpload.add(image);
        }
      }
    }
  }
}
