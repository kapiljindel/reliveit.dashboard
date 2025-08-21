import 'package:dashboard/common/widgets/containers/rounded_container.dart';
import 'package:dashboard/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class OrderTitleAndDescription extends StatefulWidget {
  const OrderTitleAndDescription({super.key});

  @override
  State<OrderTitleAndDescription> createState() =>
      _OrderTitleAndDescriptionState();
}

class _OrderTitleAndDescriptionState extends State<OrderTitleAndDescription> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Text(
              'Basic Information',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            // Order Title Input Field
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Order Title cannot be empty';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Title'),
            ),

            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Order Description Input Field
            SizedBox(
              height: 388,
              child: TextFormField(
                controller: _descriptionController,
                expands: true,
                maxLines: null,
                textAlign: TextAlign.start,
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Order Description cannot be empty';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Order Description',
                  hintText: 'Add your Order Description here...',
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            // Order Title Input Field
            TextFormField(
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Order Title cannot be empty';
                }
                return null;
              },
              decoration: const InputDecoration(labelText: 'Video ID'),
            ),
          ],
        ),
      ),
    );
  }
}
