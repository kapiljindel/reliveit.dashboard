import 'package:flutter/material.dart';
import '../controller/super_admin_controller.dart';

class ProfileHeader extends StatelessWidget {
  final SuperAdminController controller;
  final VoidCallback onImageTap;

  const ProfileHeader({
    super.key,
    required this.controller,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 270,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (controller.isEditing) onImageTap();
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    (controller.adminData['imageUrl'] ?? '').isNotEmpty
                        ? controller.adminData['imageUrl']
                        : 'https://img.icons8.com/color/96/flutter.png',
                  ),
                ),
                if (controller.isEditing)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                        size: 18,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            controller.nameController.text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            controller.emailController.text,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
