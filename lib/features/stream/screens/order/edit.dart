import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Video Item Model
class VideoItem {
  final String videoId;
  final String title;
  final String releaseDate;
  final String videoUrl;
  final String series;
  final String parent;
  final String thumbnail;

  VideoItem({
    required this.videoId,
    required this.title,
    required this.releaseDate,
    required this.videoUrl,
    required this.series,
    required this.parent,
    required this.thumbnail,
  });
}

/// Controller to handle Create and Edit
class VideoItemController extends GetxController {
  var videoId = ''.obs;
  var title = ''.obs;
  var releaseDate = ''.obs;
  var videoUrl = ''.obs;
  var series = ''.obs;
  var parent = ''.obs;
  var thumbnail = ''.obs;
  var isLoading = false.obs;

  bool validate() {
    return videoId.value.isNotEmpty &&
        title.value.isNotEmpty &&
        releaseDate.value.isNotEmpty &&
        videoUrl.value.isNotEmpty &&
        series.value.isNotEmpty &&
        parent.value.isNotEmpty;
  }

  Future<void> createVideoItem() async {
    if (!validate()) throw Exception('Please fill all fields');
    isLoading.value = true;

    try {
      final ref = FirebaseFirestore.instance
          .collection('Posts')
          .doc(parent.value)
          .collection('details');

      await Future.wait([
        ref.doc('titles').set({
          videoId.value: title.value,
        }, SetOptions(merge: true)),
        ref.doc('releaseDate').set({
          videoId.value: releaseDate.value,
        }, SetOptions(merge: true)),
        ref.doc('series').set({
          videoId.value: series.value,
        }, SetOptions(merge: true)),
        ref.doc('videoUrl').set({
          videoId.value: videoUrl.value,
        }, SetOptions(merge: true)),
      ]);

      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(parent.value)
          .set({'Banner': thumbnail.value}, SetOptions(merge: true));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadVideoItem(String parentId, String videoId) async {
    isLoading.value = true;
    try {
      final ref = FirebaseFirestore.instance
          .collection('Posts')
          .doc(parentId)
          .collection('details');

      this.videoId.value = videoId;
      this.parent.value = parentId;

      final titleDoc = await ref.doc('titles').get();
      final dateDoc = await ref.doc('releaseDate').get();
      final seriesDoc = await ref.doc('series').get();
      final urlDoc = await ref.doc('videoUrl').get();
      final bannerDoc =
          await FirebaseFirestore.instance
              .collection('Posts')
              .doc(parentId)
              .get();

      title.value = titleDoc[videoId] ?? '';
      releaseDate.value = dateDoc[videoId] ?? '';
      series.value = seriesDoc[videoId] ?? '';
      videoUrl.value = urlDoc[videoId] ?? '';
      thumbnail.value = bannerDoc['Banner'] ?? '';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateVideoItem() async {
    if (!validate()) throw Exception('Please fill all fields');
    isLoading.value = true;

    try {
      final ref = FirebaseFirestore.instance
          .collection('Posts')
          .doc(parent.value)
          .collection('details');

      await Future.wait([
        ref.doc('titles').update({videoId.value: title.value}),
        ref.doc('releaseDate').update({videoId.value: releaseDate.value}),
        ref.doc('series').update({videoId.value: series.value}),
        ref.doc('videoUrl').update({videoId.value: videoUrl.value}),
      ]);

      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(parent.value)
          .set({'Banner': thumbnail.value}, SetOptions(merge: true));
    } finally {
      isLoading.value = false;
    }
  }
}

/// Page for Create or Edit
class VideoItemPage extends StatefulWidget {
  final bool isEdit;
  final String? parentId;
  final String? videoId;

  const VideoItemPage({
    super.key,
    this.isEdit = false,
    this.parentId,
    this.videoId,
  });

  @override
  State<VideoItemPage> createState() => _VideoItemPageState();
}

class _VideoItemPageState extends State<VideoItemPage> {
  final controller = Get.put(VideoItemController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.parentId != null && widget.videoId != null) {
      controller.loadVideoItem(widget.parentId!, widget.videoId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'Edit Video Item' : 'Create Video Item'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: controller.title.value,
                  decoration: const InputDecoration(labelText: 'Title'),
                  onChanged: (val) => controller.title.value = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  initialValue: controller.releaseDate.value,
                  decoration: const InputDecoration(labelText: 'Release Date'),
                  onChanged: (val) => controller.releaseDate.value = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  initialValue: controller.videoId.value,
                  decoration: const InputDecoration(labelText: 'Video ID'),
                  onChanged: (val) => controller.videoId.value = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                  readOnly: widget.isEdit,
                ),
                TextFormField(
                  initialValue: controller.videoUrl.value,
                  decoration: const InputDecoration(labelText: 'Video URL'),
                  onChanged: (val) => controller.videoUrl.value = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  initialValue: controller.series.value,
                  decoration: const InputDecoration(labelText: 'Series'),
                  onChanged: (val) => controller.series.value = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  initialValue: controller.parent.value,
                  decoration: const InputDecoration(labelText: 'Parent ID'),
                  onChanged: (val) => controller.parent.value = val,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                  readOnly: widget.isEdit,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: controller.thumbnail.value,
                  decoration: const InputDecoration(labelText: 'Thumbnail URL'),
                  onChanged: (val) => controller.thumbnail.value = val,
                ),
                const SizedBox(height: 24),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          if (widget.isEdit) {
                            await controller.updateVideoItem();
                            Get.snackbar('Success', 'Video item updated');
                          } else {
                            await controller.createVideoItem();
                            Get.snackbar('Success', 'Video item created');
                          }
                          Get.back();
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      }
                    },
                    child: Text(widget.isEdit ? 'Update' : 'Create'),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
