import 'package:flutter/material.dart';

class ProfileImageCard extends StatelessWidget {
  final Map<String, dynamic> adminData;
  final bool isEditing;
  final VoidCallback onEditImage;

  const ProfileImageCard({
    super.key,
    required this.adminData,
    required this.isEditing,
    required this.onEditImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
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
              onTap: isEditing ? onEditImage : null,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.deepPurple.shade100,
                    backgroundImage: NetworkImage(
                      adminData['imageUrl'] ??
                          "https://img.icons8.com/color/96/flutter.png",
                    ),
                  ),
                  if (isEditing)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.edit_rounded,
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
              adminData['displayName'] ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              adminData['email'] ?? '',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
