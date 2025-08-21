import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditCustomersDesktopScreen extends StatefulWidget {
  final String uid;
  const EditCustomersDesktopScreen({super.key, required this.uid});

  @override
  State<EditCustomersDesktopScreen> createState() =>
      _EditCustomersDesktopScreenState();
}

class _EditCustomersDesktopScreenState
    extends State<EditCustomersDesktopScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> userData = {};
  List<Map<String, dynamic>> historyList = [];

  bool loading = true;
  bool isEditing = false;
  bool isImageEditing = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final uidController = TextEditingController();
  final imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final doc = await firestore.collection('users').doc('Users').get();
    final data = doc.data() ?? {};
    final user = (data[widget.uid] ?? {}) as Map<String, dynamic>;

    final history = (user['watchHistory'] ?? {}) as Map<String, dynamic>;

    final parsedHistory = await Future.wait(
      history.entries.map((entry) async {
        final seriesId = entry.key;
        final watchedAt = entry.value['watchedAt'] ?? '';
        final premiumStatus = await _getSeriesSubscription(seriesId);
        return {
          'seriesId': seriesId,
          'watchedAt': watchedAt,
          'premiumStatus': premiumStatus,
        };
      }),
    );

    setState(() {
      userData = user;
      historyList = parsedHistory;
      loading = false;

      nameController.text = user['displayName'] ?? '';
      emailController.text = user['email'] ?? '';
      uidController.text = widget.uid;
    });
  }

  Future<void> saveUserData() async {
    final updatedData = {
      'displayName': nameController.text,
      'email': emailController.text,
      'imageUrl': userData['imageUrl'], // Save the image URL as well
    };

    await firestore.collection('users').doc('Users').update({
      widget.uid: {...userData, ...updatedData},
    });

    setState(() {
      isEditing = false;
    });

    fetchUserData();
  }

  Future<void> saveImageUrl() async {
    final updatedData = {
      'imageUrl': imageUrlController.text, // Update image URL
    };

    await firestore.collection('users').doc('Users').update({
      widget.uid: {...userData, ...updatedData},
    });

    setState(() {
      isImageEditing = false;
    });

    fetchUserData();
  }

  Future<void> deleteHistoryEntry(String seriesId) async {
    final ref = firestore.collection('users').doc('Users');
    await ref.update({
      '${widget.uid}.watchHistory.$seriesId': FieldValue.delete(),
    });
    fetchUserData();
  }

  String formatDate(String dateString) {
    try {
      final date = DateFormat("MMMM dd, yyyy").parse(dateString);
      return DateFormat.yMMMd().add_jm().format(date);
    } catch (e) {
      return '-';
    }
  }

  // Fetch the Premium status for a specific series
  Future<String> _getSeriesSubscription(String seriesId) async {
    try {
      final doc = await firestore.collection('Posts').doc(seriesId).get();
      final data = doc.data();
      if (data != null && data['Premium'] != null) {
        return data['Premium'] == 'Premium' ? 'Premium' : 'Free';
      }
    } catch (e) {
      print("Error fetching Premium status: $e");
    }
    return 'Free'; // Default to 'Free' if Premium is missing or null
  }

  @override
  Widget build(BuildContext context) {
    final bool isPremium = userData['isPremium'] ?? false;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile Row (Profile Image and Profile Details)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Image - Left Column
                        Container(
                          width: 250,
                          height: 270,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (isEditing) {
                                    _showEditImageDialog(); // Show the image URL dialog
                                  }
                                },
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundImage: NetworkImage(
                                        userData['imageUrl'] ??
                                            "https://img.icons8.com/color/96/flutter.png",
                                      ),
                                    ),
                                    if (isEditing)
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.3,
                                                ),
                                                blurRadius: 5,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.edit_rounded,
                                            color: Colors.blue,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                nameController.text,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                emailController.text,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),

                        // Profile Details - Right Column (Same Height as Image Column)
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Profile Details",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: const InputDecoration(
                                          labelText: "Full Name",
                                        ),
                                        readOnly: !isEditing,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextFormField(
                                        controller: uidController,
                                        decoration: const InputDecoration(
                                          labelText: "UID",
                                        ),
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                          labelText: "Email",
                                        ),
                                        readOnly: !isEditing,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          labelText: "Subscription",
                                        ),
                                        controller: TextEditingController(
                                          text: isPremium ? "Premium" : "Free",
                                        ),
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                // Edit/Save Button
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isEditing) {
                                        saveUserData(); // Save data when in edit mode
                                      } else {
                                        isEditing = true; // Switch to edit mode
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      50,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    backgroundColor: const Color(0xFF3C6FF0),
                                  ),
                                  child: Text(
                                    isEditing ? "Save" : "Edit Profile",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // Watch History Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Watch History",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (historyList.isEmpty)
                            const Text("No history found"),
                          if (historyList.isNotEmpty)
                            Column(
                              children: [
                                Row(
                                  children: const [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Series ID",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text("Watched At"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Subscription",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    Icon(Icons.more_vert),
                                  ],
                                ),
                                const Divider(),
                                ...historyList.map((entry) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          historyList.indexOf(entry).isEven
                                              ? Colors.white
                                              : const Color(0xFFF1F3F5),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(entry['seriesId']),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            formatDate(entry['watchedAt']),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color:
                                                    entry['premiumStatus'] ==
                                                            'Premium'
                                                        ? Colors.green
                                                        : Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                entry['premiumStatus'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          onPressed:
                                              () => deleteHistoryEntry(
                                                entry['seriesId'],
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  void _showEditImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile Image URL'),
          content: TextField(
            controller: imageUrlController,
            decoration: const InputDecoration(hintText: 'Enter Image URL'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  isImageEditing = true;
                  userData['imageUrl'] =
                      imageUrlController.text; // Update image URL
                });
                saveImageUrl();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
