import 'package:dashboard/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/utils/constants/colors.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:dashboard/common/styles/spacing_styles.dart';

class TLoginTemplate extends StatelessWidget {
  const TLoginTemplate({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
              color:
                  THelperFunctions.isDarkMode(context)
                      ? TColors.black
                      : Colors.white,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
