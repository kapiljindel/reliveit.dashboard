import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderBottomNavigationButtons extends StatelessWidget {
  const OrderBottomNavigationButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("All changes were discarded.")),
              );
            },
            child: const Text('Discard'),
          ),
          const SizedBox(width: TSizes.spaceBtwItems / 2),
          SizedBox(
            width: 160,
            child: ElevatedButton(
              onPressed: () async {},
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
