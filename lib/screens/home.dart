import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:week_6_camera_app/database/db.dart';
import 'package:week_6_camera_app/screens/grid_image.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getImage();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final image = File(pickedFile.path);
      imageList.value = List.from(imageList.value)..add(Image.file(image));
      await addImage(image.path);
    }
  }

  void _onCardTapped(int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FullImageScreen(image: imageList.value[index], index: index);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Gallery"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<Image>>(
        valueListenable: imageList,
        builder: (context, images, _) {
          return Stack(
            children: [
              if (images.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape:ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
              
                        ),
                        color: Colors.white,
                        child: InkWell(
                          onTap: () => _onCardTapped(index),
                          child: images[index],
                        ),
                      );
                    },
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _pickImage,
                    child: const Icon(Icons.camera_alt),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



