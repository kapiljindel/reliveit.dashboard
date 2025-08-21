import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/server/server_controller.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/features/stream/models/server_model.dart';
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/utils/constants/sizes.dart';

class EditServerForm extends StatefulWidget {
  final ServerModel server;
  const EditServerForm({super.key, required this.server});

  @override
  State<EditServerForm> createState() => _EditServerFormState();
}

class _EditServerFormState extends State<EditServerForm> {
  late TextEditingController imageUrlController;
  late TextEditingController targetController;
  late TextEditingController server_idController;
  late TextEditingController storageUsedBytesController;
  bool isActive = false;
  final ServerController controller = Get.find();

  @override
  void initState() {
    super.initState();
    imageUrlController = TextEditingController(text: widget.server.imageUrl);
    storageUsedBytesController = TextEditingController(
      text: widget.server.storageUsedBytes,
    );
    server_idController = TextEditingController(text: widget.server.server_id);
    targetController = TextEditingController(text: widget.server.target);
    isActive = widget.server.active;
  }

  @override
  void dispose() {
    storageUsedBytesController.dispose();
    imageUrlController.dispose();
    server_idController.dispose();
    targetController.dispose();
    super.dispose();
  }

  void onUpdate() async {
    final updatedServer = ServerModel(
      id: widget.server.id,
      imageUrl: imageUrlController.text.trim(),
      target: targetController.text.trim(),
      storageUsedBytes: storageUsedBytesController.text.trim(),
      server_id: server_idController.text.trim(),
      active: isActive,
    );

    await controller.updateServer(updatedServer);
    Get.back(); // Return to servers list page
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
              'Update Server',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Image display only
            TRoundedImage(
              width: 400,
              height: 200,
              backgroundColor: TColors.primaryBackground,
              image: widget.server.imageUrl,
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

            // Target screen text field (replacing dropdown)
            TextFormField(
              controller: server_idController,
              decoration: const InputDecoration(
                labelText: 'Server Id',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            // Target screen text field (replacing dropdown)
            TextFormField(
              controller: storageUsedBytesController,
              decoration: const InputDecoration(
                labelText: 'aeon Key',
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
