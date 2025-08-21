import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/images/t_rounded_image.dart';
import 'package:dashboard/features/stream/models/reports_model.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/enums.dart';
import 'package:dashboard/utils/constants/image_strings.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ReportInfo extends StatelessWidget {
  const ReportInfo({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Report Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Personal Info
          Row(
            children: [
              const TRoundedImage(
                padding: 0,
                backgroundColor: TColors.primaryBackground,
                image: TImages.user,
                imageType: ImageType.asset,
              ),

              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coding with T',
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const Text(
                      'support@codingwitht.com',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Report Title')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'missing video',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Report Id')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  '#[HDJTCFxMUmiQdsKnN9Ne]',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Series Id')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'Gaming Time',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwSections),

          // Additional Details
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Status',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('Active'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Average Weekly Reports',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('95'),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          // Additional Details Cont.
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Registered',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('August 14, 2025'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Type',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('Subscribed'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
