import 'package:flutter/material.dart';

class ProfileDetailsForm extends StatelessWidget {
  final bool isEditing;
  final bool isPasswordVisible;
  final Map<String, dynamic> adminData;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController uidController;
  final TextEditingController passwordController;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSave;

  const ProfileDetailsForm({
    super.key,
    required this.isEditing,
    required this.isPasswordVisible,
    required this.adminData,
    required this.nameController,
    required this.emailController,
    required this.uidController,
    required this.passwordController,
    required this.onTogglePasswordVisibility,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Full Name",
              border: OutlineInputBorder(),
            ),
            readOnly: !isEditing,
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: uidController,
            decoration: const InputDecoration(
              labelText: "UID",
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
          const SizedBox(height: 16),

          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
            readOnly: !isEditing,
          ),
          const SizedBox(height: 16),

          isEditing
              ? TextFormField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: onTogglePasswordVisibility,
                  ),
                ),
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Permissions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  if (adminData['permissions'] != null)
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children:
                          (adminData['permissions'] as Map<String, dynamic>)
                              .entries
                              .map((entry) {
                                final name =
                                    entry.key
                                        .replaceAll('_', ' ')
                                        .toUpperCase();
                                final granted =
                                    entry.value.toString().toLowerCase() ==
                                    'true';
                                return Chip(
                                  backgroundColor:
                                      granted ? Colors.green : Colors.red,
                                  label: Text(
                                    name,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                );
                              })
                              .toList(),
                    )
                  else
                    const Text('No permissions found'),
                ],
              ),
          const SizedBox(height: 30),

          ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: const Color(0xFF3C6FF0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              isEditing ? "Save Profile" : "Edit Profile",
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
