import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/models/banner_model.dart';
//import 'package:dashboard/features/stream/screens/banner/all_banners/table/table_source.dart';
import 'package:dashboard/features/stream/screens/banner/edit_banner/widgets/edit_banner_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class EditBannerMobileScreen extends StatelessWidget {
  const EditBannerMobileScreen({super.key, required this.banner});
  final BannerModel banner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TBreadcrumbsWithHeading(
                heading: 'Update Banner',
                breadcrumbItems: [TRoutes.banners, 'Update Banner'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              EditBannerForm(banner: banner),
            ],
          ),
        ),
      ),
    );
  }
}
