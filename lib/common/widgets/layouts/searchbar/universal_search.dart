import 'package:dashboard/common/widgets/layouts/searchbar/search_filter_dropdown.dart';
import 'package:flutter/material.dart';

class SearchWithDropdown extends StatelessWidget {
  const SearchWithDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: 480,
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search here...",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.tune),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  builder: (_) => const SearchFilterDropdown(),
                );
              },
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }
}
