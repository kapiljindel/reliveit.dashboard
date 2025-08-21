import 'package:flutter/material.dart';

class AdminList extends StatelessWidget {
  final List<Map<String, dynamic>> admins;
  final Function(String uid) onDelete;
  final Function(String uid, String key, bool value) onTogglePermission;

  const AdminList({
    super.key,
    required this.admins,
    required this.onDelete,
    required this.onTogglePermission,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Admin Users",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed:
                  () => Navigator.pushNamed(context, '/super/createAdmin'),
              icon: const Icon(Icons.add, color: Colors.blue),
              label: const Text(
                'Create Admin',
                style: TextStyle(color: Colors.blue),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...admins.map((admin) {
          final permissions = Map<String, bool>.from(admin['permissions']);

          Widget permissionChip(String label, bool enabled) {
            return GestureDetector(
              onTap: () => onTogglePermission(admin['uid'], label, enabled),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: enabled ? Colors.deepPurple[100] : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (enabled)
                      const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.deepPurple,
                      ),
                    if (enabled) const SizedBox(width: 4),
                    Text(label.replaceAll('_', ' ')),
                  ],
                ),
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    admin['image']?.isNotEmpty == true
                        ? admin['image']
                        : 'https://img.icons8.com/color/96/flutter.png',
                  ),
                  radius: 24,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        admin['name'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        admin['email'],
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text('UID: ${admin['uid']}'),
                const SizedBox(width: 12),
                Row(
                  children:
                      permissions.entries
                          .map(
                            (entry) => permissionChip(entry.key, entry.value),
                          )
                          .toList(),
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // TODO: Navigate to edit admin screen or show modal
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => onDelete(admin['uid']),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
