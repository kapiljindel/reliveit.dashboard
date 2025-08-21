import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
//import 'package:iconsax/iconsax.dart';

// CategoryModel class as you gave
class CategoryModel {
  final String id;
  final String name;
  final String image;

  CategoryModel({required this.id, required this.name, required this.image});

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();
  final TextEditingController _videoIdController = TextEditingController();
  final TextEditingController _seriesController = TextEditingController();

  final List<CategoryModel> _allCategories = [
    CategoryModel(id: '1', name: 'Shoes', image: 'image'),
    CategoryModel(id: '2', name: 'Shirts', image: 'image'),
  ];

  final List<CategoryModel> _selectedCategories = [];

  @override
  void dispose() {
    _titleController.dispose();
    _releaseDateController.dispose();
    _videoIdController.dispose();
    _seriesController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      // Simulate saving data, here print to console
      debugPrint('Title: ${_titleController.text}');
      debugPrint('Release Date: ${_releaseDateController.text}');
      debugPrint('Video ID: ${_videoIdController.text}');
      debugPrint(
        'Selected Series: ${_selectedCategories.map((e) => e.name).join(', ')}',
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product saved successfully!')),
      );

      // TODO: Add your database save/update code here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter title'
                            : null,
              ),
              const SizedBox(height: 12),

              // Release Date Field
              TextFormField(
                controller: _releaseDateController,
                decoration: const InputDecoration(
                  labelText: 'Release Date',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter release date'
                            : null,
              ),
              const SizedBox(height: 12),

              // Video ID Field
              TextFormField(
                controller: _videoIdController,
                decoration: const InputDecoration(
                  labelText: 'Video ID',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Please enter video ID'
                            : null,
              ),
              const SizedBox(height: 12),

              // Series MultiSelect
              MultiSelectDialogField<CategoryModel>(
                items:
                    _allCategories
                        .map(
                          (cat) =>
                              MultiSelectItem<CategoryModel>(cat, cat.name),
                        )
                        .toList(),
                title: const Text('Series'),
                buttonText: const Text('Select Series'),
                listType: MultiSelectListType.CHIP,
                initialValue: _selectedCategories,
                onConfirm: (values) {
                  setState(() {
                    _selectedCategories.clear();
                    _selectedCategories.addAll(values);
                  });
                },
                validator:
                    (values) =>
                        values == null || values.isEmpty
                            ? 'Select at least one series'
                            : null,
              ),
              const SizedBox(height: 24),

              // Save Button
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
