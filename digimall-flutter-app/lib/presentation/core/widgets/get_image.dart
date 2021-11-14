import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<File> cropImage(File imageFile) async {
  File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrangeAccent,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      ));
  return croppedFile;
}

Future<File> pickGalleryImage() async {
  final PickedFile selected = await ImagePicker()
      .getImage(source: ImageSource.gallery, imageQuality: 1);
  final File file = File(selected.path);
  if (file != null) {
    // final File cropFile = await cropImage(file);
    return file;
    // if (cropFile != null) {
    //   return cropFile;
    // } else {}
  }
  return null;
}

Future<File> pickCameraImage() async {
  final PickedFile selected =
      await ImagePicker().getImage(source: ImageSource.camera, imageQuality: 1);
  final File file = File(selected.path);
  if (file != null) {
    return file;
    // File cropFile = await cropImage(file);
    // if (cropFile != null) {
    //   return cropFile;
    // }
  }
  return null;
}
