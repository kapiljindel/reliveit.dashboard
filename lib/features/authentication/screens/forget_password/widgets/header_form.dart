import 'package:get/get.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/constants/text_strings.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter/material.dart';

class HeaderAndForm extends StatelessWidget {
  const HeaderAndForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Iconsax.arrow_left),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          TTexts.forgetPasswordTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          TTexts.forgetPasswordSubTitle,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 2),

        /// Form
        Form(
          child: TextFormField(
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct_right),
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        /// Submit Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                () => Get.toNamed(
                  TRoutes.resetPassword,
                  parameters: {'email': 'gamer@kapil.com'},
                ),
            child: const Text(TTexts.submit),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 2),
      ],
    );
  }
}
