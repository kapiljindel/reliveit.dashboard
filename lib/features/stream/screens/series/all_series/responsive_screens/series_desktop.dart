import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class SeriesDesktopScreen extends StatefulWidget {
  const SeriesDesktopScreen({super.key});

  @override
  State<SeriesDesktopScreen> createState() => _SeriesDesktopScreenState();
}

class _SeriesDesktopScreenState extends State<SeriesDesktopScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDocs = [];
  bool loading = true;
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
    searchController.addListener(onSearch);
  }

  Future<void> fetchCategories() async {
    setState(() {
      loading = true;
    });

    final snapshot = await firestore.collection('Posts').get();
    docs = snapshot.docs;
    filteredDocs = docs;
    setState(() {
      loading = false;
    });
  }

  void onSearch() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredDocs = docs;
      });
      return;
    }

    setState(() {
      filteredDocs =
          docs.where((doc) {
            final data = doc.data();
            final seriesName = doc.id.toLowerCase();
            final password = (data['Password'] ?? '').toString().toLowerCase();
            final category = (data['category'] ?? '').toString().toLowerCase();
            final featured = (data['Featured'] ?? '').toString().toLowerCase();

            return seriesName.contains(query) ||
                password.contains(query) ||
                category.contains(query) ||
                featured.contains(query);
          }).toList();
    });
  }

  Future<void> toggleFeatured(String docId, String currentFeatured) async {
    String newValue = currentFeatured.toLowerCase() == 'no' ? 'yes' : 'no';
    await firestore.collection('Posts').doc(docId).update({
      'Featured': newValue,
    });
    await fetchCategories();
  }

  Future<void> toggleLock(String docId, String currentLock) async {
    String newValue = currentLock.toLowerCase() == 'true' ? 'false' : 'true';
    await firestore.collection('Posts').doc(docId).update({'Lock': newValue});
    await fetchCategories();
  }

  Future<void> confirmDelete(String docId) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteConfirmDialog(),
    );
    if (confirmed == true) {
      await firestore.collection('Posts').doc(docId).delete();
      await fetchCategories();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Deleted successfully')));
    }
  }

  String formatDate(dynamic timestamp) {
    if (timestamp == null) return '-';
    try {
      DateTime dt;
      if (timestamp is Timestamp) {
        dt = timestamp.toDate();
      } else if (timestamp is DateTime) {
        dt = timestamp;
      } else if (timestamp is String) {
        dt = DateTime.parse(timestamp);
      } else {
        return '-';
      }
      return DateFormat.yMMMMd().format(dt); // Example: July 30, 2025
    } catch (e) {
      return '-';
    }
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
            // Header
            const Text(
              "Dashboard / Posts",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            const Text(
              "Posts",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Action Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard/posts/createnew');
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
                    "Create New Post",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search Posts",
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
                      "Post",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Text("Password", style: TextStyle(fontSize: 13)),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Category", style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Text("Lock", style: TextStyle(fontSize: 13))),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text("Featured", style: TextStyle(fontSize: 13)),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Date", style: TextStyle(fontSize: 13)),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text("Action", style: TextStyle(fontSize: 13)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 1),

            // Table Rows
            Expanded(
              child:
                  loading
                      ? const Center(child: CircularProgressIndicator())
                      : filteredDocs.isEmpty
                      ? const Center(child: Text('No Posts found.'))
                      : Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          itemCount: filteredDocs.length,
                          itemBuilder: (context, index) {
                            final doc = filteredDocs[index];
                            final data = doc.data();
                            final rowColor =
                                index.isEven
                                    ? Colors.white
                                    : const Color(0xFFF0F2F5);

                            String featured =
                                (data['Featured'] ?? 'yes').toString();
                            String lock = (data['Lock'] ?? 'false').toString();
                            dynamic releaseDate = data['releaseDate'];
                            String dateFormatted = formatDate(releaseDate);
                            String password =
                                (data['Password'] ?? '-').toString();
                            String categoryStr =
                                (data['category'] ?? '').toString();

                            return Container(
                              color: rowColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: false,
                                          onChanged: (_) {},
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(
                                          Icons.shopping_bag,
                                          size: 18,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(doc.id),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      password,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children:
                                              categoryStr.split(',').map((tag) {
                                                final trimmedTag = tag.trim();
                                                if (trimmedTag.isEmpty)
                                                  return const SizedBox.shrink();
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 6,
                                                      ),
                                                  child: OutlinedButton(
                                                    onPressed: () {},
                                                    style: OutlinedButton.styleFrom(
                                                      minimumSize: const Size(
                                                        0,
                                                        28,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      side: const BorderSide(
                                                        color: Colors.grey,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      trimmedTag,
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Lock toggle (smaller switch)
                                  Expanded(
                                    child: Transform.scale(
                                      scale: 0.7,
                                      alignment: Alignment.centerLeft,
                                      child: Switch(
                                        value: lock.toLowerCase() == 'true',
                                        onChanged:
                                            (_) => toggleLock(doc.id, lock),
                                        activeColor: Colors.blue,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 4),

                                  // Featured toggle icon
                                  Expanded(
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      icon: Icon(
                                        featured.toLowerCase() == 'no'
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 18,
                                        color:
                                            featured.toLowerCase() == 'no'
                                                ? Colors.blue
                                                : Colors.grey,
                                      ),
                                      onPressed:
                                          () =>
                                              toggleFeatured(doc.id, featured),
                                    ),
                                  ),

                                  const SizedBox(width: 20),

                                  // Date column - aligned right with smaller spacing
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        dateFormatted,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // Action buttons
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // TODO: Add group action
                                            Navigator.pushNamed(
                                              context,
                                              '/dashboard/posts/editpost/<postId>',
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 18,
                                            color: Colors.green,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          onPressed:
                                              () => confirmDelete(doc.id),
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 18,
                                            color: Colors.red,
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                      ],
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

class DeleteConfirmDialog extends StatelessWidget {
  const DeleteConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/delete_popup.png', // Replace with your image asset path
                  height: 90,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Delete file?",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 6),
              const Text(
                "Deleting this file will place it in the trash.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'DELETE',
                      style: TextStyle(color: Colors.white),
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
