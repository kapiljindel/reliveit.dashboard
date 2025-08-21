// TODO Implement this library.
import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderThumbnailImage extends StatefulWidget {
  const OrderThumbnailImage({super.key});

  @override
  State<OrderThumbnailImage> createState() => _OrderThumbnailImageState();
}

class _OrderThumbnailImageState extends State<OrderThumbnailImage> {
  final TextEditingController _thumbnailController = TextEditingController();
  String _previewUrl = '';

  @override
  void dispose() {
    _thumbnailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text('Thumbnail', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Image preview and URL input
          TRoundedContainer(
            height: 300,
            backgroundColor: TColors.primaryBackground,
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 🔹 Live Image Preview
                  Expanded(
                    child:
                        _previewUrl.isNotEmpty
                            ? TRoundedImage(
                              width: 220,
                              height: 220,
                              image: _previewUrl,
                              imageType: ImageType.network,
                            )
                            : const TRoundedImage(
                              width: 220,
                              height: 220,
                              image: TImages.defaultSingleImageIcon,
                              imageType: ImageType.asset,
                            ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  // 🔹 Image URL Input Field
                  TextFormField(
                    controller: _thumbnailController,
                    onChanged: (value) {
                      setState(() {
                        _previewUrl = value.trim();
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Thumbnail Image URL',
                      hintText: 'Paste image URL here...',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
