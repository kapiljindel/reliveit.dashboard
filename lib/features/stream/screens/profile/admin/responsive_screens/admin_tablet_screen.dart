import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/features/stream/screens/profile/admin copy/controllers/profile_controllers.dart';
import 'package:flutter/material.dart';

class AdminTabletScreen extends StatefulWidget {
  final String uid;
  const AdminTabletScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<AdminTabletScreen> createState() => _AdminTabletScreenState();
}

class _AdminTabletScreenState extends State<AdminTabletScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ProfileControllers controllers = ProfileControllers();

  Map<String, dynamic> adminData = {};
  bool loading = true;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    fetchAdminData();
  }

  @override
  void dispose() {
    controllers.dispose();
    super.dispose();
  }

  Future<void> fetchAdminData() async {
    try {
      final doc = await firestore.collection('users').doc('Admin').get();
      if (!doc.exists) {
        setState(() => loading = false);
        return;
      }

      final data = doc.data() ?? {};
      final admin = data[widget.uid] ?? {};

      if (admin.isEmpty) {
        setState(() => loading = false);
        return;
      }

      setState(() {
        adminData = admin;
        loading = false;
        controllers.nameController.text = admin['displayName'] ?? '';
        controllers.emailController.text = admin['email'] ?? '';
        controllers.uidController.text = widget.uid;
        controllers.passwordController.text = admin['password'] ?? '';
      });
    } catch (e) {
      setState(() => loading = false);
      print("Error fetching admin data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load admin data. Please try again.'),
        ),
      );
    }
  }

  Future<void> saveAdminData() async {
    final updatedData = {
      'displayName': controllers.nameController.text,
      'email': controllers.emailController.text,
      'password': controllers.passwordController.text,
      'imageUrl': adminData['imageUrl'],
    };

    await firestore.collection('users').doc('Admin').update({
      widget.uid: {...adminData, ...updatedData},
    });

    setState(() => isEditing = false);
    fetchAdminData();
  }

  void togglePasswordVisibility() {
    setState(() {
      controllers.isPasswordVisible = !controllers.isPasswordVisible;
    });
  }

  void _showEditImageDialog() {
    final imageUrlController = TextEditingController(
      text: adminData['imageUrl'],
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile Image URL'),
          content: TextField(
            controller: imageUrlController,
            decoration: const InputDecoration(hintText: 'Enter Image URL'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final newUrl = imageUrlController.text;
                await firestore.collection('users').doc('Admin').update({
                  widget.uid: {...adminData, 'imageUrl': newUrl},
                });
                setState(() {
                  adminData['imageUrl'] = newUrl;
                });
                Navigator.of(context).pop();
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
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Dashboard / Profile",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Banners",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Expanded Profile Image Card for Tablet (takes 75-80% width and centered)
                    Center(
                      child: Container(
                        width:
                            screenWidth *
                            0.75, // Adjust this value to widen/narrow
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Profile Image with edit icon if editing
                            GestureDetector(
                              onTap: () {
                                if (isEditing) _showEditImageDialog();
                              },
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
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.3,
                                              ),
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

                            const SizedBox(width: 32),

                            // Name & Email Text vertically aligned center
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controllers.nameController.text,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    controllers.emailController.text,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Profile Form (Desktop style)
                    ProfileDetailsForm(
                      adminData: adminData,
                      isEditing: isEditing,
                      isPasswordVisible: controllers.isPasswordVisible,
                      nameController: controllers.nameController,
                      emailController: controllers.emailController,
                      uidController: controllers.uidController,
                      passwordController: controllers.passwordController,
                      onTogglePasswordVisibility: togglePasswordVisibility,
                      onSave: () async {
                        await saveAdminData();
                      },
                    ),

                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () async {
                        if (isEditing) {
                          await saveAdminData();
                        }
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        backgroundColor: const Color(0xFF3C6FF0),
                      ),
                      child: Text(
                        isEditing ? "Save Profile" : "Edit Profile",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

class ProfileDetailsForm extends StatelessWidget {
  final Map<String, dynamic> adminData;
  final bool isEditing;
  final bool isPasswordVisible;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController uidController;
  final TextEditingController passwordController;
  final VoidCallback onTogglePasswordVisibility;
  final VoidCallback onSave;

  const ProfileDetailsForm({
    Key? key,
    required this.adminData,
    required this.isEditing,
    required this.isPasswordVisible,
    required this.nameController,
    required this.emailController,
    required this.uidController,
    required this.passwordController,
    required this.onTogglePasswordVisibility,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
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
          const SizedBox(height: 20),

          TextFormField(
            controller: uidController,
            decoration: const InputDecoration(
              labelText: "UID",
              border: OutlineInputBorder(),
            ),
            readOnly: true,
          ),
          const SizedBox(height: 20),

          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
            ),
            readOnly: !isEditing,
          ),
          const SizedBox(height: 20),

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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                                final value =
                                    entry.value.toString().toLowerCase();
                                final granted = value == 'true';
                                return SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          granted ? Colors.green : Colors.red,
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
                              })
                              .toList(),
                    )
                  else
                    const Text('No permissions found'),
                ],
              ),
        ],
      ),
    );
  }
}
