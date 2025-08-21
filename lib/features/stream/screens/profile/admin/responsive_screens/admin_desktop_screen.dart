import 'package:dashboard/features/stream/screens/profile/admin/controllers/profile_controllers.dart';
import 'package:dashboard/features/stream/screens/profile/admin/models/admin_model.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/features/stream/screens/profile/admin/widgets/profile_details_form.dart';
import 'package:dashboard/features/stream/screens/profile/admin/widgets/profile_image_card.dart';

class AdminDesktopScreen extends StatefulWidget {
  final String uid;
  const AdminDesktopScreen({super.key, required this.uid});

  @override
  State<AdminDesktopScreen> createState() => _AdminDesktopScreenState();
}

class _AdminDesktopScreenState extends State<AdminDesktopScreen> {
  final AdminController adminController = AdminController();

  AdminModel? admin;
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
    _loadAdmin();
  }

  Future<void> _loadAdmin() async {
    setState(() => loading = true);
    final fetchedAdmin = await adminController.fetchAdmin(widget.uid);

    if (fetchedAdmin != null) {
      admin = fetchedAdmin;
      nameController.text = admin!.displayName;
      emailController.text = admin!.email;
      uidController.text = admin!.uid;
      passwordController.text = admin!.password;
    }
    setState(() => loading = false);
  }

  Future<void> _saveAdmin() async {
    if (admin == null) return;

    final updatedAdmin = admin!.copyWith(
      displayName: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );

    await adminController.saveAdmin(updatedAdmin);
    admin = updatedAdmin;

    setState(() => isEditing = false);
    _loadAdmin();
  }

  void _showEditImageDialog() {
    final imageUrlController = TextEditingController(
      text: admin?.imageUrl ?? '',
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Profile Image URL'),
            content: TextField(
              controller: imageUrlController,
              decoration: const InputDecoration(hintText: 'Enter Image URL'),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  final newUrl = imageUrlController.text;
                  if (admin != null) {
                    await adminController.updateAdminImageUrl(
                      admin!.uid,
                      newUrl,
                    );
                    setState(() {
                      admin = admin!.copyWith(imageUrl: newUrl);
                    });
                  }
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
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
                        AdminProfileImage(
                          imageUrl:
                              admin?.imageUrl ??
                              "https://img.icons8.com/color/96/flutter.png",
                          isEditing: isEditing,
                          onEditImage: _showEditImageDialog,
                          displayName: nameController.text,
                          email: emailController.text,
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            children: [
                              AdminProfileForm(
                                nameController: nameController,
                                emailController: emailController,
                                uidController: uidController,
                                passwordController: passwordController,
                                isEditing: isEditing,
                                isPasswordVisible: isPasswordVisible,
                                onTogglePasswordVisibility: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                permissions: admin?.permissions,
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (isEditing) {
                                      _saveAdmin();
                                    } else {
                                      isEditing = true;
                                    }
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
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}
