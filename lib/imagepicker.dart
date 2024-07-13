import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? image;
  List<File>? photo = [];

  Imagepicker() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedimage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      image = File(pickedimage.path);
    }
    notifyListeners();
  }

  setimagenull(value) {
    image = value;
    notifyListeners();
  }

// Initialize as empty list

  Future<void> Imagepickerbycamera() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      photo!.add(File(pickedImage.path));
      notifyListeners(); // Notify listeners after updating photo list
    }
  }

  setphotonull(value) {
    photo = value;
    notifyListeners();
  }
}
