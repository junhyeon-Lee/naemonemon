import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shovving_pre/main.dart';
import 'package:shovving_pre/modules/main/home/profile/profile_controller.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import 'package:shovving_pre/util/sundry_function/image_uploader/cropped_image.dart';
import 'package:shovving_pre/util/sundry_function/image_uploader/image_cropper.dart';
import 'package:shovving_pre/util/sundry_function/safe_print.dart';
import 'package:shovving_pre/util/sundry_widget/profile/inti_profile_controller.dart';

import '../../../modules/main/home/profile/profile_screen.dart';

class InitPresetProfileScreen extends StatelessWidget {
  const InitPresetProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InitProfileController>(
      builder: (profileController) {
        Widget presetImage(int index) {
          return GestureDetector(
            onTap: () {
              profileController.settingImage = ImagePath.presetProfile[index];
              profileController.update();
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
              ),
              child: CachedNetworkImage(
                imageUrl: ImagePath.presetProfile[index],
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: CColor.gray.withOpacity(0.3),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          );
        }

        return Scaffold(
            body: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 147,
              child: Hero(
                tag: 'preset',
                child: Container(
                  width: 260,
                  height: 260,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(260)),
                      border: Border.all(width: 8, color: CColor.lightGray),
                    ),

                child: CachedNetworkImage(
                  imageUrl: profileController.settingImage ?? profileController.profilePath,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: CColor.gray.withOpacity(0.3),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),


                ),
              ),
            ),
            Positioned(
                top: 147 + 260 + 64 + 20,
                child: CommonContainer(
                  width: Get.width - 40,
                  height: 200,
                  containerColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            presetImage(0),
                            presetImage(1),
                            presetImage(2),
                            presetImage(3),
                            presetImage(4),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            presetImage(5),
                            presetImage(6),
                            presetImage(7),
                            presetImage(8),
                            presetImage(9),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
            Positioned(
              top: 147 + 260 + 64,
              child: GestureDetector(
                onTap: () {
                  profileController.profilePath = profileController.settingImage ?? profileController.profilePath;
                  profileController.userSelfImage = null;
                  profileController.update();
                  Get.back();
                },
                child: CommonContainer(
                  width: Get.width - 40,
                  height: 40,
                  containerColor: CColor.redCaution,
                  child: Center(child: SvgPicture.asset(CIconPath.upload, width: 34)),
                ),
              ),
            ),
            Positioned(
              top: 147 + 260 + 200 + 64,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: CommonContainer(
                  width: Get.width - 40,
                  height: 40,
                  containerColor: CColor.subLightGray,
                  child: SvgPicture.asset(CIconPath.back),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}

Widget profileImage() {
  return GetBuilder<ProfileController>(
    builder: (profileController) {
      return Stack(
        children: [
          Hero(
            tag: 'preset',
            child: CustomPaint(
              size: const Size(230, 230),
              painter: const ProfilePainter(),
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(230)),
                  border: Border.all(width: 8, color: CColor.lightGray),
                ),
                child: CachedNetworkImage(
                  imageUrl: userInfoController.usersInfo!.profileImage!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: CColor.gray.withOpacity(0.3),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),




              ),
            ),
          ),
          Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                  onTap: () {
                    Get.to(const PresetProfileScreen());
                  },
                  child: SvgPicture.asset(CIconPath.preset))),
          Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                  onTap: () async {
                    CroppedFile? croppedFile = await getImageData();
                    Get.to(CroppedImage2(fileData: croppedFile!,));
                    //profileController.userSelfImage = croppedFile;

                    profileController.update();
                  },
                  child: SvgPicture.asset(CIconPath.gallery))),
        ],
      );
    },
  );
}

Widget initProfileImage() {
  return GetBuilder<InitProfileController>(
    builder: (profileController) {
      return Stack(
        children: [
          Hero(
            tag: 'preset',
            child: CustomPaint(
              size: const Size(230, 230),
              painter: const ProfilePainter(),
              child: Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(230)),
                  border: Border.all(width: 8, color: CColor.lightGray),
                ),
                child: CachedNetworkImage(
                  imageUrl: profileController.profilePath,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: CColor.gray.withOpacity(0.3),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),




              ),
            ),
          ),
          Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                  onTap: () {
                    Get.to(const InitPresetProfileScreen());
                  },
                  child: SvgPicture.asset(CIconPath.preset))),
          Positioned(
              bottom: 10,
              right: 10,
              child: GestureDetector(
                  onTap: () async {
                    CroppedFile? croppedFile = await getImageData();
                    Get.to(CroppedImage(fileData: croppedFile!,));
                    //profileController.userSelfImage = croppedFile;
                    safePrint(profileController.userSelfImage?.path);
                    profileController.update();
                  },
                  child: SvgPicture.asset(CIconPath.gallery))),
        ],
      );
    },
  );
}

class ProfilePainter extends CustomPainter {
  const ProfilePainter();

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CColor.deepBlueBlack
      ..style = PaintingStyle.fill;
    canvas.drawPath(getPath(size.width, size.height), paint);
  }

  Path getPath(double x, double y) {
    Path path = Path()
      ..moveTo(0, y / 2)
      ..lineTo(0, 25)
      ..arcToPoint(const Offset(25, 0), radius: const Radius.circular(25))
      ..lineTo(25, 0)
      ..lineTo(x / 2, 0)
      ..lineTo(x, y / 2)
      ..lineTo(x, y - 25)
      ..arcToPoint(Offset(x - 25, y), radius: const Radius.circular(25))
      ..lineTo(x / 2, y)
      ..close();

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
