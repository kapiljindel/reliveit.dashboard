import 'package:dashboard/common/widgets/breadcrumbs/breadcrumbs_with_heading.dart';
import 'package:dashboard/features/stream/screens/banner/create_banner/widgets/create_banner_form.dart';
import 'package:dashboard/routes/routes.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CreateBannerMobileScreen extends StatelessWidget {
  const CreateBannerMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TBreadcrumbsWithHeading(
                heading: 'Create Banner',
                breadcrumbItems: [TRoutes.banners, 'Create Banner'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Form
              CreateBannerForm(),
            ],
          ),
        ),
      ),
    );
  }
}
