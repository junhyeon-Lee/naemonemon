import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:shovving_pre/ui_helper/common_ui_helper.dart';

Widget myIndicator(){
  return Container(width: Get.width, height: Get.height,
    color: Colors.black.withOpacity(0.5),
    child: const Center(
      child: SizedBox(
          width: 60,
          child: RiveAnimation.asset(RivePath.myIndicator)),
    ),
  );
}

class IndicatorController extends GetxController{
  bool isLoading = false;

  nowLoading(){
    isLoading = true;
    update();
  }
  completeLoading(){
    isLoading = false;
    update();
  }
}