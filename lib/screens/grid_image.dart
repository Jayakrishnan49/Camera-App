import 'package:flutter/material.dart';
import 'package:week_6_camera_app/database/db.dart';

class FullImageScreen extends StatelessWidget {
  final Image image;
  final int index;

  const FullImageScreen({super.key, required this.image, required this.index});

  void _deleteImage(BuildContext context) async {
    await deleteImage(index);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Image'),
          content: const Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                 _deleteImage(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: image),
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: const Icon(Icons.delete),
          ),
        ],
     ),
);
}
}