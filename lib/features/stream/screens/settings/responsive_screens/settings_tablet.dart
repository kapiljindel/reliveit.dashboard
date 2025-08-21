import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsTabletScreen extends StatefulWidget {
  const SettingsTabletScreen({Key? key}) : super(key: key);

  @override
  State<SettingsTabletScreen> createState() => _SettingsTabletScreenState();
}

class _SettingsTabletScreenState extends State<SettingsTabletScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, TextEditingController> _controllers = {};
  String _selectedDocId = '';

  Future<void> _updateSetting(String docId, String field, String value) async {
    try {
      await _firestore.collection('settings').doc(docId).update({field: value});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Setting updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to update: $e')));
    }
  }

  Widget _buildField(String docId, String field, dynamic value) {
    final key = '$docId-$field';
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(text: value?.toString() ?? '');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(field, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _controllers[key],
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () {
                  _updateSetting(docId, field, _controllers[key]!.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2979FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSection(String docId, Map<String, dynamic> data) {
    final fields =
        data.entries.map((e) => _buildField(docId, e.key, e.value)).toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Document: $docId',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          ...fields,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Settings', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 6),
            const Text(
              'Manage your account settings and preferences.',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 28),

            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestore.collection('settings').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No settings found.'));
                  }

                  final docs = snapshot.data!.docs;
                  final docIds = docs.map((doc) => doc.id).toList();

                  if (_selectedDocId.isEmpty ||
                      !docIds.contains(_selectedDocId)) {
                    _selectedDocId = docIds.first;
                  }

                  final selectedDoc = docs.firstWhere(
                    (doc) => doc.id == _selectedDocId,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children:
                            docIds.map((docId) {
                              final isSelected = _selectedDocId == docId;
                              return ChoiceChip(
                                label: Text(docId),
                                selected: isSelected,
                                onSelected:
                                    (_) =>
                                        setState(() => _selectedDocId = docId),
                                selectedColor: const Color(0xFF2979FF),
                                labelStyle: TextStyle(
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: _buildDocumentSection(
                          _selectedDocId,
                          selectedDoc.data(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
