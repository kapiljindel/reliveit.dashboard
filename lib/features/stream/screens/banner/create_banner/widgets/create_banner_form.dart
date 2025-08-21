import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBannerForm extends StatefulWidget {
  const CreateBannerForm({super.key});

  @override
  State<CreateBannerForm> createState() => _CreateBannerFormState();
}

class _CreateBannerFormState extends State<CreateBannerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _targetController = TextEditingController();
  bool _isActive = true;

  bool _isLoading = false;

  Future<void> _createBanner() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final doc = FirebaseFirestore.instance.collection('config').doc('banner');
    final snapshot = await doc.get();

    Map<String, dynamic> currentData = {};
    if (snapshot.exists) {
      currentData = snapshot.data() ?? {};
    }

    // Generate new key like banner_3
    final bannerKeys =
        currentData.keys
            .where((key) => key.startsWith('banner_'))
            .map((key) => int.tryParse(key.split('_').last) ?? 0)
            .toList();

    int nextIndex =
        bannerKeys.isNotEmpty
            ? (bannerKeys.reduce((a, b) => a > b ? a : b) + 1)
            : 1;
    final newKey = 'banner_$nextIndex';

    final newBannerData = {
      'image_url': _imageUrlController.text.trim(),
      'Target': _targetController.text.trim(),
      'active': _isActive,
    };

    // Add to Firestore
    await doc.set({newKey: newBannerData}, SetOptions(merge: true));

    setState(() => _isLoading = false);

    Get.back(); // Go back to banners list
    Get.snackbar('Success', 'Banner created successfully');
  }

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),
            Text(
              'Create New Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Image preview
            TRoundedImage(
              width: 400,
              height: 200,
              backgroundColor: TColors.primaryBackground,
              image:
                  _imageUrlController.text.isNotEmpty
                      ? _imageUrlController.text
                      : TImages.defaultImage,
              imageType:
                  _imageUrlController.text.isNotEmpty
                      ? ImageType.network
                      : ImageType.asset,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // TextField for image URL
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(labelText: 'Image URL'),
              validator:
                  (value) =>
                      (value == null || value.isEmpty)
                          ? 'Enter image URL'
                          : null,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Active checkbox
            Text('Make your Banner Active or Inactive'),
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Active'),
              value: _isActive,
              onChanged: (value) => setState(() => _isActive = value!),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Text field for target screen
            TextFormField(
              controller: _targetController,
              decoration: const InputDecoration(labelText: 'Target Screen'),
              validator:
                  (value) =>
                      (value == null || value.isEmpty)
                          ? 'Enter screen name or URL'
                          : null,
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _createBanner,
                child:
                    _isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Create'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
