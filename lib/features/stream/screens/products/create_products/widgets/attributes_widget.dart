import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: TColors.primaryBackground),
        const SizedBox(height: TSizes.spaceBtwSections),

        // 🔹 Title
        Text(
          'Add Product Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // 🔹 Form to add new attribute
        Form(
          child:
              TDeviceUtils.isDesktopScreen(context)
                  ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: buildAttributeName()),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      Expanded(flex: 2, child: buildAttributeTextField()),
                      const SizedBox(width: TSizes.spaceBtwItems),
                      buildAddAttributeButton(),
                    ],
                  )
                  : Column(
                    children: [
                      buildAttributeName(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      buildAttributeTextField(),
                      const SizedBox(height: TSizes.spaceBtwItems),
                      buildAddAttributeButton(),
                    ],
                  ),
        ),

        const SizedBox(height: TSizes.spaceBtwSections),

        // 🔹 List of added attributes
        Text(
          'All Attributes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        TRoundedContainer(
          backgroundColor: TColors.primaryBackground,
          child: Column(
            children: [
              buildAttributesList(context),
              const SizedBox(height: TSizes.spaceBtwItems),
              buildEmptyAttributes(),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwSections),

        // 🔹 Generate Variations Button
        Center(
          child: SizedBox(
            width: 200,
            child: ElevatedButton.icon(
              icon: const Icon(Iconsax.activity, color: Colors.white),
              label: const Text('Generate Variations'),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Mock UI parts (replace with real implementations later)
  Widget buildAttributeName() {
    return const TextField(
      decoration: InputDecoration(labelText: "Attribute Name"),
    );
  }

  Widget buildAttributeTextField() {
    return const TextField(
      decoration: InputDecoration(
        labelText: "Attribute Values (comma separated)",
      ),
    );
  }

  Widget buildAddAttributeButton() {
    return ElevatedButton(onPressed: () {}, child: const Text("Add"));
  }

  Widget buildEmptyAttributes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            TRoundedImage(
              width: 150,
              height: 80,
              imageType: ImageType.asset,
              image: TImages.defaultAttributeColorsImageIcon,
            ),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        const Text("There are no attributes added for this product"),
      ],
    );
  }

  Widget buildAttributesList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // mock count
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Attribute $index"),
          subtitle: const Text("Example values"),
        );
      },
    );
  }
}
