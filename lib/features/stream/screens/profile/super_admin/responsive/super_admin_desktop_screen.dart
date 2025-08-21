import 'package:dashboard/features/stream/screens/profile/super_admin/controller/super_admin_controller.dart';
import 'package:dashboard/features/stream/screens/profile/super_admin/widgets/admin_list.dart';
import 'package:dashboard/features/stream/screens/profile/super_admin/widgets/profile_details_form.dart';
import 'package:dashboard/features/stream/screens/profile/super_admin/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class SuperAdminDesktopScreen extends StatefulWidget {
  final String uid;
  const SuperAdminDesktopScreen({super.key, required this.uid});

  @override
  State<SuperAdminDesktopScreen> createState() =>
      _SuperAdminDesktopScreenState();
}

class _SuperAdminDesktopScreenState extends State<SuperAdminDesktopScreen> {
  final controller = SuperAdminController();

  @override
  void initState() {
    super.initState();
    controller.fetchSuperAdminData(widget.uid, () => setState(() {}));
    controller.fetchAdmins(() => setState(() {}));
  }

  void _showEditImageDialog() {
    controller.imageUrlController.text = controller.adminData['imageUrl'] ?? '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile Image URL'),
          content: TextField(
            controller: controller.imageUrlController,
            decoration: const InputDecoration(hintText: 'Enter Image URL'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  controller.adminData['imageUrl'] =
                      controller.imageUrlController.text;
                });
                controller.saveSuperAdminData(
                  widget.uid,
                  () => setState(() {}),
                );
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Super Admin - Profile'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:
          controller.loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(
                          controller: controller,
                          onImageTap: _showEditImageDialog,
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: ProfileDetailsForm(
                            controller: controller,
                            onSave: () {
                              if (controller.isEditing) {
                                controller.saveSuperAdminData(
                                  widget.uid,
                                  () => setState(() {}),
                                );
                              } else {
                                setState(() {
                                  controller.isEditing = true;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    AdminList(
                      admins: controller.admins,
                      onDelete:
                          (uid) => controller.deleteAdmin(
                            uid,
                            () => setState(() {}),
                          ),
                      onTogglePermission:
                          (uid, key, value) => controller.togglePermission(
                            uid,
                            key,
                            value,
                            () => setState(() {}),
                          ),
                    ),
                  ],
                ),
              ),
    );
  }
}
