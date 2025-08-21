import 'dart:typed_data';
import 'package:flutter_dropzone/flutter_dropzone.dart';
//import 'package:universal_html/html.dart' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../utils/formatters/formatter.dart';

class ImageModel {
  String id;
  final String url;
  final String folder;
  final int? sizeBytes;
  String mediaCategory;
  final String filename;
  final String? fullPath;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? contentType;

  // Not Mapped
  final DropzoneFileInterface? file;
  final Uint8List? localImageToDisplay;
  RxBool isSelected = false.obs;

  /// Constructor
  ImageModel({
    this.id = '',
    required this.url,
    required this.folder,
    required this.filename,
    this.sizeBytes,
    this.fullPath,
    this.createdAt,
    this.updatedAt,
    this.contentType,
    this.file,
    this.localImageToDisplay,
    this.mediaCategory = '',
  });

  /// Empty model
  static ImageModel empty() => ImageModel(url: '', folder: '', filename: '');

  /// Getters
  String get createdAtFormatted => TFormatter.formatDate(createdAt);
  String get updatedAtFormatted => TFormatter.formatDate(updatedAt);

  /// To JSON
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'folder': folder,
      'sizeBytes': sizeBytes,
      'filename': filename,
      'fullPath': fullPath,
      'createdAt': createdAt?.toUtc(),
      'contentType': contentType,
      'mediaCategory': mediaCategory,
    };
  }

  /// From Firestore
  factory ImageModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    if (data != null) {
      return ImageModel(
        id: document.id,
        url: data['url'] ?? '',
        folder: data['folder'] ?? '',
        sizeBytes: data['sizeBytes'],
        filename: data['filename'] ?? '',
        fullPath: data['fullPath'],
        createdAt:
            data.containsKey('createdAt') ? data['createdAt']?.toDate() : null,
        updatedAt:
            data.containsKey('updatedAt') ? data['updatedAt']?.toDate() : null,
        contentType: data['contentType'],
        mediaCategory: data['mediaCategory'] ?? '',
      );
    } else {
      return ImageModel.empty();
    }
  }

  /// From Firebase Metadata
  factory ImageModel.fromFirebaseMetadata(
    FullMetadata metadata,
    String folder,
    String filename,
    String downloadUrl,
  ) {
    return ImageModel(
      url: downloadUrl,
      folder: folder,
      filename: filename,
      sizeBytes: metadata.size,
      updatedAt: metadata.updated,
      fullPath: metadata.fullPath,
      createdAt: metadata.timeCreated,
      contentType: metadata.contentType,
    );
  }
}
