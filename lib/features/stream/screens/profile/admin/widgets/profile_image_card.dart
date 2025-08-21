import 'package:flutter/material.dart';

class AdminProfileImage extends StatelessWidget {
  final String imageUrl;
  final bool isEditing;
  final VoidCallback onEditImage;
  final String displayName;
  final String email;

  const AdminProfileImage({
    super.key,
    required this.imageUrl,
    required this.isEditing,
    required this.onEditImage,
    required this.displayName,
    required this.email,
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
              if (isEditing) onEditImage();
            },
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.deepPurple.shade100,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                if (isEditing)
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
            displayName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(email, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
