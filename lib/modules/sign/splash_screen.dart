import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shovving_pre/modules/sign/init_user_screen.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';
import '../../main.dart';
import 'sign_controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: CColor.brightGray,
          body: Column(
            children: [
              Container(
                color: Colors.transparent,
                height: 182.h,
              ),
              SizedBox(
                  width: Get.width - 40,
                  height: Get.height - 182.h - 92.h,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Positioned.fill(
                        child: Container(
                          width: Get.width - 40,
                          height: Get.height - 182.h - 92.h,
                          color: Colors.transparent,
                        ),
                      ),
                      // Positioned(
                      //   top: 0,
                      //   child: Container(
                      //     width: Get.width - 40,
                      //     height: 200,
                      //     decoration: BoxDecoration(color: CColor.red, borderRadius: const BorderRadius.all(Radius.circular(30))),
                      //
                      //   ),
                      // ),

                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(30)),
                        child: SizedBox(
                          width: Get.width - 40,
                          height: Get.height - 179.h - 95.h,
                          child: Container(
                            width: Get.width - 40,
                            height: Get.height - 179.h - 95.h,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 90.h,
                                ),
                                SizedBox(
                                    width: 140,
                                    child: Image.asset(
                                      ImagePath.splashLogo01,
                                      width: 140,
                                      fit: BoxFit.fitWidth,
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                    width: 204,
                                    child: Image.asset(
                                      ImagePath.splashLogo02,
                                      width: 204,
                                      fit: BoxFit.fitWidth,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        right: 0,
                        child: CustomPaint(
                          size: Size((Get.width - 40) / 2 + 35, (Get.width - 40) / 2 + 35),
                          painter: GuideDecorator(CColor.brightGray),
                        ),
                      ),

                      Positioned(
                        right: 0,
                        child: Container(
                          width: (Get.width - 40) / 2 + 35 - 40,
                          height: (Get.width - 40) / 2 + 35 - 40,
                          decoration: BoxDecoration(color: CColor.brightGray, borderRadius: const BorderRadius.all(Radius.circular(30))),
                        ),
                      ),
                    ],
                  )),
              Container(
                color: Colors.transparent,
                height: 92.h,
              ),
            ],
          ),
        );
      },
    );
  }
}
