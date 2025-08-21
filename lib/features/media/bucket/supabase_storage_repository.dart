import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageRepository {
  final SupabaseClient client;

  SupabaseStorageRepository(this.client);

  /// Upload file to a specific bucket & folder
  Future<String?> uploadFile({
    required String bucket,
    required String folder,
    required File file,
  }) async {
    try {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
      final path = '$folder/$fileName';

      final response = await client.storage.from(bucket).upload(path, file);

      if (response.isNotEmpty) {
        // Get public URL
        final publicUrl = client.storage.from(bucket).getPublicUrl(path);
        return publicUrl;
      }
      return null;
    } catch (e) {
      print("Upload error: $e");
      return null;
    }
  }

  /// Get all files from a folder in a bucket
  Future<List<String>> getFiles({
    required String bucket,
    required String folder,
  }) async {
    try {
      final response = await client.storage.from(bucket).list(path: folder);
      return response
          .map(
            (item) => client.storage
                .from(bucket)
                .getPublicUrl('$folder/${item.name}'),
          )
          .toList();
    } catch (e) {
      print("Get files error: $e");
      return [];
    }
  }

  /// Delete a file from a bucket
  Future<bool> deleteFile({
    required String bucket,
    required String filePath,
  }) async {
    try {
      final response = await client.storage.from(bucket).remove([filePath]);
      return response.isEmpty; // empty list means success
    } catch (e) {
      print("Delete error: $e");
      return false;
    }
  }

  /// List all buckets
  Future<List<String>> getBuckets() async {
    try {
      final response = await client.storage.listBuckets();
      return response.map((bucket) => bucket.name).toList();
    } catch (e) {
      print("Get buckets error: $e");
      return [];
    }
  }
}
