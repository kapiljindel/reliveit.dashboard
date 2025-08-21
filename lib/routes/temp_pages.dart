import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class AnimationGallery extends StatefulWidget {
  const AnimationGallery({super.key});

  @override
  _AnimationGalleryState createState() => _AnimationGalleryState();
}

class _AnimationGalleryState extends State<AnimationGallery> {
  List<String> animationFiles = [];

  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  Future<void> loadAnimations() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = Map<String, dynamic>.from(
      json.decode(manifestContent),
    );

    final files =
        manifestMap.keys
            .where(
              (String key) =>
                  key.startsWith('assets/images/animations/') &&
                  key.endsWith('.json'),
            )
            .toList();

    setState(() {
      animationFiles = files;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Lottie Animations')),
      body:
          animationFiles.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: animationFiles.length,
                itemBuilder: (context, index) {
                  final file = animationFiles[index];
                  final name = file.split('/').last;
                  return Column(
                    children: [
                      Expanded(child: Lottie.asset(file, repeat: true)),
                      Text(
                        name,
                        style: TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                },
              ),
    );
  }
}
