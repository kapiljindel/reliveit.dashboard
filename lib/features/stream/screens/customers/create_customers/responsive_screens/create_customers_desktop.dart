import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CreateCustomersDesktopScreen extends StatefulWidget {
  const CreateCustomersDesktopScreen({super.key});

  @override
  State<CreateCustomersDesktopScreen> createState() =>
      _CreateCustomersDesktopScreenState();
}

class _CreateCustomersDesktopScreenState
    extends State<CreateCustomersDesktopScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final uidController = TextEditingController();
  final imageUrlController = TextEditingController();

  bool isPremium = false;
  String profileImageUrl =
      'https://img.icons8.com/color/96/flutter.png'; // Default profile image
  bool isImageEditing = false;

  Future<void> createUser() async {
    final uid =
        DateTime.now().millisecondsSinceEpoch
            .toString(); // Generate a dummy UID
    final userData = {
      'displayName': nameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
      'isPremium': isPremium,
      'imageUrl': profileImageUrl,
      'createdAt': Timestamp.now(),
      'watchHistory': {},
    };

    await FirebaseFirestore.instance.collection('users').doc('Users').set({
      uid: userData,
    }, SetOptions(merge: true));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('User created successfully')));
    Navigator.pop(context);
  }

  void _showEditImageDialog() {
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
              onPressed: () {
                setState(() {
                  profileImageUrl = imageUrlController.text; // Update image URL
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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Create New User'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Row (Profile Image and Profile Details)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image - Left Column
                  Container(
                    width: 250,
                    height: 270,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap:
                              _showEditImageDialog, // Allow editing image URL
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(profileImageUrl),
                              ),
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
                          'Full Name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Profile Details - Right Column (Same Height as Image Column)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Profile Details",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    labelText: "Full Name",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  controller: uidController,
                                  decoration: const InputDecoration(
                                    labelText: "UID",
                                  ),
                                  readOnly: true, // Keep UID field read-only
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: "Subscription",
                                  ),
                                  controller: TextEditingController(
                                    text: isPremium ? "Premium" : "Free",
                                  ),
                                  readOnly: true, // Subscription is read-only
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Password Field

                          // Premium Switch

                          // Create User Button
                          ElevatedButton(
                            onPressed: createUser,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              backgroundColor: const Color(0xFF3C6FF0),
                            ),
                            child: const Text(
                              'Create User',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
