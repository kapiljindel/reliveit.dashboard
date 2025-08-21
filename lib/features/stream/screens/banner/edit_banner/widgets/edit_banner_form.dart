import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/features/stream/controllers/banner/bannercontroller.dart';
import 'package:dashboard/features/stream/models/banner_model.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/utils/constants/sizes.dart';

class EditBannerForm extends StatefulWidget {
  final BannerModel banner;
  const EditBannerForm({super.key, required this.banner});

  @override
  State<EditBannerForm> createState() => _EditBannerFormState();
}

class _EditBannerFormState extends State<EditBannerForm> {
  late TextEditingController imageUrlController;
  late TextEditingController targetController;
  bool isActive = false;
  final BannerController controller = Get.find();

  @override
  void initState() {
    super.initState();
    imageUrlController = TextEditingController(text: widget.banner.imageUrl);
    targetController = TextEditingController(text: widget.banner.target);
    isActive = widget.banner.active;
  }

  @override
  void dispose() {
    imageUrlController.dispose();
    targetController.dispose();
    super.dispose();
  }

  void onUpdate() async {
    final updatedBanner = BannerModel(
      id: widget.banner.id,
      imageUrl: imageUrlController.text.trim(),
      target: targetController.text.trim(),
      active: isActive,
    );

    await controller.updateBanner(updatedBanner);
    Get.back(); // Return to banners list page
  }

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: 500,
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.sm),
            Text(
              'Update Banner',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            // Image display only
            TRoundedImage(
              width: 400,
              height: 200,
              backgroundColor: TColors.primaryBackground,
              image: widget.banner.imageUrl,
              imageType: ImageType.network,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            // Image URL input instead of uploader (simpler for now)
            TextFormField(
              controller: imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Target screen text field (replacing dropdown)
            TextFormField(
              controller: targetController,
              decoration: const InputDecoration(
                labelText: 'Target URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Active checkbox
            Row(
              children: [
                Checkbox(
                  value: isActive,
                  onChanged: (bool? val) {
                    setState(() {
                      isActive = val ?? false;
                    });
                  },
                ),
                const Text('Active'),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onUpdate,
                child: const Text('Update'),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields * 2),
          ],
        ),
      ),
    );
  }
}
