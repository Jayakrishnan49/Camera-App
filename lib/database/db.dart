import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:week_6_camera_app/model/model.dart';

ValueNotifier<List<Image>> imageList = ValueNotifier([]);

Future<void> addImage(String value) async {
  final imageDB = await Hive.openBox<ImageModel>('gallery');
  final data = ImageModel(image: value);
  await imageDB.add(data);
  await getImage(); 
}

Future<void> deleteImage(int index) async {
  final imageDB = await Hive.openBox<ImageModel>('gallery');
  await imageDB.deleteAt(index);
  await getImage(); 
}

Future<void> getImage() async {
  final imageDB = await Hive.openBox<ImageModel>('gallery');
  final images = imageDB.values.map((e) => Image.file(File(e.image),fit: BoxFit.cover,)).toList();
  imageList.value = images;
}
