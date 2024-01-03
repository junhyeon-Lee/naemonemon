import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';

Future<CroppedFile?> getImageData() async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage == null) {

  } else {
    File? image = File(pickedImage.path);
    CroppedFile? croppedFile = await cropImage(image.path);
    return croppedFile;
  }
  return null;
}

Future<CroppedFile?> cropImage(filePath) async {
  final croppedFile = await ImageCropper().cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),

      cropStyle: CropStyle.circle,
      compressQuality: 10,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
            hideBottomControls: true,
        ),
      ]);
  return croppedFile;
}


