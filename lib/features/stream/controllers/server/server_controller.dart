// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../models/server_model.dart';

class ServerController extends GetxController {
  final servers = <ServerModel>[].obs;

  final _firestore = FirebaseFirestore.instance;
  final _configDoc = FirebaseFirestore.instance
      .collection('Servers')
      .doc('servers_details');

  @override
  void onInit() {
    fetchServers();
    super.onInit();
  }

  Future<void> fetchServers() async {
    final doc = await _configDoc.get();
    final data = doc.data() ?? {};
    servers.clear();

    data.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        servers.add(ServerModel.fromMap(key, value));
      }
    });
  }

  Future<void> toggleServerActiveStatus(String id, bool newStatus) async {
    await _configDoc.update({'$id.active': newStatus});
    final index = servers.indexWhere((b) => b.id == id);
    if (index != -1) {
      servers[index] = ServerModel(
        id: servers[index].id,
        imageUrl: servers[index].imageUrl,
        target: servers[index].target,
        server_id: servers[index].server_id,
        storageUsedBytes: servers[index].storageUsedBytes,
        active: newStatus,
      );
      servers.refresh();
    }
  }

  /*
  // Call this once to fetch servers from Firestore
  Future<void> fetchServers() async {
    final doc = await _firestore.collection('config').doc('server').get();
    if (doc.exists) {
      final data = doc.data() ?? {};
      final List<ServerModel> loadedServers = [];
      data.forEach((key, value) {
        loadedServers.add(
          ServerModel.fromMap(key, Map<String, dynamic>.from(value)),
        );
      });
      servers.assignAll(loadedServers);
    }
  }
*/
  // Update a server inside the map field of 'config/server'
  Future<void> updateServer(ServerModel updatedServer) async {
    try {
      await _firestore.collection('Servers').doc('servers_details').update({
        updatedServer.id: updatedServer.toJson(),
      });

      // Update local list and refresh UI
      final index = servers.indexWhere((b) => b.id == updatedServer.id);
      if (index != -1) {
        servers[index] = updatedServer;
        servers.refresh();
      }

      Get.snackbar('Success', 'Server updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update server: $e');
    }
  }

  Future<void> deleteServerById(String id) async {
    await _configDoc.update({id: FieldValue.delete()});
    servers.removeWhere((b) => b.id == id);
  }
}
