import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

File? imageFile;
Uint8List? im;
pickimage(ImageSource source) async {
  final ImagePicker _imagepicker = ImagePicker();
  XFile? _file = await _imagepicker.pickImage(
      source: source, imageQuality: 90, maxWidth: 1080, maxHeight: 1080);
  if (_file != null) {
    return await _file.readAsBytes();
  }
}
