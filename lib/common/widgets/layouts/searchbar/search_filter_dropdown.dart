// lib/common/widgets/search/search_filter_dropdown.dart

import 'package:flutter/material.dart';

class SearchFilterDropdown extends StatefulWidget {
  const SearchFilterDropdown({super.key});

  @override
  State<SearchFilterDropdown> createState() => _SearchFilterDropdownState();
}

class _SearchFilterDropdownState extends State<SearchFilterDropdown> {
  // Temporary selections
  final Map<String, Set<String>> _selectedOptions = {
    'Content Types': {'Videos'},
    'Content Cost': {},
    'Membership Levels': {},
    'Video Categories': {},
    'Video Tags': {},
  };

  final Map<String, List<String>> filterOptions = {
    'Content Types': ['Videos', 'Posts', 'Products', 'Users'],
    'Content Cost': ['All', 'Premium', 'Free'],
    'Membership Levels': ['Free', 'Standard', 'Plus', 'VIP'],
    'Video Categories': ['Gaming', 'Travel', 'Sports', 'Music'],
    'Video Tags': [
      'Featured (26)',
      'Game (16)',
      'Music (11)',
      'Sports (10)',
      'Travel (10)',
      'World (9)',
      'Short (8)',
    ],
  };

  void _toggleOption(String category, String option) {
    setState(() {
      if (_selectedOptions[category]!.contains(option)) {
        _selectedOptions[category]!.remove(option);
      } else {
        _selectedOptions[category]!.add(option);
      }
    });
  }

  void _resetFilters() {
    setState(() {
      for (var key in _selectedOptions.keys) {
        _selectedOptions[key]!.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 380,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var entry in filterOptions.entries)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            entry.value.map((option) {
                              final selected = _selectedOptions[entry.key]!
                                  .contains(option);
                              return ChoiceChip(
                                label: Text(option),
                                selected: selected,
                                onSelected:
                                    (_) => _toggleOption(entry.key, option),
                                selectedColor: Theme.of(context).primaryColor,
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _resetFilters,
                    child: const Text("Reset"),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop(_selectedOptions);
                    },
                    icon: const Icon(Icons.search),
                    label: const Text("Search"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
