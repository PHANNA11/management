import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StorageHome extends StatefulWidget {
  const StorageHome({super.key});

  @override
  State<StorageHome> createState() => _StorageHomeState();
}

class _StorageHomeState extends State<StorageHome> {
  final storageRef = FirebaseStorage.instance.ref();
  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Storage'),
      ),
      body: image == null
          ? SizedBox()
          : Image(
              image: NetworkImage(
                image.toString(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final imageUrl = await storageRef
              .child(
                  "images/358438503_621026446672901_9057544623071049694_n.jpg")
              .getDownloadURL();
          setState(() {
            image = imageUrl;
          });
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
