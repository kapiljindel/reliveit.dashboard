// lib/controllers/universal_search_controller.dart

import 'package:get/get.dart';

enum SearchFilter { all, users, orders, reports }

class UniversalSearchController extends GetxController {
  var query = ''.obs;
  var results = <String>[].obs;
  var selectedFilter = SearchFilter.all.obs;

  void updateFilter(SearchFilter filter) {
    selectedFilter.value = filter;
    if (query.value.isNotEmpty) {
      search(query.value);
    }
  }

  void search(String value) {
    query.value = value;

    List<String> allData = [];

    switch (selectedFilter.value) {
      case SearchFilter.all:
        allData = [
          ..._searchUsers(value),
          ..._searchOrders(value),
          ..._searchReports(value),
        ];
        break;
      case SearchFilter.users:
        allData = _searchUsers(value);
        break;
      case SearchFilter.orders:
        allData = _searchOrders(value);
        break;
      case SearchFilter.reports:
        allData = _searchReports(value);
        break;
    }

    results.value = allData;
  }

  List<String> _searchUsers(String value) {
    final users = ['John Doe', 'Jane Smith', 'Ankit Sharma'];
    return users
        .where((u) => u.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  List<String> _searchOrders(String value) {
    final orders = ['Order #1234', 'Order #5678', 'Order #9999'];
    return orders
        .where((o) => o.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }

  List<String> _searchReports(String value) {
    final reports = ['Sales Report', 'User Activity Report', 'Revenue Report'];
    return reports
        .where((r) => r.toLowerCase().contains(value.toLowerCase()))
        .toList();
  }
}
