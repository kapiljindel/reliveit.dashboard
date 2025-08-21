import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/product/product_controller.dart';
import 'package:dashboard/features/stream/models/product_model.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';

class SeriesRow extends DataTableSource {
  final List<ProductModel> seriesList;

  SeriesRow(this.seriesList);

  @override
  DataRow? getRow(int index) {
    if (index >= seriesList.length) return null;
    final series = seriesList[index];

    return DataRow2(
      cells: [
        // Thumbnail + Title
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 55,
                padding: TSizes.sm,
                image:
                    series.thumbnail.isNotEmpty
                        ? series.thumbnail
                        : TImages.defaultImage,
                imageType:
                    series.thumbnail.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  series.title,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),

        // Year
        DataCell(
          Text(
            series.year,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        DataCell(
          Row(
            children: [
              series.studioIcon.isNotEmpty
                  ? Image.network(
                    series.studioIcon,
                    width: 40,
                    height: 40,
                    errorBuilder: (ctx, err, stack) => const Icon(Icons.error),
                  )
                  : const Icon(Icons.image),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  series.studio,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        // Featured
        DataCell(
          IconButton(
            icon: Icon(
              series.featured ? Iconsax.heart5 : Iconsax.heart,
              color: series.featured ? TColors.primary : Colors.grey,
            ),
            onPressed: () {
              Get.find<SeriesController>().toggleFeatured(
                series.id,
                series.featured,
              );
            },
          ),
        ),

        // Date
        DataCell(
          Text(
            series.releaseDate,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Actions
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => Get.toNamed(TRoutes.editProduct, arguments: series),
            onDeletePressed:
                () => Get.find<SeriesController>().deleteSeries(series.id),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => seriesList.length;

  @override
  int get selectedRowCount => 0;
}
