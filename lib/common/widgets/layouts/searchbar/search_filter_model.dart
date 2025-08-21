// lib/models/search_filter_model.dart

class SearchFilterModel {
  final String title;
  final List<String> options;
  final bool isMultiSelect;

  SearchFilterModel({
    required this.title,
    required this.options,
    this.isMultiSelect = true,
  });
}
