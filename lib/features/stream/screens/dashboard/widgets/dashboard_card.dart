import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/common/widgets/texts/section_heading.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TDashboardCard extends StatelessWidget {
  const TDashboardCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.stats,
    this.icon = Icons.arrow_upward,
    this.color = TColors.success,
    this.onTap,
  });

  final String title, subTitle;
  final IconData icon;
  final Color color;
  final int stats;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      onTap: onTap,
      padding: const EdgeInsets.all(TSizes.lg),
      child: Column(
        children: [
          // Heading
          TSectionHeading(title: title, textColor: TColors.textSecondary),
          const SizedBox(height: TSizes.spaceBtwSections),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),

              // Right Side Stats
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Indicator
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(icon, color: color, size: TSizes.iconSm),
                        Text(
                          "$stats%",
                          style: Theme.of(context).textTheme.titleLarge!.apply(
                            color: color,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Compared to text
                  SizedBox(
                    width: 135,
                    child: Text(
                      'Compared to Dec 2024',
                      style: Theme.of(context).textTheme.labelMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
