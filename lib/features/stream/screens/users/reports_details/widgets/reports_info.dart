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
            'Customer Information',
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
              const SizedBox(width: 120, child: Text('Username')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'cwT',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Country')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  'United Kingdom',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(
                child: Text(
                  '+44-7456-285429',
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
                      'Last Order',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('7 Days Ago, #[36d54]'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Average Order Value',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Text('\$352'),
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
                    // Text(customer.formattedDate),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email Marketing',
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
