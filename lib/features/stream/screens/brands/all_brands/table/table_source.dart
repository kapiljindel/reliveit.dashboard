import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/brand/brand_controller.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/utils/device/device_utility.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class BrandRows extends DataTableSource {
  final BrandController controller = Get.find<BrandController>();

  @override
  DataRow? getRow(int index) {
    if (index >= controller.brands.length) return null;

    final brand = controller.brands[index];

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              brand.icon.isNotEmpty
                  ? TRoundedImage(
                    width: 50,
                    height: 50,
                    padding: TSizes.sm,
                    image: brand.icon,
                    imageType: ImageType.network,
                    borderRadius: TSizes.borderRadiusMd,
                    backgroundColor: TColors.primaryBackground,
                  )
                  : Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  brand.brand,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: TSizes.xs,
                direction:
                    TDeviceUtils.isMobileScreen(Get.context!)
                        ? Axis.vertical
                        : Axis.horizontal,
                children:
                    brand.categories
                        .map(
                          (cat) => Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  TDeviceUtils.isMobileScreen(Get.context!)
                                      ? 0
                                      : TSizes.xs,
                            ),
                            child: Chip(
                              label: Text(cat),
                              padding: const EdgeInsets.all(TSizes.xs),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
          ),
        ),
        DataCell(
          InkWell(
            onTap: () => controller.toggleFeatured(brand.id, brand.featured),
            child: Icon(
              brand.featured ? Iconsax.heart5 : Iconsax.heart,
              color: TColors.primary,
            ),
          ),
        ),

        DataCell(Text(brand.date)),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => Get.toNamed(TRoutes.editBrand, arguments: brand),

            onDeletePressed: () => controller.deleteBrand(brand.id),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.brands.length;

  @override
  int get selectedRowCount => 0;
}
