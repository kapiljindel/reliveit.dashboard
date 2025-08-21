import 'package:flutter/material.dart';

class AdminProfileForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController uidController;
  final TextEditingController passwordController;
  final bool isEditing;
  final bool isPasswordVisible;
  final VoidCallback onTogglePasswordVisibility;
  final Map<String, dynamic>? permissions;

  final dynamic toggleEdit;

  final dynamic onSave;

  const AdminProfileForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.uidController,
    required this.passwordController,
    required this.isEditing,
    required this.isPasswordVisible,
    required this.onTogglePasswordVisibility,
    this.permissions,
    this.onSave,
    this.toggleEdit,
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
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: !isEditing,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  controller: uidController,
                  decoration: const InputDecoration(
                    labelText: "UID",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  readOnly: !isEditing,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child:
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
                        : _PermissionsDisplay(permissions: permissions),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PermissionsDisplay extends StatelessWidget {
  final Map<String, dynamic>? permissions;

  const _PermissionsDisplay({required this.permissions});

  @override
  Widget build(BuildContext context) {
    if (permissions == null || permissions!.isEmpty) {
      return const Text('No permissions found');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Permissions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children:
              permissions!.entries.map((entry) {
                final name = entry.key.replaceAll('_', ' ').toUpperCase();
                final granted = entry.value.toString().toLowerCase() == 'true';

                return SizedBox(
                  height: 30,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: granted ? Colors.green : Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(name),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
