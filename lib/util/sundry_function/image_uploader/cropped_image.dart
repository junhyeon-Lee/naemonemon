import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shovving_pre/main.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:shovving_pre/modules/sign/sign_controller/sign_repository.dart';
import 'package:shovving_pre/util/sundry_function/image_uploader/image_uploade_repository.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/profile/inti_profile_controller.dart';

import '../../../modules/main/home/profile/profile_controller.dart';

var globalKey = GlobalKey();
class CroppedImage extends StatelessWidget {
  const CroppedImage({Key? key, required this.fileData}) : super(key: key);


  final CroppedFile fileData;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CroppedController>(
      init: CroppedController(),
      builder: (GetxController controller) {
        return Scaffold(
            body: Container(color: Colors.black,

              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RepaintBoundary(
                      key: globalKey,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(500)),
                        child: Image.file(File(fileData.path)

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class CroppedController extends GetxController{
  @override
  Future<void> onInit() async {
    await Future.delayed(const Duration(milliseconds: 500));



    var renderObject = globalKey.currentContext?.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage();
      const directory = '/data/user/0/com.naemo.nemon/cache';
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      File imgFile = File('$directory/screenshot${DateTime.now()}.png');
      imgFile.writeAsBytes(pngBytes!);
      Get.find<InitProfileController>().userSelfImage=imgFile;

      ImageUploadRepository imageUploadRepository = ImageUploadRepository();
      imageUploadRepository.imageUpload(imgFile);


    }

    Get.back();
    Get.find<InitProfileController>().update();

    super.onInit();
  }

  void capture(){

  }

}

class CroppedImage2 extends StatelessWidget {
  const CroppedImage2({Key? key, required this.fileData}) : super(key: key);


  final CroppedFile fileData;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CroppedController2>(
      init: CroppedController2(),
      builder: (GetxController controller) {
        return Scaffold(
            body: Container(color: Colors.black,

              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: RepaintBoundary(
                      key: globalKey,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(500)),
                        child: Image.file(File(fileData.path)

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

class CroppedController2 extends GetxController{
  @override
  Future<void> onInit() async {
    await Future.delayed(const Duration(milliseconds: 500));



    var renderObject = globalKey.currentContext?.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage();
      const directory = '/data/user/0/com.naemo.nemon/cache';
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      File imgFile = File('$directory/screenshot${DateTime.now()}.png');
      imgFile.writeAsBytes(pngBytes!);

      ///이미지 업로드
      ImageUploadRepository imageUploadRepository = ImageUploadRepository();
      String? uploadedImage = await imageUploadRepository.imageUpload(imgFile);

      ///이거를 가지고 프로필 업데이트

      SignRepository signRepository = SignRepository();
      await signRepository.updateUsersInfo(userInfoController.usersInfo!.nickName!, uploadedImage??userInfoController.usersInfo!.profileImage!);
      Get.find<ProfileController>().update();
      homeController.update();

    }

    Get.back();
    Get.find<ProfileController>().update();

    super.onInit();
  }

  void capture(){

  }

}