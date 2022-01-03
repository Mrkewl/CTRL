import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Helper {
  Future<File?>? pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        return null;
      } else {
        return File(pickedFile.path);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
