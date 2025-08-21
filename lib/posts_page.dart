import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PostsDashboard());
}

class PostsDashboard extends StatelessWidget {
  const PostsDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movies Admin',
      debugShowCheckedModeBanner: false,
      home: MoviesAdminPanel(),
    );
  }
}

class MoviesAdminPanel extends StatefulWidget {
  const MoviesAdminPanel({super.key});
  @override
  State<MoviesAdminPanel> createState() => _MoviesAdminPanelState();
}

class _MoviesAdminPanelState extends State<MoviesAdminPanel> {
  final CollectionReference postsRef = FirebaseFirestore.instance.collection(
    'Posts',
  );
  String searchText = '';
  bool showPublishedOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies Admin'),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildControls(),
            const SizedBox(height: 20),
            Expanded(child: _buildDataTable()),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add New Post'),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search Posts…',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => searchText = v),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton(onPressed: _importByUrl, child: const Text('Import')),
      ],
    );
  }

  Future<void> _importByUrl() async {
    // TODO: Implement import logic
  }

  Widget _buildDataTable() {
    return StreamBuilder<QuerySnapshot>(
      stream: postsRef.snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final allDocs = snap.data!.docs;
        final filtered =
            allDocs.where((doc) {
              final title = doc.id.toLowerCase();
              if (searchText.isNotEmpty &&
                  !title.contains(searchText.toLowerCase())) {
                return false;
              }
              return true;
            }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
            ),
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
              columns: const [
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Author')),
                DataColumn(label: Text('Tags')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Rating')),
                DataColumn(label: Text('IMDb ID')),
                DataColumn(label: Text('Views')),
                DataColumn(label: Text('Featured')),
                DataColumn(label: Text('Actions')),
              ],
              rows: filtered.map(_buildRow).toList(),
            ),
          ),
        );
      },
    );
  }

  DataRow _buildRow(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final title = doc.id;
    final author = data['Password']?.toString() ?? '';
    final tags =
        data['category'] is List
            ? (data['category'] as List).join(', ')
            : data['category']?.toString() ?? '';
    final date = data['releaseDate']?.toString() ?? '';
    final rating = data['description']?.toString() ?? '';
    final imdb = data['Likes']?.toString() ?? '';
    final views = data['Dislikes']?.toString() ?? '';
    final featured = (data['Featured'] ?? 'no').toString().toLowerCase();

    return DataRow(
      cells: [
        DataCell(Text(title)),
        DataCell(Text(author)),
        DataCell(Text(tags)),
        DataCell(Text(date)),
        DataCell(Text(rating)),
        DataCell(Text(imdb)),
        DataCell(Text(views)),
        DataCell(
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: featured == 'yes' ? Colors.green : Colors.grey,
            ),
            onPressed: () {
              postsRef.doc(title).update({
                'Featured': featured == 'yes' ? 'no' : 'yes',
              });
            },
            child: Text(featured == 'yes' ? 'REMOVE' : 'FEATURED'),
          ),
        ),
        DataCell(
          Row(
            children: [
              TextButton(onPressed: () {}, child: const Text('Edit')),
              const SizedBox(width: 8),
              TextButton(onPressed: () {}, child: const Text('Delete')),
            ],
          ),
        ),
      ],
    );
  }
}
