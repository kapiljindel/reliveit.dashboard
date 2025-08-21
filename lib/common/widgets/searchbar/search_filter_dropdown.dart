import 'package:flutter/material.dart';

class SearchFilterDropdown extends StatelessWidget {
  const SearchFilterDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          runSpacing: 20,
          children: [
            const Text(
              "Content Types",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children:
                  ["Videos", "Posts", "Products", "Users"]
                      .map(
                        (e) => FilterChip(label: Text(e), onSelected: (_) {}),
                      )
                      .toList(),
            ),

            const Text(
              "Content Cost",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children:
                  ["All", "Premium", "Free"]
                      .map(
                        (e) => FilterChip(label: Text(e), onSelected: (_) {}),
                      )
                      .toList(),
            ),

            const Text(
              "Membership Levels",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children:
                  ["Free", "Standard", "Plus", "VIP"]
                      .map(
                        (e) => FilterChip(label: Text(e), onSelected: (_) {}),
                      )
                      .toList(),
            ),

            const Text(
              "Video Categories",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children:
                  ["Gaming", "Travel", "Sports", "Music"]
                      .map(
                        (e) => FilterChip(label: Text(e), onSelected: (_) {}),
                      )
                      .toList(),
            ),

            const Text(
              "Video Tags",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Wrap(
              spacing: 8,
              children:
                  [
                        "Featured",
                        "Game",
                        "Music",
                        "Sports",
                        "Travel",
                        "World",
                        "Short",
                      ]
                      .map(
                        (e) => FilterChip(label: Text(e), onSelected: (_) {}),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
