import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/controllers/category/category_controller.dart';
import 'package:dashboard/features/stream/models/category_model.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dashboard/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:iconsax/iconsax.dart';

class CategoryRow extends DataTableSource {
  final List<CategoryModel> categories;

  CategoryRow(this.categories);

  @override
  DataRow? getRow(int index) {
    if (index >= categories.length) return null;
    final category = categories[index];

    return DataRow2(
      cells: [
        DataCell(
          Row(
            children: [
              TRoundedImage(
                width: 50,
                height: 55,
                padding: TSizes.sm,
                image:
                    category.imageUrl.isNotEmpty
                        ? category.imageUrl
                        : TImages.defaultImage,
                imageType:
                    category.imageUrl.isNotEmpty
                        ? ImageType.network
                        : ImageType.asset,
                borderRadius: TSizes.borderRadiusMd,
                backgroundColor: TColors.primaryBackground,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Text(
                  category.name,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge!.apply(color: TColors.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(category.parentCategory ?? '-')),
        DataCell(
          IconButton(
            icon: Icon(
              category.featured ? Iconsax.heart5 : Iconsax.heart,
              color: category.featured ? TColors.primary : Colors.grey,
            ),
            onPressed: () {
              Get.find<CategoryController>().toggleFeatured(
                category.id,
                category.featured,
              );
            },
          ),
        ),
        DataCell(Text(category.date)),
        DataCell(
          TTableActionButtons(
            onEditPressed:
                () => Get.toNamed(TRoutes.editCategory, arguments: category),
            onDeletePressed:
                () =>
                    Get.find<CategoryController>().deleteCategory(category.id),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}
