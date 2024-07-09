import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  File? image;

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
}
