import 'package:flutter/material.dart';
import '../controller/super_admin_controller.dart';

class ProfileDetailsForm extends StatelessWidget {
  final SuperAdminController controller;
  final VoidCallback onSave;

  const ProfileDetailsForm({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Profile Details",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.nameController,
                  readOnly: !controller.isEditing,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  controller: controller.uidController,
                  readOnly: true,
                  decoration: const InputDecoration(labelText: 'UID'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.emailController,
                  readOnly: !controller.isEditing,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible,
                  readOnly: !controller.isEditing,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        controller.isPasswordVisible =
                            !controller.isPasswordVisible;
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Text(
              controller.isEditing ? 'Save' : 'Edit Profile',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
