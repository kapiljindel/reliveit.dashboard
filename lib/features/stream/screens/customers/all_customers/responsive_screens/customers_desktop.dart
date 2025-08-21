import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomersDesktopScreen extends StatefulWidget {
  const CustomersDesktopScreen({super.key});

  @override
  State<CustomersDesktopScreen> createState() => _CustomersDesktopScreenState();
}

class _CustomersDesktopScreenState extends State<CustomersDesktopScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String, dynamic> allUsers = {};
  List<MapEntry<String, dynamic>> filteredUsers = [];
  bool loading = true;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUsers();
    searchController.addListener(onSearch);
  }

  Future<void> fetchUsers() async {
    setState(() {
      loading = true;
    });

    final docSnap = await firestore.collection('users').doc('Users').get();
    if (docSnap.exists) {
      allUsers = docSnap.data() as Map<String, dynamic>;
      filteredUsers = allUsers.entries.toList();
    }

    setState(() {
      loading = false;
    });
  }

  void onSearch() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredUsers = allUsers.entries.toList();
      } else {
        filteredUsers =
            allUsers.entries.where((entry) {
              final userData = entry.value as Map<String, dynamic>;
              final name =
                  (userData['displayName'] ?? '').toString().toLowerCase();
              final email = (userData['email'] ?? '').toString().toLowerCase();
              return name.contains(query) || email.contains(query);
            }).toList();
      }
    });
  }

  Future<void> togglePremium(String uid, bool currentStatus) async {
    await firestore.collection('users').doc('Users').update({
      '$uid.isPremium': !currentStatus,
    });
    await fetchUsers();
  }

  Future<void> deleteUser(String uid) async {
    await firestore.collection('users').doc('Users').update({
      uid: FieldValue.delete(),
    });
    await fetchUsers();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('User deleted successfully')));
  }

  String formatDate(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return DateFormat.yMMMMd().format(timestamp.toDate());
    }
    return '-';
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Dashboard / Users",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            const Text(
              "Users",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/createCustomer');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3C6FF0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                textStyle: const TextStyle(fontSize: 13),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                "Create New User",
                style: TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            // Search bar
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search Users",
                      prefixIcon: const Icon(Icons.search, size: 18),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "UID",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(flex: 2, child: Text("Name")),
                  Expanded(flex: 3, child: Text("Email")),
                  Expanded(flex: 1, child: Text("Premium")),
                  Expanded(flex: 2, child: Text("Created At")),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Actions"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 1),

            // Table Body
            Expanded(
              child:
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : filteredUsers.isEmpty
                      ? const Center(child: Text('No Users Found'))
                      : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final uid = filteredUsers[index].key;
                            final data =
                                filteredUsers[index].value
                                    as Map<String, dynamic>;
                            final rowColor =
                                index.isEven
                                    ? Colors.white
                                    : const Color(0xFFF0F2F5);
                            final isPremium = data['isPremium'] == true;

                            return Container(
                              color: rowColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(flex: 2, child: Text(uid)),
                                  Expanded(
                                    flex: 2,
                                    child: Text(data['displayName'] ?? '-'),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(data['email'] ?? '-'),
                                  ),

                                  // Premium Toggle
                                  Expanded(
                                    flex: 1,
                                    child: Transform.scale(
                                      scale: 0.75,
                                      child: Switch(
                                        value: isPremium,
                                        onChanged:
                                            (_) =>
                                                togglePremium(uid, isPremium),
                                        activeColor: Colors.green,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    flex: 2,
                                    child: Text(formatDate(data['createdAt'])),
                                  ),

                                  // Action Buttons
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.visibility,
                                              color: Colors.blue,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/customerDetails',
                                              );
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                            onPressed: () => deleteUser(uid),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
