import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class AdminDesktopScreen extends StatefulWidget {
  final String uid;
  const AdminDesktopScreen({super.key, required this.uid});

  @override
  State<AdminDesktopScreen> createState() => _AdminDesktopScreenState();
}

class _AdminDesktopScreenState extends State<AdminDesktopScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> adminData = {};
  bool loading = true;
  bool isEditing = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final uidController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    fetchAdminData();
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
        nameController.text = admin['displayName'] ?? '';
        emailController.text = admin['email'] ?? '';
        uidController.text = widget.uid;
        passwordController.text = admin['password'] ?? '';
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
      'displayName': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'imageUrl': adminData['imageUrl'],
    };

    await firestore.collection('users').doc('Admin').update({
      widget.uid: {...adminData, ...updatedData},
    });

    setState(() => isEditing = false);
    fetchAdminData();
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
                    const TBreadcrumbsWithHeading(
                      heading: 'Banners',
                      breadcrumbItems: ['Profile'],
                    ),
                    const SizedBox(height: TSizes.spaceBtwSections),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image Card
                        Container(
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
                                  if (isEditing) _showEditImageDialog();
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundColor:
                                          Colors.deepPurple.shade100,
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
                              const SizedBox(height: 10),
                              Text(
                                nameController.text,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                emailController.text,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),

                        // Profile Details Form
                        Expanded(
                          child: Container(
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
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                // Name + UID
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

                                // Email + Permissions or Password
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
                                                  border:
                                                      const OutlineInputBorder(),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(
                                                      isPasswordVisible
                                                          ? Icons.visibility
                                                          : Icons
                                                              .visibility_off,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        isPasswordVisible =
                                                            !isPasswordVisible;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                              : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Permissions",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  if (adminData['permissions'] !=
                                                      null)
                                                    Wrap(
                                                      spacing: 8,
                                                      runSpacing: 6,
                                                      children:
                                                          (adminData['permissions']
                                                                  as Map<
                                                                    String,
                                                                    dynamic
                                                                  >)
                                                              .entries
                                                              .map((entry) {
                                                                final name =
                                                                    entry.key
                                                                        .replaceAll(
                                                                          '_',
                                                                          ' ',
                                                                        )
                                                                        .toUpperCase();
                                                                final value =
                                                                    entry.value
                                                                        .toString()
                                                                        .toLowerCase();
                                                                final granted =
                                                                    value ==
                                                                    'true';

                                                                return SizedBox(
                                                                  height: 30,
                                                                  child: ElevatedButton(
                                                                    onPressed:
                                                                        null,
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor:
                                                                          granted
                                                                              ? Colors.green
                                                                              : Colors.red,
                                                                      padding: const EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            12,
                                                                        vertical:
                                                                            4,
                                                                      ),
                                                                      textStyle: const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              8,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                      name,
                                                                    ),
                                                                  ),
                                                                );
                                                              })
                                                              .toList(),
                                                    )
                                                  else
                                                    const Text(
                                                      'No permissions found',
                                                    ),
                                                ],
                                              ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),

                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEditing) {
                                        saveAdminData();
                                      } else {
                                        isEditing = true;
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      50,
                                    ),
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}
