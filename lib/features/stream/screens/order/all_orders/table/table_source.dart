import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/order/order_controller.dart';
import 'package:dashboard/features/stream/models/order_model.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderRows extends DataTableSource {
  final List<VideoItem> items;
  final VideoItemController controller;

  OrderRows(this.items, this.controller);

  @override
  DataRow getRow(int index) {
    final item = items[index];

    return DataRow2(
      cells: [
        /// ✅ Video ID (just plain text now)
        DataCell(
          Text(
            item.videoId,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.primary),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        /// ✅ Title
        DataCell(
          Text(
            item.title,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.black),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        /// ✅ Release Date
        DataCell(
          Text(
            item.releaseDate,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.black),
          ),
        ),

        /// ✅ Video URL
        DataCell(
          InkWell(
            onTap: () {
              // TODO: Open in browser
            },
            child: Text(
              item.videoUrl,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ),

        /// ✅ Series
        DataCell(
          Text(
            item.series,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.darkerGrey),
          ),
        ),

        /// ✅ Parent (with image here)
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 40,
                height: 45,
                padding: TSizes.sm,
                image:
                    item.thumbnail.isNotEmpty
                        ? item.thumbnail
                        : TImages.defaultImage,
                imageType:
                    item.thumbnail.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  item.parent,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),

        /// ✅ Action Buttons
        DataCell(
          TTableActionButtons(
            onEditPressed: () {
              // TODO: Edit
            },
            onDeletePressed: () async {
              final confirm = await showDialog<bool>(
                context: Get.context!,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Delete'),
                      content: Text(
                        'Are you sure you want to delete "${item.title}"?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
              );

              if (confirm == true) {
                await controller.deleteVideoItem(item);
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => items.length;

  @override
  int get selectedRowCount => 0;
}
