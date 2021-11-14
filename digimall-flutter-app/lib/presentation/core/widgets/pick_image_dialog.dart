import 'dart:io';

import 'package:flutter/material.dart';
import 'package:prachar/presentation/core/widgets/get_image.dart';

Future<Dialog> chooseImage({BuildContext context, Function fn}) async {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: iconImages('gallery.png'),
                  title: const Text('Image from Gallery'),
                  onTap: () async {
                    final File chosenFile = await pickGalleryImage();
                    if (chosenFile != null) {
                      fn(chosenFile);
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                    leading: iconImages('camera.png'),
                    title: const Text('Image from Camera'),
                    onTap: () async {
                      final File chosenFile = await pickCameraImage();
                      if (chosenFile != null) {
                        fn(chosenFile);
                      }
                      Navigator.pop(context);
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.cancel_rounded,
                      color: Colors.black26,
                      size: 30,
                    ),
                    title: const Text('Cancel'),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        );
      });
}

Image iconImages(String iconName) {
  return Image.asset('assets/icons/$iconName',
      height: 25, width: 25, color: Colors.black26);
}
